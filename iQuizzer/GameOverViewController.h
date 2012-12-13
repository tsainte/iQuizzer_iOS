//
//  GameOverViewController.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 03/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Jogo.h"
@interface GameOverViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *txtAcertos;
@property (strong, nonatomic) IBOutlet UILabel *txtErros;
@property (strong, nonatomic) IBOutlet UILabel *txtTempo;
@property (strong, nonatomic) IBOutlet UILabel *txtPontos;
@property (strong) Jogo* jogo;
- (IBAction)menu:(id)sender;
@end
