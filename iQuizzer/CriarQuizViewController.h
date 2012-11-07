//
//  CriarQuizViewController.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CriarQuizViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITextField *titulo;

@property (strong) NSArray* perguntas;
- (IBAction)addQuestion:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)delete:(id)sender;
@end
