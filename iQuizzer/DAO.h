//
//  DAO.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WebService.h"
@interface DAO : NSObject{
    NSString* entity;
    NSManagedObjectContext* managedContext;
    NSEntityDescription *entityDescription;
    WebService* webService;
}
@property (strong) WebService* webService;
@property (strong) NSString* entity;
@property (strong) NSManagedObjectContext* managedContext;
@property (strong) NSString* token;

-(id)initWithContext:(NSManagedObjectContext*)context;
-(id)init;
-(BOOL)saveContext;
-(void)setEntity;
+(NSManagedObjectContext*)anotherManagedContext;
-(NSArray*)findAllFromLocal;
-(NSString*)getResource:(NSString*)parameter;
@end
