//
//  JogoDAO.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 28/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "JogoDAO.h"
#import "Jogo.h"
#import "Pergunta.h"
#import "Resposta.h"
@implementation JogoDAO
-(void)setEntity{
    entity = @"Jogo";
    entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:managedContext];
    entity_resultado = [NSEntityDescription entityForName:@"Resultado" inManagedObjectContext:managedContext];
}
-(Jogo*)createJogo{
    Jogo* jogo = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedContext];
    return jogo;
}
-(Resultado*)createResultado{
    Resultado* rp = [NSEntityDescription insertNewObjectForEntityForName:entity_resultado.name inManagedObjectContext:managedContext];
    return rp;
}
-(NSData*)createBody:(Jogo*)jogo{
    NSDictionary* jsonDict = [JogoDAO createJogoDictionary:jogo];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    
    return jsonData;
}
+(NSMutableDictionary*)createJogoDictionary:(Jogo*)jogo{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    NSNumber* usuario_id = [defaults objectForKey:@"usuario_id"];
    NSArray* resultados = [self createResultadoDictionary:[jogo.resultado allObjects]];
    
    NSArray* objects = [[NSArray alloc] initWithObjects:jogo.dia, jogo.hora, jogo.pontos, resultados, usuario_id, nil];
    NSArray* keys = [[NSArray alloc] initWithObjects:@"dia",@"hora",@"pontos",@"resultados_attributes", @"user_id", nil]; //chaves do app server
    
    NSMutableDictionary* jsonDict = [[NSMutableDictionary alloc] initWithObjects:objects forKeys:keys];
    return jsonDict;
}/*
+(NSMutableArray*)createResultado_PerguntasDictionary:(NSArray*)resultado_perguntas{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for(Resultado_Pergunta* rp in resultado_perguntas){
        NSArray* objects = [[NSArray alloc] initWithObjects:rp.acertou, rp.pergunta.id, nil];
        NSArray* keys = [[NSArray alloc] initWithObjects:@"acertou",@"pergunta_id", nil]; //TODO verificar pelo pergunta_id no json/rails...
        NSDictionary* dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [array addObject:dic];
        
    }
    return array;
}*/
+(NSMutableArray*)createResultadoDictionary:(NSArray*)resultados{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    for(Resultado* rp in resultados){
        NSArray* objects = [[NSArray alloc] initWithObjects:rp.resposta.id, rp.resposta.conteudo, rp.resposta.pergunta.conteudo, nil];
        NSArray* keys = [[NSArray alloc] initWithObjects:@"resposta_id", @"resposta_conteudo", @"pergunta_conteudo", nil]; //TODO verificar pelo pergunta_id no json/rails...
        NSDictionary* dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
        [array addObject:dic];
        
    }
    return array;

    
}
-(void)saveOnCloud:(Jogo*)jogo{
    [self create:jogo];
}
-(void)create:(Jogo*)jogo{
    NSString* parameters = [self getResource:@"jogos"];
    NSString* method = @"POST";
    NSData* body = [self createBody:jogo];
    
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body];
    
}
@end
