//
//  PerguntaDAO.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Quiz.h"
#import "DAO.h"
@interface PerguntaDAO : DAO
-(Pergunta*)createPerguntaWithConteudo:(NSString*)conteudo;
-(void)saveOnCloud:(Pergunta*)pergunta;
-(NSArray*)findFromQuiz:(Quiz*)quiz;
-(void)downloadJSONPerguntas:(NSArray*)jsonPerguntas forQuiz:(Quiz*)quiz;
@end
