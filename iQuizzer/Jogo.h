//
//  Jogo.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 28/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Resultado_Pergunta;

@interface Jogo : NSManagedObject

@property (nonatomic, retain) NSString * dia;
@property (nonatomic, retain) NSString * hora;
@property (nonatomic, retain) NSNumber * pontos;
@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) Resultado_Pergunta *resultado_pergunta;

@end
