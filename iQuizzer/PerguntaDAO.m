//
//  PerguntaDAO.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "PerguntaDAO.h"
#import "Pergunta.h"
#import "QuizDAO.h"
@implementation PerguntaDAO
-(void)setEntity{
    entity = @"Pergunta";
    entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:managedContext];
}
-(Pergunta*)createPerguntaWithConteudo:(NSString*)conteudo {
    
    Pergunta* pergunta = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedContext];
    pergunta.conteudo = conteudo;
    return pergunta;
}
-(NSArray*)findFromQuiz:(Quiz*)quiz{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSString* textPredicate= [NSString stringWithFormat:@"(quiz.index = %d)",  [quiz.index intValue]];
    
    
    //cria predicate e associa ao fetch request
    NSPredicate* predicate = [NSPredicate predicateWithFormat:textPredicate];
    request.predicate = predicate;
    
    //executa e recarrega tabela
    NSError* error;
    NSArray* results = [managedContext executeFetchRequest:request error:&error];
    return results;
}
-(BOOL)insertPerguntaWithConteudo:(NSString*)conteudo{
    [self createPerguntaWithConteudo:conteudo];
    return [self saveContext];
}
-(void)saveOnCloud:(Pergunta*)pergunta{

    if ([pergunta.id intValue] > 0) { //update, e TODO refazer gamba
        [self update:pergunta];
    } else {
        [self insert:pergunta];
    }
}


Pergunta* currentPergunta;
-(void)insert:(Pergunta*)pergunta{
    NSString* parameters = [NSString stringWithFormat:@"quizzes/%d",[pergunta.quiz.index intValue]];
    NSString* method = @"PUT"; //update do quiz
    NSData* body = [self createBody:pergunta];
    
    //por enquanto só adiciona uma pergunta por vez...
    currentPergunta = pergunta;
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body onFinishObj:self onFinishSel:@selector(atualizarID:)];
}
-(void)atualizarID:(NSData*)jsonData{
    NSError* error;
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSArray* perguntas = [jsonObj objectForKey:@"perguntas"];
    //por enquanto só adiciona uma pergunta por vez...
    NSDictionary* pergunta = [perguntas objectAtIndex:0];
    currentPergunta.id = [pergunta objectForKey:@"id"];
    [self saveContext];
}

-(void)update:(Pergunta*)pergunta{

    NSString* parameters = [NSString stringWithFormat:@"quizzes/%d",[pergunta.quiz.index intValue]];
    NSString* method = @"PUT"; 
    NSData* body = [self createBody:pergunta];
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body];
}
//teste para manter pergunta
-(NSData*)createBody:(Pergunta*)pergunta{
    NSLog(@"body");
    NSMutableArray* objects = [[NSMutableArray alloc] init];
    NSMutableArray* keys = [[NSMutableArray alloc] init];
    
    //conteudo
    [objects addObject:pergunta.conteudo];
    [keys addObject:@"conteudo"];
    
    //id, se houver
    if ([[pergunta id] intValue] > 0){
        [objects addObject:pergunta.id];
        [keys addObject:@"id"];
    }
    
    //respostas
    if ([pergunta.resposta count] > 0){
        [objects addObject:pergunta.resposta];
        [keys addObject:@"respostas_attributes"];
    }
    
    //criando array de perguntas
    NSDictionary* jsonPergunta = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    NSArray* perguntas = [[NSArray alloc] initWithObjects:jsonPergunta, nil];
    
    //criando array do quiz - nested attribute
    NSMutableDictionary* jsonDict = [QuizDAO createDictionary:pergunta.quiz];
    [jsonDict setObject:perguntas forKey:@"perguntas_attributes"];
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    
    NSString* str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"json: %@",str);
    
    return jsonData;
}

@end
