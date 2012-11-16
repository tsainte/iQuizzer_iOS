//
//  CriarQuizViewController.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Quiz.h"
#import "QuizDAO.h"
#import "PerguntaDAO.h"

@interface CriarQuizViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (strong, nonatomic) IBOutlet UITextField *titulo;
@property (strong) Quiz* quiz;
@property (strong) NSArray* perguntas;
@property (strong) QuizDAO* quizDAO;
@property (strong) PerguntaDAO* perguntaDAO;
@property (strong) NSManagedObjectContext* context;

- (IBAction)addQuestion:(id)sender;
- (IBAction)save:(id)sender;
- (IBAction)delete:(id)sender;
@end
