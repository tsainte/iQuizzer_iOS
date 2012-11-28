//
//  GameViewController.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quiz.h"
#import "GameEngine.h"
@interface GameViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UILabel *round;
@property (strong, nonatomic) IBOutlet UILabel *lblTime;
@property (strong, nonatomic) IBOutlet UITextView *txtPergunta;
@property (strong, nonatomic) IBOutlet UITableView *tvRespostas;
@property (strong, nonatomic) IBOutlet UILabel *txtPontos;

@property (strong) NSArray* respostas;
@property (strong) Quiz* quiz;
@property (strong) GameEngine* engine;
@end
