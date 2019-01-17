//
//  MainViewController.h
//  CricketGame
//
//  Created by Tonmoy on 2/6/16.
//  Copyright (c) 2016 Tonmoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TeamViewController.h"
#import "sqlite3.h"

@interface MainViewController : UIViewController
{
    sqlite3 *db;
    
}

@property (retain,nonatomic) NSString *random;
@property (retain,nonatomic) NSString *FirstTeams;
@property (retain,nonatomic) NSString *SecondTeams;
@property (retain,nonatomic) NSString *OverSelect;
@property (retain,nonatomic) NSString *PlayerSelect;


@property (weak, nonatomic) IBOutlet UILabel *OutputLavel;

@property (weak, nonatomic) IBOutlet UILabel *TeamNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *RunLabel;
@property (weak, nonatomic) IBOutlet UILabel *OverLabel;

@property (weak, nonatomic) IBOutlet UILabel *WicketLavel;

@property (weak, nonatomic) IBOutlet UILabel *TargetLavel;

- (IBAction)playAgain:(id)sender;
-(void) createTable: (NSString *) tableName
         withField1: (NSString *) field1
         withField2: (NSString *) field2
         withField3: (NSString *) field3
         withField4: (NSString *) field4
;



- (IBAction)button_1:(id)sender;
- (IBAction)button_2:(id)sender;
- (IBAction)button_3:(id)sender;
- (IBAction)button_4:(id)sender;
- (IBAction)button_5:(id)sender;
- (IBAction)button_6:(id)sender;

-(void)OverUpdate;
-(void) MainWork;
@end
