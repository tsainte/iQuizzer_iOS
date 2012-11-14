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
id finishObj;
SEL finishSel;
bool hasCallback = NO;
-(NSData*)get:(NSString*)parameters{
    NSString* urlString = [NSString stringWithFormat:@"http://%@:%d/%@", ip,port,parameters];
    NSURL* url = [NSURL URLWithString:urlString];
    NSData* data = [NSData dataWithContentsOfURL:url];
    return data;
}
-(void)RESTCommand:(NSString*)parameters HTTPMethod:(NSString*)method jsonBody:(NSData*)body onFinishObj:(id)obj onFinishSel:(SEL)sel{
    finishObj = obj;
    finishSel = sel;
    hasCallback = YES;
    [self RESTCommand:parameters HTTPMethod:method jsonBody:body];
    
}
-(void)RESTCommand:(NSString*)parameters HTTPMethod:(NSString*)method jsonBody:(NSData*)body{
    
    //mount parameters
    NSString* urlstring = [NSString stringWithFormat:@"http://%@:%d/%@",ip,port,parameters];
    
    NSURL* url = [NSURL URLWithString:urlstring];
    NSMutableURLRequest* theRequest = [NSMutableURLRequest requestWithURL:url];
    
    [theRequest setHTTPBody: body];
    [theRequest setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [theRequest setHTTPMethod:method];
    
    //make connection
    NSURLConnection *theConnection = [[NSURLConnection alloc]initWithRequest:theRequest delegate:self];
    if(theConnection){
        NSLog(@"Connection ok");
        receivedData = [[NSMutableData alloc] init];
    }
    else
        NSLog(@"Connection is NULL");
}
NSMutableData* receivedData;

-(void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    if (receivedData){
        [receivedData appendData:data];
    }
}
-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
    if (hasCallback){
        [finishObj performSelector:finishSel withObject:receivedData];
        hasCallback= NO;
    }

}
-(NSData*)receivedData{
    return receivedData;
}
@end
