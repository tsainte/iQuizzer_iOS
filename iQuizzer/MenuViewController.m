//
//  MenuViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 05/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "MenuViewController.h"
#import "ListaQuizzesViewController.h"
#import "CriarQuizViewController.h"
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
    return 3;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Jogar";
            break;
        case 1:
            cell.textLabel.text = @"Quizzes";
            break;
        case 2:
            cell.textLabel.text = @"Pontuações";
            break;
        case 3:
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
            
            break;
        case 1:
            [self showActionSheet];
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
-(void)showActionSheet{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Quizzes" delegate:self cancelButtonTitle:@"Cancelar" destructiveButtonTitle:nil otherButtonTitles:@"Meus quizzes", @"Baixar", @"Criar", nil];
    [actionSheet showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self lista];
            break;
        case 1:
            break;
        case 2:
            [self quiz];
        default:
            break;
    }
}
-(void)quiz{
    CriarQuizViewController* cq =[[CriarQuizViewController alloc] initWithNibName:@"CriarQuizViewController" bundle:nil];
    [self.navigationController pushViewController:cq animated:YES];
}
//TODO
-(void)redirect:(NSString*)viewController{
    //Class class = NSClassFromString(viewController);
}
@end
