//
//  Quiz.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 05/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Quiz : NSManagedObject

@property (nonatomic, retain) NSString * titulo;
@property (nonatomic, retain) NSSet *perguntas;
@end

@interface Quiz (CoreDataGeneratedAccessors)

- (void)addPerguntasObject:(NSManagedObject *)value;
- (void)removePerguntasObject:(NSManagedObject *)value;
- (void)addPerguntas:(NSSet *)values;
- (void)removePerguntas:(NSSet *)values;

@end
