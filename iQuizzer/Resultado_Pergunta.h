//
//  Resultado_Pergunta.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 28/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Pergunta;

@interface Resultado_Pergunta : NSManagedObject

@property (nonatomic, retain) NSNumber *acertou;
@property (nonatomic, retain) Pergunta *pergunta;

@end
