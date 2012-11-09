//
//  MeusQuizzesViewController.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 09/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MeusQuizzesViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (strong) NSArray* quizzes;
@end
