//
//  LoginViewController.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 05/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController <UITextFieldDelegate>
- (IBAction)logar:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *apelido;
@property (strong, nonatomic) IBOutlet UITextField *senha;


- (IBAction)criarUsuario:(id)sender;
@end
