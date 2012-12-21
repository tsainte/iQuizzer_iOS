//
//  GameOverViewController.m
//  iQuizzer
//
//  Created by Tiago Bencardino on 03/12/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import "GameOverViewController.h"
#import "Resultado.h"
#import "Resposta.h"
#import "MenuViewController.h"
@interface GameOverViewController ()

@end

@implementation GameOverViewController
@synthesize txtAcertos, txtErros, txtPontos, txtTempo;
@synthesize jogo;
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
    int acertos = [self countAcertos];
    txtAcertos.text = [NSString stringWithFormat:@"Acertos: %d", acertos];
    txtErros.text = [NSString stringWithFormat:@"Erros: %d", 5 - acertos];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)menu:(id)sender {
    MenuViewController* menu = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
    UINavigationController* nav = [[UINavigationController alloc] initWithRootViewController:menu];
    
    [self presentViewController:nav animated:YES completion:nil];
}
-(NSInteger)countAcertos{
    int acertos = 0;
    NSArray* rps = [jogo.resultado allObjects];
    for (Resultado* rp in rps){
        Resposta* r = rp.resposta;
        if ([r.correta intValue]> 0){
            acertos++;
        }
    }
    return acertos;
}
@end
