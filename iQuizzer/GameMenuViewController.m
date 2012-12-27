//
//  GameMenuViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 26/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "GameMenuViewController.h"
#import "QuizDAO.h"
#import "GameViewController.h"
@interface GameMenuViewController ()

@end

@implementation GameMenuViewController
@synthesize quizzes = _quizzes;


-(void)setQuizzes:(NSArray *)quizzes{
    _quizzes = quizzes;
}
-(NSArray*)quizzes{
    if (!_quizzes){
        QuizDAO* dao = [[QuizDAO alloc] init];
        _quizzes = [[NSArray alloc] initWithArray:[dao findAllFromLocal]];
        
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
    NSLog(@"count: %d",self.quizzes.count);
    return [self.quizzes count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil){
        cell = [[UITableViewCell alloc] init];
    }
    
    Quiz* q = [self.quizzes objectAtIndex:indexPath.row];
    cell.textLabel.text = [q titulo];
    //cell.btnAction.titleLabel.text = @"Baixar"; //isso deve vir de uma funcao que verifica se ja tem o quiz
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Quiz* q = [self.quizzes objectAtIndex:indexPath.row];
    GameViewController* gq = [[GameViewController alloc] initWithNibName:@"GameViewController" bundle:nil];
    gq.quiz = q;
    NSLog(@"quiz.content: %@",q.titulo);
    NSLog(@"count perguntas: %d", q.perguntas.count);
    [self.navigationController pushViewController:gq animated:YES];
}

@end
