//
//  CriarQuizViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "CriarQuizViewController.h"
#import "CriaPerguntaViewController.h"
@interface CriarQuizViewController ()

@end

@implementation CriarQuizViewController
@synthesize perguntas = _perguntas;
-(void)setPerguntas:(NSArray *)perguntas{
    _perguntas = perguntas;
}
-(NSArray*)perguntas{
    if (!_perguntas){
        //_perguntas = [[NSArray alloc] initWithArray:[QuizDAO findAllFromServer]];
        
    }
    return _perguntas;
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

- (IBAction)addQuestion:(id)sender {
    CriaPerguntaViewController *cp = [[CriaPerguntaViewController alloc] initWithNibName:@"CriaPerguntaViewController" bundle:nil];
    [self.navigationController pushViewController:cp animated:YES];
}

- (IBAction)save:(id)sender {
}

- (IBAction)delete:(id)sender {
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.perguntas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
@end
