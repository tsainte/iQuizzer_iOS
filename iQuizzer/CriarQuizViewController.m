//
//  CriarQuizViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "CriarQuizViewController.h"
#import "CriaPerguntaViewController.h"
#import "DAO.h"
@interface CriarQuizViewController ()

@end

@implementation CriarQuizViewController
@synthesize titulo;
@synthesize perguntas = _perguntas;
@synthesize quiz, quizDAO, perguntaDAO;
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
        //TODO rever esse "context"
        //_context = [DAO anotherManagedContext];
        //quizDAO = [[QuizDAO alloc] initWithContext:_context];
        perguntaDAO = [[PerguntaDAO alloc] initWithContext:_context];
        
        quizDAO = [[QuizDAO alloc] init];
        Quiz* auxQuiz = [quizDAO createQuizWithTitulo:titulo.text];
        if (quiz){ //se nao existir quiz, crie um!
            auxQuiz.titulo = quiz.titulo;
            auxQuiz.index = quiz.index;
        }
        quiz = auxQuiz;
 
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    titulo.text = quiz.titulo;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addQuestion:(id)sender {
    CriaPerguntaViewController *cp = [[CriaPerguntaViewController alloc] initWithNibName:@"CriaPerguntaViewController" bundle:nil];
    cp.perguntaDAO = perguntaDAO;
    [self.navigationController pushViewController:cp animated:YES];
}
//TODO logica deve ir para o DAO
- (IBAction)save:(id)sender {
    quiz.titulo = titulo.text;
    NSError* error;
    if (![quizDAO.managedContext save:&error]){
        NSLog(@"%@", [error description]);
    } else { //se tudo ok, envia pra nuvem
        [quizDAO saveOnCloud:quiz];
        [self.navigationController popViewControllerAnimated:YES];
        
    }
}

- (IBAction)delete:(id)sender {
    //TODO apagar quiz do coredata
    [self alertOKCancelAction];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.perguntas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
- (void)alertOKCancelAction {
    // open a alert with an OK and cancel button
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"iQuizzer" message:@"Você tem certeza que deseja apagar este quiz?" delegate:self cancelButtonTitle:@"Não" otherButtonTitles:@"Sim", nil];
    [alert show];
}
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        [quizDAO remove:quiz];
        [self.navigationController popViewControllerAnimated:YES];
    }

}
@end
