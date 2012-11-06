//
//  WebService.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WebService : NSObject
+(NSData*)getAll:(NSString*)parameters;
+(void)RESTCommand:(NSString*)parameters HTTPMethod:(NSString*)method jsonBody:(NSData*)body;
@end
