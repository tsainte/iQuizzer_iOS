//
//  GameViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "GameViewController.h"
#import "GameEngine.h"
#import "GameOverViewController.h"
@interface GameViewController ()

@end

@implementation GameViewController
@synthesize quiz, engine;
@synthesize round,lblTime,txtPergunta,tvRespostas,txtPontos;
@synthesize respostas = _respostas;

Pergunta* currentPergunta;
NSInteger MAX_ROUND = 5;
-(void)setRespostas:(NSArray *)respostas{
    _respostas = respostas;
}
-(NSArray*)respostas{
    return _respostas;
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
    NSLog(@"quiz max before: %d", [quiz.maxquestoes intValue]);
    engine = [[GameEngine alloc] initWithQuiz:quiz];
     NSLog(@"quiz max after: %d", [quiz.maxquestoes intValue]);
    [engine start];
    [self roundUp];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [self gameover];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.respostas count];
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell* cell = [[UITableViewCell alloc] init];
    cell.textLabel.text = [[self.respostas objectAtIndex:indexPath.row] conteudo];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    Resposta* r = [self.respostas objectAtIndex:indexPath.row];
    [self roundDown:r];
}
int theRound = 0;
-(void)roundUp{
    currentPergunta = [engine popPergunta];
    if (currentPergunta == nil){
        [self gameover];
        return;
    }
    round.text = [NSString stringWithFormat:@"Pergunta %d/%d", ++theRound,MAX_ROUND];
    txtPergunta.text = currentPergunta.conteudo;
    self.respostas = [currentPergunta.resposta allObjects];
    [tvRespostas reloadData];
    
    
}
-(void)roundDown:(Resposta*)r{
    //verifica se acertou
    BOOL correta;
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"iQuizzer" message:@"" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    if ([r.correta intValue] > 0) {
        alert.message = @"Correta!";
        correta = YES;
    } else {
        alert.message = @"Errada!";
        correta = NO;
    }
    [alert show];
    
    //adiciona ao historico
    //[engine pushResultado_pergunta:currentPergunta resultado:correta];
    [engine pushResultado:r];
    //incrementa pontuacao
    //chama roundUp
    [self roundUp];
}
-(void)gameover{
  
    if (theRound == MAX_ROUND){
        [engine saveResults];
    }
    
    theRound = 0;
    GameOverViewController* go = [[GameOverViewController alloc] initWithNibName:@"GameOverViewController" bundle:nil];
    go.jogo = engine.jogo;
    [self presentViewController:go animated:YES completion:nil];
    engine = nil;
    
}

@end
