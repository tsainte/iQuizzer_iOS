//
//  LoginViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 05/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "LoginViewController.h"
#import "Authenticator.h"
#import "Functions.h"
#import "MenuViewController.h"
@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize apelido,senha;
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
    return 2;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc]init];
    switch (indexPath.row) {
        case 0:
            cell.textLabel.text = @"Login";
            break;
        case 1:
            cell.textLabel.text = @"Senha";
            break;
        default:
            break;
    }
    return cell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)logar:(id)sender {
    NSString* login = apelido.text;
    NSString* password = senha.text;
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    //[appDelegate authenticate:login password:password callbackView:self callbackMethod:@selector(callbackLogar:)];
    Authenticator* auth = [[Authenticator alloc] init];
    [auth login:login password:password callbackClass:self callbackMethod:@selector(resultAuth:)];
    
}
-(void)resultAuth:(NSObject*)result{
    if([result isKindOfClass:[NSNumber class]]){
        MenuViewController* menu = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:menu];

        [self presentViewController:nav animated:YES completion:nil];
    } else {
        [Functions alert:(NSString*)result];
    }
}
- (IBAction)criarUsuario:(id)sender {
    [Functions alert:@"Não implementado ainda."];
    
}
@end
