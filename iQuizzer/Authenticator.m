//
//  Authenticator.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 26/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "Authenticator.h"
#import "UsuarioDAO.h"
@implementation Authenticator
@synthesize webService;


NSObject* callbackClass;
SEL callbackMethod;
NSString* username;
NSString* password;

-(void)login:(NSString*)pUsername password:(NSString*)password callbackClass:(NSObject*)pCallbackClass callbackMethod:(SEL)pCallbackMethod{
    username = pUsername;
    
    callbackClass = pCallbackClass;
    callbackMethod = pCallbackMethod;
    
    NSString* parameters = @"api/v1/tokens.json";
    NSString* method = @"POST";
    NSData* body = [self createBody:username password:password];
    
    webService = [[WebService alloc] init];
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body onFinishObj:self onFinishSel:@selector(isValidLogin:)];
    
    
}
-(void)isValidLogin:(NSData*)jsonData{
    //{"success":true,"id":1}
    NSNumber* index;
    NSString* errorMessage;
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSError* error;
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    NSString *token = [jsonObj objectForKey:@"token"];
    
    if (token){
        UsuarioDAO* dao = [[UsuarioDAO alloc] init];
        index = [jsonObj objectForKey:@"id"];
        [dao insert:index username:username password:@"" token:token]; //nao guardando password
        
        
        [defaults setObject:username forKey:@"username"];
        [defaults setObject:index forKey:@"usuario_id"];
        [defaults setObject:token forKey:@"token"];
        NSLog(@"gravei o token: %@", [defaults objectForKey:@"token"]);
        [defaults setBool:YES forKey:@"isAuth"];
        [callbackClass performSelector:callbackMethod withObject:index];
    } else {
        errorMessage = [jsonObj objectForKey:@"message"];
        [defaults setBool:NO forKey:@"isAuth"];
        [callbackClass performSelector:callbackMethod withObject:errorMessage];
    }
}
-(void)logout{
    
}
-(NSData*)createBody:(NSString*)username password:(NSString*)password{
    NSArray* objects = [[NSArray alloc] initWithObjects:username, password, nil];
    NSArray* keys = [[NSArray alloc] initWithObjects:@"username",@"password", nil]; //chaves do app server
    NSDictionary* jsonDict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    
    return jsonData;
}
@end
