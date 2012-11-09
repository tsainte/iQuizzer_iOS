//
//  WebService.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "WebService.h"

@implementation WebService
static NSString *const ip = @"localhost";
static int port = 3000;

//static NSString *const ip = @"iquizzer.herokuapp.com";
//static int port = 80;
+(NSData*)get:(NSString*)parameters{
    NSString* urlString = [NSString stringWithFormat:@"http://%@:%d/%@", ip,port,parameters];
    NSURL* url = [NSURL URLWithString:urlString];
    NSData* data = [NSData dataWithContentsOfURL:url];
    return data;
}
+(void)RESTCommand:(NSString*)parameters HTTPMethod:(NSString*)method jsonBody:(NSData*)body{
    
    //mount parameters
    NSString* urlstring = [NSString stringWithFormat:@"http://%@:%d/%@",ip,port,parameters];
    
    NSURL* url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:url];
    
    [theRequest setHTTPBody: body];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPMethod:method];
    
    //make connection
    NSURLConnection *theConnection = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
    if(theConnection)
        NSLog(@"Connection ok");
    else
        NSLog(@"Connection is NULL");
}
@end
