//
//  Functions.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 27/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "Functions.h"

@implementation Functions
+(NSArray*)shuffle:(NSMutableArray*)array{
    for (int x = 0; x < [array count]; x++) {
        int randInt = (arc4random() % ([array count] - x)) + x;
        [array exchangeObjectAtIndex:x withObjectAtIndex:randInt];
    }
    return array;
}

@end
