//
//  Usuario.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 05/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Usuario : NSManagedObject

@property (nonatomic, retain) UNKNOWN_TYPE apelido;
@property (nonatomic, retain) UNKNOWN_TYPE nome;
@property (nonatomic, retain) UNKNOWN_TYPE sobrenome;
@property (nonatomic, retain) UNKNOWN_TYPE pontos_criador;
@property (nonatomic, retain) UNKNOWN_TYPE pontos_jogador;

@end
