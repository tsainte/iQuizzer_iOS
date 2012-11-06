//
//  Resposta.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pergunta;

@interface Resposta : NSManagedObject

@property (nonatomic, retain) NSString * conteudo;
@property (nonatomic, retain) NSNumber * correta;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) Pergunta *pergunta;

@end
