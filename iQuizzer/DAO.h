//
//  DAO.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DAO : NSObject{
    NSString* entity;
    NSManagedObjectContext* managedContext;
}
@property (strong) NSString* entity;
@property (strong) NSManagedObjectContext* managedContext;

-(id)initWithContext:(NSManagedObjectContext*)context;
-(id)init;
-(BOOL)saveContext;
-(void)setEntity;
+(NSManagedObjectContext*)anotherManagedContext;
@end
