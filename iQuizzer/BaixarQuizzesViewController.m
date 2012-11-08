//
//  BaixarQuizzesViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "BaixarQuizzesViewController.h"
#import "Quiz.h"
#import "QuizDAO.h"
@interface BaixarQuizzesViewController ()

@end

@implementation BaixarQuizzesViewController
@synthesize quizzes = _quizzes;

-(void)setQuizzes:(NSArray *)quizzes{
    _quizzes = quizzes;
}
-(NSArray*)quizzes{
    if (!_quizzes){
        QuizDAO* dao = [[QuizDAO alloc] init];
        _quizzes = [[NSArray alloc] initWithArray:[dao findAllFromServer]];
        
    }
    return _quizzes;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.quizzes count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    Quiz* q = [self.quizzes objectAtIndex:indexPath.row];
    cell.textLabel.text = [q titulo];
    return cell;
}
@end