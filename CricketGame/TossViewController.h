//
//  TossViewController.h
//  CricketGame
//
//  Created by Tonmoy on 2/6/16.
//  Copyright (c) 2016 Tonmoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MainViewController.h"
#import "TeamViewController.h"
@interface TossViewController : UIViewController
{
    int TossRandomNumber;
}

@property (retain,nonatomic) NSString *first;
@property (retain,nonatomic) NSString *second;
@property (retain,nonatomic) NSString *OverSelection;
@property (retain,nonatomic) NSString *PlayerSelection;

- (IBAction)FirstTossButton:(id)sender;

- (IBAction)SecondTossButton:(id)sender;
@end
