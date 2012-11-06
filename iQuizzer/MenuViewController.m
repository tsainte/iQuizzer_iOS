//
//  MenuViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 05/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "MenuViewController.h"
#import "ListaQuizzesViewController.h"
@interface MenuViewController ()

@end

@implementation MenuViewController

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
    return 5;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Jogar";
            break;
        case 1:
            cell.textLabel.text = @"Meus quizzes";
            break;
        case 2:
            cell.textLabel.text = @"Obter mais";
            break;
        case 3:
            cell.textLabel.text = @"Pontuações";
            break;
        case 4:
            cell.textLabel.text = @"Sobre";
            break;
        default:
            break;
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    switch (indexPath.row) {
        case 0:
            [self lista];
            break;
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        default:
            break;
    }
}
-(void) lista{
    ListaQuizzesViewController* listaView = [[ListaQuizzesViewController alloc] initWithNibName:@"ListaQuizzesViewController" bundle:nil];
    [self.navigationController pushViewController:listaView animated:YES];
}
@end
