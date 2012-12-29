//
//  Score.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 24/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Resposta.h"
@interface Score : NSObject
@property NSInteger mode;
@property NSNumber* value;

@property NSInteger* timer; //nao implementado ainda
-(void)increment;
-(void)incrementByAwnser:(Resposta*)r;
@end
