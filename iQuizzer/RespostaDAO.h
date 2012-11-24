//
//  RespostaDAO.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"
#import "Resposta.h"
@interface RespostaDAO : DAO
-(NSArray*)findFromPergunta:(Pergunta*)pergunta;
-(Resposta*)createRespostaWithConteudo:(NSString*)conteudo correta:(BOOL)correta;
-(void)saveOnCloud:(Resposta*)resposta;
@end
