//
//  QuizDAO.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"
#import "Quiz.h"
@interface QuizDAO : DAO

-(NSArray*)findAllFromServer;
-(Quiz*)createQuizWithTitulo:(NSString*)titulo;
-(void)saveOnCloud:(Quiz*)quiz;
-(BOOL)downloadQuiz:(NSNumber*)ID;
-(Quiz*)find:(NSNumber*)index;
@end
