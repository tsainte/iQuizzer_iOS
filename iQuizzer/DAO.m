//
//  DAO.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "DAO.h"
#import "AppDelegate.h"

@implementation DAO
@synthesize managedContext, entity;

-(id)initWithContext:(NSManagedObjectContext*)context{
    if (self = [super init]){
        self.managedContext = context;
        [self setEntity];
    }
    return self;
}
-(id)init{
    if (self = [super init]){
        self.managedContext = [(AppDelegate*)([[UIApplication sharedApplication] delegate]) managedObjectContext];
        [self setEntity];
    }
    return self;
}
-(BOOL)saveContext{
    NSError* error;
    BOOL wSuccess = [managedContext save:&error];
    if (!wSuccess){
        NSLog(@"Não foi possível salvar: %@",[error localizedDescription]);
    }
    return wSuccess;
}
+(NSManagedObjectContext*)anotherManagedContext{
    AppDelegate* app = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    return [app anotherManagedObjectContext];
}
@end
