//
//  CriaPerguntaViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "CriaPerguntaViewController.h"
#import "PerguntaDAO.h"

@interface CriaPerguntaViewController ()

@end

@implementation CriaPerguntaViewController
@synthesize pergunta,respostas,perguntaDAO,textPergunta, quiz;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    perguntaDAO = [[PerguntaDAO alloc] init];
    if(pergunta == nil){
        pergunta = [perguntaDAO createPerguntaWithConteudo:textPergunta.text];
    }
    pergunta.quiz = self.quiz; //deve vir dentro do DAO
    textPergunta.text = pergunta.conteudo;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if([text isEqualToString:@"\n"])
        [textView resignFirstResponder];
    return YES;
}
- (IBAction)salvar:(id)sender {
    NSError* error;
    pergunta.conteudo = textPergunta.text;

    if (![perguntaDAO.managedContext save:&error]){
        NSLog(@"%@", [error description]);
    } else { //se tudo ok, envia pra nuvem
        [perguntaDAO saveOnCloud:pergunta];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 0;
}
@end
