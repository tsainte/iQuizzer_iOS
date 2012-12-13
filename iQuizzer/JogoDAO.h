//
//  JogoDAO.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 28/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"
#import "Jogo.h"
#import "Resultado.h"
@interface JogoDAO : DAO{
    NSEntityDescription* entity_resultado;
}
-(Resultado*)createResultado;
-(Jogo*)createJogo;
-(NSData*)createBody:(Jogo*)jogo;
-(void)saveOnCloud:(Jogo*)jogo;
@end
