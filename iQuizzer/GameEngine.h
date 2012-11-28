//
//  GameEngine.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 26/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quiz.h"
#import "Pergunta.h"
#import "Resposta.h"
@interface GameEngine : NSObject

@property NSInteger currentRound;

@property NSInteger maxRounds;
@property NSInteger maxTimePerRound;
@property NSInteger score;

@property (strong) Quiz* quiz;
@property (strong) NSMutableArray* perguntas;

-(id)initWithQuiz:(Quiz*)quiz;
-(void)start;
-(Pergunta*)pushPergunta;
@end
