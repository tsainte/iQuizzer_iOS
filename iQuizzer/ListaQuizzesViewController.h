//
//  ListaQuizzesViewController.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 05/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ListaQuizzesViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong) NSArray* quizzes;
@end
