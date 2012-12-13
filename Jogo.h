//
//  Jogo.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Resultado;

@interface Jogo : NSManagedObject

@property (nonatomic, retain) NSString * dia;
@property (nonatomic, retain) NSString * hora;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * pontos;
@property (nonatomic, retain) NSSet *resultado;
@end

@interface Jogo (CoreDataGeneratedAccessors)

- (void)addResultadoObject:(Resultado *)value;
- (void)removeResultadoObject:(Resultado *)value;
- (void)addResultado:(NSSet *)values;
- (void)removeResultado:(NSSet *)values;

@end
