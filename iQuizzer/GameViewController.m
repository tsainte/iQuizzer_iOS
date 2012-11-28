//
//  GameViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 06/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "GameViewController.h"
#import "GameEngine.h"
@interface GameViewController ()

@end

@implementation GameViewController
@synthesize quiz, engine;
@synthesize round,lblTime,txtPergunta,tvRespostas,txtPontos;
@synthesize respostas = _respostas;
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
    engine = [[GameEngine alloc] initWithQuiz:quiz];
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
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"iQuizzer" message:@"" delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil];
    if ([r.correta intValue] > 0) {
        alert.message = @"Correta!";
    } else {
        alert.message = @"Errada!";
    }
    [alert show];
    [self roundDown];
}
int theRound = 0;
-(void)roundUp{
    Pergunta* p = [engine pushPergunta];
    if (p == nil){
        [self gameover];
        return;
    }
    round.text = [NSString stringWithFormat:@"Pergunta %d/%d", ++theRound,5];
    txtPergunta.text = p.conteudo;
    self.respostas = [p.resposta allObjects];
    [tvRespostas reloadData];
    
    
}
-(void)roundDown{
    //verifica se acertou
    //incrementa pontuacao
    //chama roundUp
    [self roundUp];
}
-(void)gameover{
    theRound = 0;
    engine = nil;
}

@end
