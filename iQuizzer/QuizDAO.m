//
//  QuizDAO.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "QuizDAO.h"
#import "WebService.h"
#import "AppDelegate.h"
#import "Quiz.h"
#import "PerguntaDAO.h"

@implementation QuizDAO

-(NSArray*)findAllFromServer{

    NSData* jsonData = [webService get:@"quizzes.json"];
    NSError* error;
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSMutableArray* quizzes = [[NSMutableArray alloc] init];
    
    for (NSDictionary* jsonObj in jsonArray){
        Quiz* quiz = [[Quiz alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:nil];
        quiz.index = [jsonObj objectForKey:@"id"];
        quiz.titulo = [jsonObj objectForKey:@"titulo"];
        
        [quizzes addObject:quiz];
    }
    return quizzes;
}
-(Quiz*)find:(NSNumber*)index{


    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSString* textPredicate= [NSString stringWithFormat:@"(index = %d)",  [index intValue]];
    

    //cria predicate e associa ao fetch request
    NSPredicate* predicate = [NSPredicate predicateWithFormat:textPredicate];
    request.predicate = predicate;
    //executa e recarrega tabela
    NSError* error;
    NSArray* results = [managedContext executeFetchRequest:request error:&error];
    if (results.count == 1) {
        return [results objectAtIndex:0];
    }
    return nil;
}
-(Quiz*)createQuizWithTitulo:(NSString*)titulo {

    Quiz* quiz = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedContext];
    quiz.titulo = titulo;
    return quiz;
}
-(BOOL)insertQuizWithTitulo:(NSString*)titulo{
    [self createQuizWithTitulo:titulo];
    return [self saveContext];
}
-(void)setEntity{
    entity = @"Quiz";
    entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:managedContext];
}
-(void)saveOnCloud:(Quiz*)quiz{
    if ([quiz.index intValue] > 0) { //update, e TODO refazer gamba
        [self update:quiz];
    } else {
        [self create:quiz];
    }
}

Quiz* currentQuiz;

-(void)create:(Quiz*)quiz{
    NSString* parameters = @"quizzes";
    NSString* method = @"POST";
    NSData* body = [self createBody:quiz];
    
    currentQuiz = quiz;
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body onFinishObj:self onFinishSel:@selector(atualizarID:)];
    
}
-(void)atualizarID:(NSData*)jsonData{
    NSError* error;
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSLog(@"the id: %@", [[jsonObj objectForKey:@"id"] description]);
    currentQuiz.index = [jsonObj objectForKey:@"id"];
    [self saveContext];
}
-(void)update:(Quiz*)quiz{
    NSString* parameters = [NSString stringWithFormat:@"quizzes/%d",[quiz.index intValue]];
    NSString* method = @"PUT";
    NSData* body = [self createBody:quiz];
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body];
}
-(void)remove:(Quiz*)quiz{
   //apagando do servidor
    NSString* parameters = [NSString stringWithFormat:@"quizzes/%d",[quiz.index intValue]];
    NSString* method = @"DELETE";
    NSData* body = [self createBody:quiz];
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body];
    
    //apagando local
    [managedContext deleteObject:quiz];
    [self saveContext];
    
    
}
-(NSData*)createBody:(Quiz*)quiz{
    NSDictionary* jsonDict = [QuizDAO createDictionary:quiz];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    
    return jsonData;
}
+(NSMutableDictionary*)createDictionary:(Quiz*)quiz{
    NSArray* objects = [[NSArray alloc] initWithObjects:quiz.index.description, quiz.titulo, nil];
    NSArray* keys = [[NSArray alloc] initWithObjects:@"id",@"titulo", nil]; //chaves do app server
    
    NSMutableDictionary* jsonDict = [[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
    return jsonDict;
}
-(BOOL)downloadQuiz:(NSNumber*)ID{
    NSString* param = [NSString stringWithFormat:@"%@/%d.json", @"quizzes", [ID intValue]];
    NSData* jsonData = [webService get:param];
    
    NSLog(@"jsondownloaded: %@", [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);
    NSError* error;
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSDictionary* jsonQuiz = [jsonObj objectForKey:@"quiz"];
    
    Quiz* quiz = [[Quiz alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedContext];

    quiz.titulo = [jsonQuiz objectForKey:@"titulo"];
    quiz.index = [jsonQuiz objectForKey:@"id"];

    PerguntaDAO* perguntaDAO = [[PerguntaDAO alloc] init];
    [perguntaDAO downloadJSONPerguntas:[jsonQuiz objectForKey:@"perguntas"] forQuiz:quiz];
    
    return [self saveContext];

}
-(NSArray*)findAllFromLocal{
    //condições de consulta - findAll
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    [fetchRequest setEntity:entityDescription];
    //execução da consulta
    NSError* error;
    
    //esse codigo eh gambiarra
    NSMutableArray* wReturn = [[NSMutableArray alloc] init];
    for (Quiz* q in [managedContext executeFetchRequest:fetchRequest error:&error]){
        if ([q.index intValue] > 0){
            [wReturn addObject:q];
        }
    }
    return wReturn;
}
//teste para inserir pergunta
-(NSData*)createBody2:(Quiz*)quiz{
    //respostas
    NSArray* o2 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:7],@"respostaa teste deu certo e eu alterei!", nil];
    NSArray* k2 = [[NSArray alloc] initWithObjects:@"id",@"conteudo", nil];
    
    NSDictionary* resposta = [[NSDictionary alloc] initWithObjects:o2 forKeys:k2];
    NSArray* respostas = [[NSArray alloc] initWithObjects:resposta, nil];
    
    
    //perguntas
    NSArray* o1 = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:10],@"pergunta1 teste deu certo e eu alterei!", respostas, nil];
    NSArray* k1 = [[NSArray alloc] initWithObjects:@"id",@"conteudo", @"respostas_attributes", nil];
    
  //  NSArray* o1 = [[NSArray alloc] initWithObjects:@"pergunta1 teste deu certo!", nil];
  //  NSArray* k1 = [[NSArray alloc] initWithObjects:@"conteudo", nil];
    
    
    NSDictionary* pergunta = [[NSDictionary alloc] initWithObjects:o1 forKeys:k1];
    NSArray* perguntas = [[NSArray alloc] initWithObjects:pergunta, nil];
    
    
    NSArray* objects = [[NSArray alloc] initWithObjects:quiz.index.description, quiz.titulo, perguntas, nil];
    NSArray* keys = [[NSArray alloc] initWithObjects:@"id",@"titulo",@"perguntas_attributes", nil]; //chaves do app server
    
    NSDictionary* jsonDict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    
    NSString* str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"json: %@",str);
    
    return jsonData;
}
@end
