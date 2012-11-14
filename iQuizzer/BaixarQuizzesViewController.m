//
//  BaixarQuizzesViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "BaixarQuizzesViewController.h"
#import "Quiz.h"

#import "BuyCell.h"
@interface BaixarQuizzesViewController ()

@end

@implementation BaixarQuizzesViewController
@synthesize quizzes = _quizzes, dao;
@synthesize tv;

-(void)setQuizzes:(NSArray *)quizzes{
    _quizzes = quizzes;
}
-(NSArray*)quizzes{
    if (!_quizzes){
        
        _quizzes = [[NSArray alloc] initWithArray:[dao findAllFromServer]];
        
    }
    return _quizzes;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        dao = [[QuizDAO alloc] init];
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
    static NSString* cellIdentifier = @"BuyCell";
    static NSString* cellNib = @"BuyCell";
    
    BuyCell* cell = (BuyCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:cellNib owner:self options:nil];
        cell = (BuyCell*) [nib objectAtIndex:0];
    }
    Quiz* q = [self.quizzes objectAtIndex:indexPath.row];

    cell.titulo.text = q.titulo;
    [self configureButton:cell.btnAction forID:q.index];
    return cell;
}
- (IBAction)comprar:(id)sender {
    BuyCell* cell = (BuyCell*)[[sender superview] superview];
    NSIndexPath* indexPath = [tv indexPathForCell:cell];
    
    Quiz* q = [self.quizzes objectAtIndex:indexPath.row];
    if ([dao downloadQuiz:q.index]){
        [self configureButton:cell.btnAction forID:q.index];
    }
}
-(void)configureButton:(UIButton*)button forID:(NSNumber*)index{
    if ([dao find:index]){ //se encontrar algum quiz
        [button setTitle:@"Instalado" forState:UIControlStateNormal];
        [button setEnabled:NO];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    } else {
        [button setTitle:@"Baixar" forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
        [button setEnabled:YES];
    }
}

@end