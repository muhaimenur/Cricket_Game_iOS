//
//  TossViewController.m
//  CricketGame
//
//  Created by Tonmoy on 2/6/16.
//  Copyright (c) 2016 Tonmoy. All rights reserved.
//

#import "TossViewController.h"
#import "MainViewController.h"
@interface TossViewController ()


@end

@implementation TossViewController
- (IBAction)FirstTossButton:(id)sender
{
    TossRandomNumber = arc4random() %2;
  
  
    
}


- (IBAction)SecondTossButton:(id)sender
{
    TossRandomNumber = arc4random() %2;
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    MainViewController *mvc = [segue destinationViewController];
    mvc.random  = [@(TossRandomNumber) stringValue];
    mvc.FirstTeams = self.first;
    mvc.SecondTeams = self.second;
    mvc.OverSelect = self.OverSelection;
    mvc.PlayerSelect = self.PlayerSelection;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
