//
//  RespostaDAO.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "RespostaDAO.h"
#import "Pergunta.h"
#import "Quiz.h"
#import "QuizDAO.h"
@implementation RespostaDAO
-(void)setEntity{
    entity = @"Resposta";
    entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:managedContext];
}
-(Resposta*)createRespostaWithConteudo:(NSString*)conteudo correta:(BOOL)correta{
    
    Resposta* resposta = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedContext];
    resposta.conteudo = conteudo;
    resposta.correta = [NSNumber numberWithBool:correta];
    return resposta;
}
-(NSArray*)findFromPergunta:(Pergunta*)pergunta{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    NSString* textPredicate= [NSString stringWithFormat:@"(pergunta_id == %d)",  [pergunta.id intValue]];
    
    
    //cria predicate e associa ao fetch request
    NSPredicate* predicate = [NSPredicate predicateWithFormat:textPredicate];
    request.predicate = predicate;
    
    //executa e recarrega tabela
    NSError* error;
    NSArray* results = [managedContext executeFetchRequest:request error:&error];
    return results;
}

-(void)saveOnCloud:(Resposta*)resposta{
    
    if ([resposta.id intValue] > 0) { //update, e TODO refazer gamba
        [self update:resposta];
    } else {
        [self insert:resposta];
    }
}

Resposta* currentResposta;

//acho que nao tem esse lance de insert/update para respostas..
-(void)insert:(Resposta*)resposta{
    NSString* parameters = [NSString stringWithFormat:@"quizzes/%d",[resposta.pergunta.quiz.index intValue]];
    NSString* method = @"PUT"; //update do quiz
    NSData* body = [self createBody:resposta];
    
    //por enquanto só adiciona uma pergunta por vez...
    currentResposta = resposta;
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body onFinishObj:self onFinishSel:@selector(atualizarID:)];
}
-(void)atualizarID:(NSData*)jsonData{
    NSError* error;
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSArray* respostas = [jsonObj objectForKey:@"perguntas"];
    //por enquanto só adiciona uma pergunta por vez...
    NSDictionary* resposta = [respostas objectAtIndex:0];
    currentResposta.id = [resposta objectForKey:@"id"];
    [self saveContext];
}



-(void)downloadJSONRespostas:(NSArray*)jsonRespostas forPergunta:(Pergunta*)pergunta{
    for (NSDictionary* jsonResposta in jsonRespostas){
        Resposta* resposta= [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedContext];
        resposta.conteudo = [jsonResposta objectForKey:@"conteudo"];
        resposta.id = [jsonResposta objectForKey:@"id"];
        resposta.correta = [jsonResposta objectForKey:@"correta"];
        resposta.pergunta = pergunta;
        
        [self saveContext];
    }
}

-(void)update:(Resposta*)resposta{
    
    NSString* parameters = [NSString stringWithFormat:@"quizzes/%d",[resposta.pergunta.quiz.index intValue]];
    NSString* method = @"PUT";
    NSData* body = [self createBody:resposta];
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body];
}
//teste para manter resposta



// -------- nada feito ainda -------------


-(NSData*)createBody:(Resposta*)resposta{
   //TODO pegar isso do PerguntaDAO...
    Pergunta* pergunta = resposta.pergunta;
    
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
