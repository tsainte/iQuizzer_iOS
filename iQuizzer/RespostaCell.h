//
//  RespostaCell.h
//  iQuizzer
//
//  Created by Tiago Bencardino on 18/11/12.
//  Copyright (c) 2012 Tiago Bencardino. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RespostaCell : UITableViewCell <UITextViewDelegate>

@property (strong, nonatomic) IBOutlet UITextView *txtConteudo;
@property (strong, nonatomic) IBOutlet UISwitch *correta;
@end
