//
//  UsuarioDAO.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 20/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "UsuarioDAO.h"

@implementation UsuarioDAO
-(void)setEntity{
    entity = @"Usuario";
    entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:managedContext];
}

Usuario* currentUsuario;
NSObject* callbackClass;
SEL callbackMethod;

-(void)login:(NSString*)username password:(NSString*)password callbackClass:(NSObject*)classCallback callbackMethod:(SEL)methodCallback{
    
    currentUsuario = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedContext];
    currentUsuario.apelido = username;
    currentUsuario.senha = password;
    
    callbackClass = classCallback;
    callbackMethod = methodCallback;
    
    NSString* parameters = @"usuarios/validate";
    NSString* method = @"PUT";
    NSData* body = [self createBody:currentUsuario];
    
    [webService RESTCommand:parameters HTTPMethod:method jsonBody:body onFinishObj:self onFinishSel:@selector(isValidLogin:)];
}
-(void)isValidLogin:(NSData*)jsonData{
    //{"success":true,"id":1}

    
    NSError* error;
    NSDictionary* jsonObj = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    NSNumber *success = [jsonObj objectForKey:@"success"];
    if ([success intValue] > 0){
        currentUsuario.id = [jsonObj objectForKey:@"id"];
        //pegar outros campos?
        [self saveContext];
    }
    NSLog(@"isValidLogin");
    //AppDelegate - login
    [callbackClass performSelector:callbackMethod withObject:currentUsuario.id];


}
-(NSData*)createBody:(Usuario*)usuario{
    NSArray* objects = [[NSArray alloc] initWithObjects:usuario.apelido, usuario.senha, nil];
    NSArray* keys = [[NSArray alloc] initWithObjects:@"apelido",@"senha", nil]; //chaves do app server
    NSDictionary* jsonDict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    
    return jsonData;
}
@end
