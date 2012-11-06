//
//  Pergunta.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Quiz, Resposta;

@interface Pergunta : NSManagedObject

@property (nonatomic, retain) NSString * conteudo;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) Quiz *quiz;
@property (nonatomic, retain) NSSet *resposta;
@end

@interface Pergunta (CoreDataGeneratedAccessors)

- (void)addRespostaObject:(Resposta *)value;
- (void)removeRespostaObject:(Resposta *)value;
- (void)addResposta:(NSSet *)values;
- (void)removeResposta:(NSSet *)values;

@end
