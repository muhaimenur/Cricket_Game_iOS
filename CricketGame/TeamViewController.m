//
//  TeamViewController.m
//  CricketGame
//
//  Created by Tonmoy on 2/5/16.
//  Copyright (c) 2016 Tonmoy. All rights reserved.
//

#import "TeamViewController.h"

@interface TeamViewController ()
{
    NSString *FirstTeamName, *SecondTeamName ;
    int over,player;

}
@end

@implementation TeamViewController

- (IBAction)GoToToss:(id)sender
{
    FirstTeamName = _FirstTeam.text;
    SecondTeamName = _SecondTeam.text;
    over = [_Over.text intValue];
    player = [_Player.text intValue];
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    TossViewController *tvc = [segue destinationViewController];
    tvc.first = self.FirstTeam.text;
    tvc.second = self.SecondTeam.text;
    tvc.OverSelection = self.Over.text;
    tvc.PlayerSelection = self.Player.text;

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view  endEditing:YES];
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
