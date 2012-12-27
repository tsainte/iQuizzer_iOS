//
//  Authenticator.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 26/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebService.h"
@interface Authenticator : NSObject
@property (strong) WebService* webService;

-(void)login:(NSString*)pUsername password:(NSString*)password callbackClass:(NSObject*)pCallbackClass callbackMethod:(SEL)pCallbackMethod;
@end
