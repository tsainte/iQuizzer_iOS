//
//  CriaPerguntaViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "CriaPerguntaViewController.h"
#import "PerguntaDAO.h"
#import "RespostaCell.h"
#import "MantemRespostaViewController.h"
@interface CriaPerguntaViewController ()

@end

@implementation CriaPerguntaViewController
@synthesize pergunta,respostas = _respostas,perguntaDAO, respostaDAO,textPergunta, quiz, tv;
-(void)setRespostas:(NSArray *)respostas{
    _respostas = respostas;
}
-(NSArray*)respostas{
    if (!_respostas){
        _respostas = [pergunta.resposta allObjects];
    }
    return _respostas;
}
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
    if(pergunta != nil){
        textPergunta.text = pergunta.conteudo;
    }
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.respostas = nil;
    [tv reloadData];
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
-(void)createPergunta{
    if(pergunta == nil){
        pergunta = [perguntaDAO createPerguntaWithConteudo:textPergunta.text];
    }
    pergunta.quiz = self.quiz; //deve vir dentro do DAO
    //textPergunta.text = pergunta.conteudo;

}
- (IBAction)salvar:(id)sender {
    [self createPergunta];
    NSError* error;
    pergunta.conteudo = textPergunta.text;

    if (![perguntaDAO.managedContext save:&error]){
        NSLog(@"%@", [error description]);
    } else { //se tudo ok, envia pra nuvem
        [perguntaDAO saveOnCloud:pergunta];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)adicionarRespostas:(id)sender {
    
    MantemRespostaViewController* view = [[MantemRespostaViewController alloc] initWithNibName:@"MantemRespostaViewController" bundle:nil];
    view.pergunta = pergunta;
    [self.navigationController pushViewController:view animated:YES];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.respostas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* cellIdentifier = @"RespostaCell";
    static NSString* cellNib = @"RespostaCell";
    
    RespostaCell* cell = (RespostaCell*)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil){
        NSArray* nib = [[NSBundle mainBundle] loadNibNamed:cellNib owner:self options:nil];
        cell = (RespostaCell*) [nib objectAtIndex:0];
    }
    Resposta* r = [self.respostas objectAtIndex:indexPath.row];
    
    NSString* lbl = [NSString stringWithFormat:@"%@ (%d)", r.conteudo, [r.id intValue]];
    cell.txtConteudo.text = lbl;
    [cell.correta setOn:[r.correta boolValue]];
    //[self configureButton:cell.btnAction forID:q.index];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MantemRespostaViewController* view = [[MantemRespostaViewController alloc] initWithNibName:@"MantemRespostaViewController" bundle:nil];
    view.pergunta = pergunta;
    view.resposta = [self.respostas objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:view animated:YES];
}
@end
