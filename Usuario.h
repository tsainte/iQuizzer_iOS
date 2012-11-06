//
//  Usuario.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Usuario : NSManagedObject

@property (nonatomic, retain) NSString * apelido;
@property (nonatomic, retain) NSString * nome;
@property (nonatomic, retain) NSNumber * sobrenome;
@property (nonatomic, retain) NSNumber * pontos_criador;
@property (nonatomic, retain) NSNumber * pontos_jogador;
@property (nonatomic, retain) NSNumber * id;

@end
