//
//  ShowTableViewController.h
//  CricketGame
//
//  Created by Tonmoy on 2/10/16.
//  Copyright (c) 2016 Tonmoy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTableViewCell.h"
#import "MainViewController.h"
#import "sqlite3.h"
@interface ShowTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
{
    sqlite3 *db;
}
-(NSString *) filePath;
-(void) openDB;
- (IBAction)DoneButton:(id)sender;

- (IBAction)EditButton:(id)sender;

@property (strong, nonatomic) IBOutlet UITableView *aTableView;

@property (nonatomic,strong) NSMutableArray *entries;
@property (nonatomic,strong) NSMutableArray *Secondentriess;
@property (nonatomic,strong) NSMutableArray *FirstTeamName;
@property (nonatomic,strong) NSMutableArray *SecondTeamName;

@property (nonatomic,strong) NSMutableArray *dbRun1;
@property (nonatomic,strong) NSMutableArray *dbRun2;
@property (nonatomic,strong) NSMutableArray *dbWicket1;
@property (nonatomic,strong) NSMutableArray *dbWicket2;
@property (nonatomic,strong) NSMutableArray *dbOver1;
@property (nonatomic,strong) NSMutableArray *dbOver2;


@end
