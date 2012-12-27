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
#import "Resposta.h"
#import "RespostaDAO.h"
#import "Functions.h"
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

-(void)downloadJSONPerguntas:(NSArray*)jsonPerguntas forQuiz:(Quiz*)quiz{
    for (NSDictionary* jsonPergunta in jsonPerguntas){
        Pergunta* pergunta = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedContext];
        pergunta.conteudo = [jsonPergunta objectForKey:@"conteudo"];
        pergunta.id = [jsonPergunta objectForKey:@"id"];
        pergunta.quiz = quiz;
        
        RespostaDAO* respostaDAO = [[RespostaDAO alloc] init];
        [respostaDAO downloadJSONRespostas:[jsonPergunta objectForKey:@"respostas"] forPergunta:pergunta];
        [self saveContext];
    }
}
-(void)saveOnCloud:(Pergunta*)pergunta{

    if ([pergunta.id intValue] > 0) { //update, e TODO refazer gamba
        [self update:pergunta];
    } else {
        [self insert:pergunta];
    }
}
-(void)saveRespostaOnCloud:(Pergunta*)pergunta{
    
    [self updateResposta:pergunta];
}
-(void)updateResposta:(Pergunta*)pergunta{
    NSString* parameters = [self getResource:[NSString stringWithFormat:@"quizzes/%d",[pergunta.quiz.index intValue]]];
    NSString* method = @"PUT"; //update do quiz
    NSData* body = [self createBody:pergunta];
    
    //por enquanto só adiciona uma pergunta por vez...
    currentPergunta = pergunta;
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body onFinishObj:self onFinishSel:@selector(atualizarRespostasID:)];
}
Pergunta* currentPergunta;
Resposta* currentResposta;
-(void)insert:(Pergunta*)pergunta{
    NSString* parameters = [self getResource:[NSString stringWithFormat:@"quizzes/%d",[pergunta.quiz.index intValue]]];
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
    
    //[self atualizarRespostasID:[jsonObj objectForKey:@"respostas"]];
    [self saveContext];
}
-(void)atualizarRespostasID:(NSData*)jsonData{
    NSError* error;
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSArray* respostas = [jsonObj objectForKey:@"respostas"];
    //esse for só existe se tiver uma (somente uma) repossta para adicionar
    for (NSDictionary* resposta in respostas){
        //por enquanto so adiciona uma resposta por vez, entao ta ok isso...
        currentResposta.id = [resposta objectForKey:@"id"];
        NSLog(@"le id: %d", [currentResposta.id intValue]);
    }
    //save context on return...
    [self saveContext];
}
-(void)update:(Pergunta*)pergunta{

    NSString* parameters = [self getResource:[NSString stringWithFormat:@"quizzes/%d",[pergunta.quiz.index intValue]]];
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
        NSMutableArray* respostas = [[NSMutableArray alloc] init];
        for (Resposta* r in pergunta.resposta){
            NSDictionary* respostaDict;
            //update
            if ([r.id intValue] > 0){
               respostaDict = [[NSDictionary alloc] initWithObjectsAndKeys:r.conteudo, @"conteudo", r.correta, @"correta", r.id, @"id", nil];
            } 
            //insert
            else {
                respostaDict = [[NSDictionary alloc] initWithObjectsAndKeys:r.conteudo, @"conteudo", r.correta, @"correta", nil];
            }
            [respostas addObject:respostaDict];
        }
        [objects addObject:respostas];
        [keys addObject:@"respostas_attributes"];
    }
    
    //criando array de perguntas
    NSDictionary* jsonPergunta = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    NSArray* perguntas = [[NSArray alloc] initWithObjects:jsonPergunta, nil];
    
    //criando array do quiz - nested attribute
    NSMutableDictionary* jsonDict = [QuizDAO createDictionary:pergunta.quiz];
    [jsonDict setObject:perguntas forKey:@"perguntas_attributes"];
    
    NSLog(@"jsondict: %@", [jsonDict description]);
    
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    
    NSString* str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    NSLog(@"json: %@",str);
    
    return jsonData;
}
-(void)setCurrentResposta:(Resposta*)resposta{
    currentResposta = resposta;
}
-(NSArray*)getRandomPerguntasFromQuiz:(Quiz*)quiz quantity:(NSInteger)qtd {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString* textPredicate= [NSString stringWithFormat:@"(quiz.index = %d)",  [quiz.index intValue]];
	
    [request setEntity:entityDescription];
	//[request setFetchLimit:qtd];
    [request setPredicate:[NSPredicate predicateWithFormat:textPredicate]];
    

	NSError *error = nil;
    NSArray *fetchResults = [managedContext executeFetchRequest:request error:&error];
    
    NSMutableArray* wReturn = [[NSMutableArray alloc] init];

    
    for (int i = 0; i < qtd; i++){
        [wReturn addObject:[fetchResults objectAtIndex:arc4random() % fetchResults.count]];
        //TODO fazer algoritmo para evitar/minimizar repetição
    }
	return wReturn;
}
-(NSArray*)getPerguntasFromQuiz:(Quiz*)quiz quantity:(NSInteger)qtd {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSString* textPredicate= [NSString stringWithFormat:@"(quiz.index = %d)",  [quiz.index intValue]];
	
    [request setEntity:entityDescription];
	//[request setFetchLimit:qtd];
    [request setPredicate:[NSPredicate predicateWithFormat:textPredicate]];
    
    
	NSError *error = nil;
    NSArray *fetchResults = [managedContext executeFetchRequest:request error:&error];
    
    NSMutableArray* wReturn = [[NSMutableArray alloc] init];
    
    int j = 0;
    for (int i = 0; i < qtd; i++){
        [wReturn addObject:[fetchResults objectAtIndex:j]];
        
        //gamb pra repetir as pergunas caso elas acabem...
        j++;
        if (j == [fetchResults count]){
            j = 0;
        }
    }
	return wReturn;
}
@end
