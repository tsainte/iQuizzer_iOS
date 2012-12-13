//
//  Resultado.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Resposta;

@interface Resultado : NSManagedObject

@property (nonatomic, retain) Resposta *resposta;

@end
