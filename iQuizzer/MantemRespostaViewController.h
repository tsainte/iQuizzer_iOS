//
//  MantemRespostaViewController.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 18/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Resposta.h"
#import "RespostaDAO.h"
#import "Pergunta.h"

@interface MantemRespostaViewController : UIViewController <UITextFieldDelegate>

@property (strong) Resposta* resposta;
@property (strong) Pergunta* pergunta;
@property (strong) RespostaDAO* respostaDAO;


@property (strong, nonatomic) IBOutlet UITextField *conteudo;
@property (strong, nonatomic) IBOutlet UISwitch *correta;
- (IBAction)salvar:(id)sender;
- (IBAction)apagar:(id)sender;

@end
