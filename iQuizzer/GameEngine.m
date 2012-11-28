//
//  GameEngine.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 26/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "GameEngine.h"
#import "PerguntaDAO.h"

@implementation GameEngine
@synthesize currentRound;
@synthesize maxRounds, maxTimePerRound, score;
@synthesize quiz,perguntas;

-(id)initWithQuiz:(Quiz*)pQuiz{
    if (self = [super init]){
        [self initParameters];
        self.quiz = pQuiz;
        [self start];
    }
    return self;
}
//isso deve vir de um plist ou de uma tela de settings
-(void)initParameters{
    currentRound = 0;
    maxRounds = 5;
    maxTimePerRound = 10; //nao usado ainda
    score = 0;
}
-(void)start{
    PerguntaDAO* dao = [[PerguntaDAO alloc] init];
    perguntas = [[NSMutableArray alloc] initWithArray:[dao getRandomPerguntasFromQuiz:quiz quantity:maxRounds]];
}
-(Pergunta*)pushPergunta{
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

@end
