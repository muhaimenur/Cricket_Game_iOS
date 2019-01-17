//
//  CustomTableViewCell.h
//  CricketGame
//
//  Created by Tonmoy on 2/10/16.
//  Copyright (c) 2016 Tonmoy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *FirstDescription;
@property (weak, nonatomic) IBOutlet UILabel *SecondDescription;
@property (weak, nonatomic) IBOutlet UILabel *FirstTeam;
@property (weak, nonatomic) IBOutlet UILabel *SecondTeam;

@end
