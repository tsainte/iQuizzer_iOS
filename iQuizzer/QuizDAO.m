//
//  QuizDAO.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "QuizDAO.h"
#import "WebService.h"
#import "AppDelegate.h"
#import "Quiz.h"

@implementation QuizDAO

-(NSArray*)findAllFromServer{
    
    
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:entity inManagedObjectContext:managedContext];
    
    NSData* jsonData = [WebService getAll:@"quizzes.json"];
    NSError* error;
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSMutableArray* quizzes = [[NSMutableArray alloc] init];
    
    for (NSDictionary* jsonObj in jsonArray){
        Quiz* quiz = [[Quiz alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:managedContext];
       // quiz.index = [jsonObj objectForKey:@"id"];
        quiz.titulo = [jsonObj objectForKey:@"titulo"];
        
        [quizzes addObject:quiz];
    }
    return quizzes;
}
-(NSArray*)findAllFromLocal{
    
}
-(Quiz*)createQuizWithTitulo:(NSString*)titulo {

    Quiz* quiz = [NSEntityDescription insertNewObjectForEntityForName:entity inManagedObjectContext:managedContext];
    quiz.titulo = titulo;
    return quiz;
}
-(BOOL)insertQuizWithTitulo:(NSString*)titulo{
    [self createQuizWithTitulo:titulo];
    return [self saveContext];
}
-(void)setEntity{
    entity = @"Quiz";
}
-(void)saveOnCloud:(Quiz*)quiz{
    if ([quiz.index intValue] > 0) { //update, e TODO refazer gamba
        [self update:quiz];
    } else {
        [self create:quiz];
    }
}
-(void)create:(Quiz*)quiz{
    NSString* parameters = @"quizzes";
    NSString* method = @"POST";
    NSData* body = [self createBody:quiz];
    [WebService RESTCommand:parameters HTTPMethod:method jsonBody:body];
}
-(void)update:(Quiz*)quiz{
    NSString* parameters = @"quizzes/id"; //TODO REFAZER O ID..
    NSString* method = @"PUT";
    NSData* body = [self createBody:quiz];
    [WebService RESTCommand:parameters HTTPMethod:method jsonBody:body];
}
-(NSData*)createBody:(Quiz*)quiz{
    NSArray* objects = [[NSArray alloc] initWithObjects:quiz.index.description, quiz.titulo, nil];
    NSArray* keys = [[NSArray alloc] initWithObjects:@"id",@"titulo", nil]; //chaves do app server
    
    NSDictionary* jsonDict = [[NSDictionary alloc] initWithObjects:objects forKeys:keys];
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:jsonDict options:kNilOptions error:nil];
    
    return jsonData;
}
@end
