//
//  MantemRespostaViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 18/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "MantemRespostaViewController.h"

#import "PerguntaDAO.h"
@interface MantemRespostaViewController ()

@end

@implementation MantemRespostaViewController
@synthesize conteudo, correta;
@synthesize resposta, respostaDAO;
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
    
    respostaDAO = [[RespostaDAO alloc] init];
    if (resposta != nil){
        conteudo.text = resposta.conteudo;
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)createResposta{
    if(resposta == nil){
        resposta = [respostaDAO createRespostaWithConteudo:conteudo.text correta:correta.isOn];
    }
    resposta.pergunta = self.pergunta; //deve vir dentro do DAO
    //conteudo.text = resposta.conteudo;
}
- (IBAction)salvar:(id)sender {
    [self createResposta];
    resposta.conteudo = conteudo.text;
    PerguntaDAO *perguntaDAO = [[PerguntaDAO alloc] init];
    
    NSError* error;
    if (![respostaDAO.managedContext save:&error]){
        NSLog(@"%@", [error description]);
    } else { //se tudo ok, envia pra nuvem
        //[respostaDAO saveOnCloud:resposta];
        [perguntaDAO setCurrentResposta:resposta];
        [perguntaDAO saveRespostaOnCloud:resposta.pergunta];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)apagar:(id)sender {
}

@end
