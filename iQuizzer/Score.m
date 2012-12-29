//
//  Score.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 24/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "Score.h"
#import "Resposta.h"
@implementation Score
@synthesize value;
int correctValue = 10;
-(void)incrementByAwnser:(Resposta*)r{
    //tem que ter um switch de acordo com o modo
    //modo normal
    if (r.correta){
        value = [NSNumber numberWithInt:[value intValue] + correctValue];
    } 
}

@end
