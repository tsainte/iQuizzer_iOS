//
//  CriaPerguntaViewController.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 07/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PerguntaDAO.h"
#import "Pergunta.h"
#import "RespostaDAO.h"
@interface CriaPerguntaViewController : UIViewController <UITextViewDelegate, UITableViewDataSource, UITableViewDelegate>
@property (strong) Pergunta* pergunta;
@property (strong) NSArray* respostas;
@property (strong) PerguntaDAO* perguntaDAO;
@property (strong) RespostaDAO* respostaDAO;
@property (strong) Quiz* quiz;
@property (strong, nonatomic) IBOutlet UITableView *tv;
@property (strong, nonatomic) IBOutlet UITextView *textPergunta;
- (IBAction)salvar:(id)sender;

- (IBAction)adicionarRespostas:(id)sender;

@end
