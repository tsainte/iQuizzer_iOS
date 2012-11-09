//
//  BaixarQuizzesViewController.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuizDAO.h"
@interface BaixarQuizzesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong) NSArray* quizzes;
@property (strong) QuizDAO* dao;
@property (strong, nonatomic) IBOutlet UITableView *tv;

- (IBAction)comprar:(id)sender;


@end
