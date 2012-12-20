//
//  UsuarioDAO.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 20/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DAO.h"
#import "Usuario.h"
@interface UsuarioDAO : DAO{
    
}
-(void)login:(NSString*)username password:(NSString*)password callbackClass:(NSObject*)classCallback callbackMethod:(SEL)methodCallback;
@end
