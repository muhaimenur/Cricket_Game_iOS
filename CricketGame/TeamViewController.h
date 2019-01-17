//
//  TeamViewController.h
//  CricketGame
//
//  Created by Tonmoy on 2/5/16.
//  Copyright (c) 2016 Tonmoy. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TossViewController.h"

@interface TeamViewController : UIViewController<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *FirstTeam;

@property (weak, nonatomic) IBOutlet UITextField *SecondTeam;

@property (weak, nonatomic) IBOutlet UITextField *Over;

@property (weak, nonatomic) IBOutlet UITextField *Player;

- (IBAction)GoToToss:(id)sender;

-(NSString *) filePath;
-(void) openDB;



@end
