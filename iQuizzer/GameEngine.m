//
//  GameEngine.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 26/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "GameEngine.h"
#import "PerguntaDAO.h"
#import "Jogo.h"
#import "Resultado.h"
#import "Functions.h"


@implementation GameEngine
@synthesize currentRound;
@synthesize maxRounds, maxTimePerRound, score;
@synthesize quiz,perguntas, resultados, jogo, jogoDAO;

-(id)initWithQuiz:(Quiz*)pQuiz{

    if (self = [super init]){
        self.quiz = pQuiz;
        [self initParameters];
        [self start];
    }
    return self;
}
//isso deve vir de um plist ou de uma tela de settings
-(void)initParameters{
    currentRound = 0;
    maxRounds = [self.quiz.maxquestoes integerValue];
    NSLog(@"maxrounds: %d", maxRounds);
    NSLog(@"str maxrounds: %@", [self.quiz.maxquestoes description]);
    NSLog(@"str titulo: %@", [self.quiz.titulo description]);
    maxTimePerRound = 10; //nao usado ainda
    score = 0;
}
-(void)start{
    jogoDAO = [[JogoDAO alloc] init];
    jogo = [jogoDAO createJogo];
    
    perguntas = [self getPerguntasForMode:[self.quiz.modojogo intValue]];

    resultados = [[NSMutableArray alloc] init];
    
}
-(NSMutableArray*)getPerguntasForMode:(int)modojogo{
    PerguntaDAO* perguntaDAO = [[PerguntaDAO alloc] init];
    NSMutableArray* lePerguntas;
    switch (modojogo) {
        case 1: //random e sem tempo
            lePerguntas = [[NSMutableArray alloc] initWithArray:[perguntaDAO getRandomPerguntasFromQuiz:quiz quantity:maxRounds]];
            break;
        case 2: //na ordem
                        lePerguntas = [[NSMutableArray alloc] initWithArray:[perguntaDAO getRandomPerguntasFromQuiz:quiz quantity:maxRounds]];
            //lePerguntas = [[NSMutableArray alloc] initWithArray:[perguntaDAO getPerguntasFromQuiz:quiz quantity:maxRounds]];
            break;
        default:
            lePerguntas = [[NSMutableArray alloc] initWithArray:[perguntaDAO getRandomPerguntasFromQuiz:quiz quantity:maxRounds]];
            break;
    }
    return lePerguntas;
}
-(Pergunta*)popPergunta{
    Pergunta* pergunta;
    @try {
        pergunta = [perguntas objectAtIndex:0];
        [perguntas removeObjectAtIndex:0];
    }
    @catch (NSException *exception) {
        pergunta = nil;
    }
    return pergunta;
}
//-(void)pushResultado:(Pergunta*)pergunta resultado:(BOOL)resultado{
-(void)pushResultado:(Resposta*)resposta{
    Resultado* rp = [jogoDAO createResultado];
    //rp.pergunta = pergunta;
    //rp.acertou = [NSNumber numberWithBool:resultado];
    //TODO rp.resposta = resposta;
    rp.resposta = resposta;
    [jogo addResultadoObject:rp];
}
-(void)saveResults{
    //TODO refatorar para utilizar UTC
    jogo.dia = [Functions currentDate];
    jogo.hora = [Functions currentTime];
    
    jogo.pontos = [NSNumber numberWithInt:0]; //TODO criar objeto de pontuacao
    
    //NSLog(@"game of jsons: %@", [[NSString alloc] initWithData:[jogoDAO createBody:jogo] encoding:NSUTF8StringEncoding]);
    
    [jogoDAO saveOnCloud:jogo];
    /*
    NSError* error;
    if (![jogoDAO.managedContext save:&error]){
        NSLog(@"%@", [error description]);
    } else { //se tudo ok, envia pra nuvem
        NSLog(@"envia pra nuvem...");
    }*/
}
@end
