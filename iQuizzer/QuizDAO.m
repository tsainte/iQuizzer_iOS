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
+(NSArray*)findAllFromServer{
    NSManagedObjectContext* moc = [(AppDelegate*)([[UIApplication sharedApplication] delegate]) managedObjectContext];
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Quiz" inManagedObjectContext:moc];
    

    
    NSData* jsonData = [WebService getAll:@"quizzes.json"];
    NSError* error;
    NSArray* jsonArray = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    NSMutableArray* quizzes = [[NSMutableArray alloc] init];
    
    for (NSDictionary* jsonObj in jsonArray){
        Quiz* quiz = [[Quiz alloc] initWithEntity:entityDescription insertIntoManagedObjectContext:moc];
       // quiz.index = [jsonObj objectForKey:@"id"];
        quiz.titulo = [jsonObj objectForKey:@"titulo"];
        
        [quizzes addObject:quiz];
    }
    return quizzes;
}
@end
