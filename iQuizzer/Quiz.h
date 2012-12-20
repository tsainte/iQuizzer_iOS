//
//  Quiz.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 13/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pergunta;

@interface Quiz : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSString * titulo;
@property (nonatomic, retain) NSString * descricao;
@property (nonatomic, retain) NSNumber * modojogo;
@property (nonatomic, retain) NSNumber * maxquestoes;
@property (nonatomic, retain) NSSet *perguntas;
@end

@interface Quiz (CoreDataGeneratedAccessors)

- (void)addPerguntasObject:(Pergunta *)value;
- (void)removePerguntasObject:(Pergunta *)value;
- (void)addPerguntas:(NSSet *)values;
- (void)removePerguntas:(NSSet *)values;

@end
