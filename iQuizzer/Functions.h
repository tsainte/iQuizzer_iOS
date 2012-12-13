//
//  Functions.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 27/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Functions : NSObject
+(NSArray*)shuffle:(NSMutableArray*)array;
+(NSString*)currentDate;
+(NSString*)currentTime;
+(void)alert:(NSString*)message;
@end
