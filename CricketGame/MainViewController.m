//
//  MainViewController.m
//  CricketGame
//
//  Created by Tonmoy on 2/6/16.
//  Copyright (c) 2016 Tonmoy. All rights reserved.
//

#import "MainViewController.h"
@interface MainViewController ()
{
    int TossRandom;
    NSMutableArray *MutableArray;
    int BattingRandomNumber;
    int Run;
    int Over;
    int PreOver;
    int Wicket;
    int terget;
    int FinalOverSelcet;
    int FinalPlayerSelect;
    int tag;
    int FirstTeamRun;
    int secondTeamRun;
    int innings;
    int teamselect;
    int winOfRun;
    int secondTeamWicket;
    int dbRunFirstTeam;
    int dbRunSecondTeam;
    int dbOverFirstTeam;
    int dbOverSecondTeam;
    int dbWicketFirstTeam;
    int dbWicketSecondTeam;
    NSString *overText, *newOverForDB;
    NSMutableArray *array;
}

@end

@implementation MainViewController


-(NSString *) filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    return [[paths objectAtIndex:0] stringByAppendingString:@"bp.sql"];
    
}

-(void) openDB {
    if (sqlite3_open([[self filePath] UTF8String], &db) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Database failed to open");
    }
    else
    {
        NSLog(@"Database opened");
    }
    
}

-(void) createTable: (NSString *) tableName
         withField1: (NSString *) field1
         withField2: (NSString *) field2
         withField3: (NSString *) field3
         withField4: (NSString *) field4

{
    
    char *err;
    NSString *sql = [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' TEXT , '%@' INTEGER , '%@' INTEGER , '%@' INTEGER );" ,tableName ,field1, field2, field3,field4];
    
    if (sqlite3_exec(db, [sql UTF8String], NULL, NULL, &err) != SQLITE_OK) {
        sqlite3_close(db);
        NSAssert(0, @"Could not create table");
    }
    else{
        NSLog(@"table created");
    }
    
    
}



- (void)viewDidLoad {
   

    [self openDB];
    [self createTable:@"FirstTbless" withField1:@"FirstTeamName" withField2:@"FirstRun" withField3:@"FirstOver" withField4:@"FirstWicket"];
    
    [self createTable:@"SecondTbless" withField1:@"SecondTeamName" withField2:@"SecondRun" withField3:@"SecondOver" withField4:@"SecondWicket"];
    
    innings = 1;
    tag =0;
    TossRandom = [self.random intValue];
    if (TossRandom>0) {
        teamselect = 1;
        self.TeamNameLabel.text = self.FirstTeams;
        NSString *msg = [[NSString alloc]initWithFormat:@"%@ Won The Toss.",self.FirstTeams];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Toss Result"
                                                  message:msg
                                                  delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        teamselect =2;
        self.TeamNameLabel.text = self.SecondTeams;
       NSString *msg = [[NSString alloc]initWithFormat:@"%@ Won The Toss.",self.SecondTeams];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Toss Result"
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }

    MutableArray =[[NSMutableArray alloc]initWithCapacity:10];
    
    [MutableArray addObject:@"1"];
    [MutableArray addObject:@"2"];
    [MutableArray addObject:@"OUT"];
    [MutableArray addObject:@"6"];
    [MutableArray addObject:@"1"];
    [MutableArray addObject:@"OUT"];
    [MutableArray addObject:@"4"];
    [MutableArray addObject:@"3"];
    [MutableArray addObject:@"1"];
    [MutableArray addObject:@"2"];
    
    array = [[NSMutableArray alloc]init];
    [array addObject:@"0"];
    [array addObject:@"."];
    [array addObject:@"0"];
   
    self.OverUpdate;
    self.RunLabel.text =@"0";
    self.WicketLavel.text = @"0";
    
    FinalOverSelcet = [self.OverSelect intValue];
    FinalPlayerSelect = [self.PlayerSelect intValue];
       
    
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(void)OverUpdate
{
    for (int i=0; i<=2; i++) {
        overText= [array componentsJoinedByString:@""];
    }
    
    if (tag == 0) {
        self.OverLabel.text = overText;

    }
    else
    {
        
        /*self.OverLabel.text = @"0.0";
        self.WicketLavel.text = @"0";
         self.RunLabel.text = @"0";*/
        tag = 0;
        
       

    }
    
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void)firstUpdate
{
    self.OutputLavel.text = @"";
}

-(void) MainWork
{
     BattingRandomNumber = arc4random() %10;
     NSString * text = MutableArray[BattingRandomNumber];
     self.OutputLavel.text = text;
     if ([text  isEqual: @"1"] || [text  isEqual: @"2"] || [text  isEqual: @"3"] || [text  isEqual: @"4"] || [text  isEqual: @"6"])
     {
         Run = Run + [MutableArray[BattingRandomNumber] intValue];
         NSString *RunToStr = [@(Run) stringValue];
         self.RunLabel.text= RunToStr;
     
       if (innings == 2)
       {
         secondTeamRun = [self.RunLabel.text intValue];
         secondTeamWicket = [self.WicketLavel.text intValue];
           if (teamselect==1)
           {
               if(secondTeamRun > FirstTeamRun)
               {
                   int WinForPlayer =  [self.PlayerSelect intValue] - secondTeamWicket;
                   NSString *WinStr= [NSString stringWithFormat:@"%@ Win For %d Wicket",self.SecondTeams,WinForPlayer];
                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                   message:WinStr
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancle"
                                                         otherButtonTitles:nil];
                   [alert show];
                  
                    NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbless('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket];
                    char *err;
                    if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                    sqlite3_close(db);
                    NSAssert(0, @"Could not updated table");
                    } else {
                    NSLog(@"Table updated");
                        
                    }
                   innings = 3;
                  
               }
    
           }
           else
           {
               if(secondTeamRun > FirstTeamRun)
               {
                   int WinForPlayer =  [self.PlayerSelect intValue] - secondTeamWicket;
                   NSString *WinStr= [NSString stringWithFormat:@"%@ Win For %d Wicket",self.FirstTeams,WinForPlayer];
                   UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                   message:WinStr
                                                                  delegate:self
                                                         cancelButtonTitle:@"Cancle"
                                                         otherButtonTitles:nil];
                   [alert show];
                   innings = 3;
                   NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbless('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket];
                    char *err;
                    if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                    sqlite3_close(db);
                    NSAssert(0, @"Could not updated table");
                    } else {
                    NSLog(@"Table updated");
                    }
                 
               // NSLog(@"%@ %d %d %d",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket);
               }
           
           }
           
       }
     }
     else
     {
         Wicket = Wicket+1;
         NSString *WicketToStr = [@(Wicket) stringValue];
     if (Wicket == FinalPlayerSelect)
     {
        if (innings == 1)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result"
                                                            message:@"All Out"
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancle"
                                                  otherButtonTitles:@"Second Innings",nil];
            [alert show];
     
            self.TargetLavel.text = self.RunLabel.text;
            tag =1;
            innings =2;
     
        }
        else if(innings == 2)
        {
            if (teamselect ==1)
            {
                secondTeamRun = [self.RunLabel.text intValue];
                secondTeamWicket = [self.WicketLavel.text intValue];
                
                if (FirstTeamRun > secondTeamRun)
                {
                    winOfRun = FirstTeamRun-secondTeamRun;
                    NSString *WinStr= [NSString stringWithFormat:@"%@ Win For %d Runs",self.FirstTeams,winOfRun];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                    message:WinStr
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancle"
                                                          otherButtonTitles:nil];
                    [alert show];
                  innings = 3;
                     NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbless('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket];
                     char *err;
                     if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                     sqlite3_close(db);
                     NSAssert(0, @"Could not updated table");
                     } else {
                     NSLog(@"Table updated");
                     }
                     //NSLog(@"%@ %d %d %d",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket);
                    
                }
                else if(secondTeamRun > FirstTeamRun)
                {
                    int WinForPlayer =  [self.PlayerSelect intValue] - secondTeamWicket;
                    NSString *WinStr= [NSString stringWithFormat:@"%@ Win For %d Wicket",self.SecondTeams,WinForPlayer];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                    message:WinStr
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancle"
                                                          otherButtonTitles:nil];
                    [alert show];
                   innings = 3;
                    /* NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTblss('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket];
                     char *err;
                     if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                     sqlite3_close(db);
                     NSAssert(0, @"Could not updated table");
                     } else {
                     NSLog(@"Table updated");
                     }*/
                   //  NSLog(@"%@ %d %d %d",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket);
                 
                }
                else if(secondTeamRun == FirstTeamRun)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                    message:@"Match Draw"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancle"
                                                          otherButtonTitles:nil];
                    [alert show];
                   innings = 3;
                     NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbless('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket];
                     char *err;
                     if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                     sqlite3_close(db);
                     NSAssert(0, @"Could not updated table");
                     } else {
                     NSLog(@"Table updated");
                     }
                    // NSLog(@"%@ %d %d %d",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket);
                }
                

            }
            else
            {
                secondTeamRun = [self.RunLabel.text intValue];
                secondTeamWicket = [self.WicketLavel.text intValue];
                
                if (FirstTeamRun > secondTeamRun)
                {
                    winOfRun = FirstTeamRun-secondTeamRun;
                    NSString *WinStr= [NSString stringWithFormat:@"%@ Win For %d Runs",self.SecondTeams,winOfRun];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                    message:WinStr
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancle"
                                                          otherButtonTitles:nil];
                    [alert show];
                    innings = 3;
                    NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbless('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket];
                     char *err;
                     if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                     sqlite3_close(db);
                     NSAssert(0, @"Could not updated table");
                     } else {
                     NSLog(@"Table updated");
                     }

                  // NSLog(@"%@ %d %d %d",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket);
                }
                else if(secondTeamRun > FirstTeamRun)
                {
                    int WinForPlayer =  [self.PlayerSelect intValue] - secondTeamWicket;
                    NSString *WinStr= [NSString stringWithFormat:@"%@ Win For %d Wicket",self.FirstTeams,WinForPlayer];
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                    message:WinStr
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancle"
                                                          otherButtonTitles:@"PlayAgain",nil];
                    [alert show];
                    innings = 3;
                    /*NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbles('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket];
                     char *err;
                     if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                     sqlite3_close(db);
                     NSAssert(0, @"Could not updated table");
                     } else {
                     NSLog(@"Table updated");
                     }*/

                   // NSLog(@"%@ %d %d %d",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket);
                   
                }
                else if(secondTeamRun == FirstTeamRun)
                {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                    message:@"Match Draw"
                                                                   delegate:self
                                                          cancelButtonTitle:@"Cancle"
                                                          otherButtonTitles:nil];
                    [alert show];
                  innings = 3;
                     NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbless('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket];
                     char *err;
                     if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                     sqlite3_close(db);
                     NSAssert(0, @"Could not updated table");
                     } else {
                     NSLog(@"Table updated");
                     }

                     //NSLog(@"%@ %d %d %d",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket);
                }

            
            }
            
        }
         

     
     }
        
     self.WicketLavel.text= WicketToStr;
     }
     
     Over =Over+1;
     if (Over == 6)
     {
         PreOver = PreOver+1;
         NSString *str1 = [@(PreOver) stringValue];
         [array replaceObjectAtIndex:0 withObject:str1];
         [array replaceObjectAtIndex:2 withObject:@"0"];
         
         Over=0;
     
     
         if (PreOver == FinalOverSelcet)
         {
             if (innings == 1)
             {
                 UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Result"
                                                                 message:@"Over Ses"
                                                                delegate:self
                                                       cancelButtonTitle:@"Cancle"
                                                       otherButtonTitles:@"Second Innings",nil];
                 [alert show];
                 self.TargetLavel.text = self.RunLabel.text;
                 tag =1;
                 innings =2;
     
             }
             else if(innings == 2)
             {
                 
                 if (teamselect == 1)
                 {
                     secondTeamRun = [self.RunLabel.text intValue];
                     secondTeamWicket = [self.WicketLavel.text intValue];
                     
                     if (FirstTeamRun > secondTeamRun)
                     {
                         winOfRun = FirstTeamRun-secondTeamRun;
                         NSString *WinStr= [NSString stringWithFormat:@"%@ Win For %d Runs",self.FirstTeams,winOfRun];
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                         message:WinStr
                                                                        delegate:self
                                                               cancelButtonTitle:@"Cancle"
                                                               otherButtonTitles:nil];
                         [alert show];
                         innings = 3;
                          NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbless('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket];
                          char *err;
                          if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                          sqlite3_close(db);
                          NSAssert(0, @"Could not updated table");
                          } else {
                          NSLog(@"Table updated");
                          }
                         // NSLog(@"%@ %d %d %d",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket);
                         
                    }
                     else if(secondTeamRun > FirstTeamRun)
                     {
                         int WinForPlayer =  [self.PlayerSelect intValue] - secondTeamWicket;
                         NSString *WinStr= [NSString stringWithFormat:@"%@ Win For %d Wicket",self.SecondTeams,WinForPlayer];
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                         message:WinStr
                                                                        delegate:self
                                                               cancelButtonTitle:@"Cancle"
                                                               otherButtonTitles:nil];
                         [alert show];
                         innings = 3;
                        /*  NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbl('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket];
                          char *err;
                          if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                          sqlite3_close(db);
                          NSAssert(0, @"Could not updated table");
                          } else {
                          NSLog(@"Table updated");
                          }*/
                      // NSLog(@"%@ %d %d %d",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket);
                     }
                     else if(secondTeamRun == FirstTeamRun)
                     {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                         message:@"Match Draw"
                                                                        delegate:self
                                                               cancelButtonTitle:@"Cancle"
                                                               otherButtonTitles:nil];
                         [alert show];
                         innings = 3;
                      /*  NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbl('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket];
                          char *err;
                          if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                          sqlite3_close(db);
                          NSAssert(0, @"Could not updated table");
                          } else {
                          NSLog(@"Table updated");
                          }*/
                     //  NSLog(@"%@ %d %d %d",self.SecondTeams,secondTeamRun,FinalOverSelcet,Wicket);
                     }
                 }
                 else
                 {
                     secondTeamRun = [self.RunLabel.text intValue];
                     secondTeamWicket = [self.WicketLavel.text intValue];
                     
                     if (FirstTeamRun > secondTeamRun)
                     {
                         winOfRun = FirstTeamRun-secondTeamRun;
                         NSString *WinStr= [NSString stringWithFormat:@"%@ Win For %d Runs",self.SecondTeams,winOfRun];
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                         message:WinStr
                                                                        delegate:self
                                                               cancelButtonTitle:@"Cancle"
                                                               otherButtonTitles:nil];
                         [alert show];
                         innings = 3;
                        NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbless('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket];
                          char *err;
                          if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                          sqlite3_close(db);
                          NSAssert(0, @"Could not updated table");
                          } else {
                          NSLog(@"Table updated");
                          }

                          //NSLog(@"%@ %d %d %d",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket);
                     
                     }
                     else if(secondTeamRun > FirstTeamRun)
                     {
                         int WinForPlayer =  [self.PlayerSelect intValue] - secondTeamWicket;
                         NSString *WinStr= [NSString stringWithFormat:@"%@ Win For %d Wicket",self.FirstTeams,WinForPlayer];
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                         message:WinStr
                                                                        delegate:self
                                                               cancelButtonTitle:@"Cancle"
                                                               otherButtonTitles:nil];
                         innings = 3;
                        /* NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbl('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket];
                          char *err;
                          if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                          sqlite3_close(db);
                          NSAssert(0, @"Could not updated table");
                          } else {
                          NSLog(@"Table updated");
                          }*/

                        //  NSLog(@"%@ %d %d %d",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket);
                        
                     }
                     else if(secondTeamRun == FirstTeamRun)
                     {
                         UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tounament Result"
                                                                         message:@"Match Draw"
                                                                        delegate:self
                                                               cancelButtonTitle:@"Cancle"
                                                               otherButtonTitles:nil];
                         [alert show];
                         innings = 3;
                        NSString *sql = [NSString stringWithFormat:@"INSERT INTO SecondTbless('SecondTeamName', 'SecondRun', 'SecondOver','SecondWicket') VALUES ('%@', '%d', '%d', '%d')",self.FirstTeams,secondTeamRun,FinalOverSelcet,Wicket];
                          char *err;
                          if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                          sqlite3_close(db);
                          NSAssert(0, @"Could not updated table");
                          } else {
                          NSLog(@"Table updated");
                          }
                        
                    
                     }
    
                 }
             
 
             }
     
     }
     self.OverUpdate;
     
     }
     else
     {
     NSString *str = [@(Over) stringValue];
     [array replaceObjectAtIndex:2 withObject:str];
     
     self.OverUpdate;
     
     }
     
     
    [self performSelector:@selector(firstUpdate) withObject:nil afterDelay:0.25];
    //self.OutputLavel.text =@"";



}

- (IBAction)playAgain:(id)sender {
    if (TossRandom>0)
    {
        teamselect = 1;
        self.TeamNameLabel.text = self.FirstTeams;
        
    }
    else
    {
        teamselect =2;
        self.TeamNameLabel.text = self.SecondTeams;
       
    }
    Run=0;
    Over=0;
    PreOver=0;
    Wicket=0;
    terget=0;
    FirstTeamRun=0;
    secondTeamRun=0;
    winOfRun=0;
    secondTeamWicket=0;
    innings =1;
    tag =0;
    [array replaceObjectAtIndex:0 withObject:@"0"];
    [array replaceObjectAtIndex:2 withObject:@"0"];
    self.RunLabel.text = @"0";
    self.OverLabel.text = @"0.0";
    self.WicketLavel.text = @"0";
    self.TargetLavel.text = @"0";
  
    
}



-(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1) {
        if (teamselect == 1) {
            self.TeamNameLabel.text = self.SecondTeams;
            FirstTeamRun = [self.TargetLavel.text intValue];
           // NSLog(@"%@ %d %d %d",self.FirstTeams,FirstTeamRun,FinalOverSelcet,Wicket);
          NSString *sql = [NSString stringWithFormat:@"INSERT INTO FirstTbless('FirstTeamName', 'FirstRun', 'FirstOver','FirstWicket') VALUES ('%@', '%d', '%d', '%d')",self.FirstTeams,FirstTeamRun,FinalOverSelcet,Wicket];
            char *err;
            if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK) {
                sqlite3_close(db);
                NSAssert(0, @"Could not updated table");
            } else {
                NSLog(@"Table updated");
            }
            
           
            Run =0;
            Over =0;
            [array replaceObjectAtIndex:0 withObject:@"0"];
            [array replaceObjectAtIndex:2 withObject:@"0"];
            Wicket =0;
            PreOver = 0;
            self.RunLabel.text =@"0";
            self.WicketLavel.text=@"0";
            self.OverLabel.text=@"0.0";
        }
        else if(teamselect == 2)
        {
            self.TeamNameLabel.text = self.FirstTeams;
            FirstTeamRun = [self.TargetLavel.text intValue];
            NSLog(@"%@ %d %d %d",self.SecondTeams,FirstTeamRun,FinalOverSelcet,Wicket);
           
            NSString *sql = [NSString stringWithFormat:@"INSERT INTO FirstTbless('FirstTeamName', 'FirstRun', 'FirstOver','FirstWicket') VALUES ('%@', '%d', '%d', '%d')",self.SecondTeams,FirstTeamRun,FinalOverSelcet,Wicket];
             char *err;
             if (sqlite3_exec(db, [sql UTF8String], NULL,NULL, &err) != SQLITE_OK)
             {
                sqlite3_close(db);
                 NSAssert(0, @"Could not updated table");
             }
             else
             {
                 NSLog(@"Table updated");
             }
            
           
            Run =0;
            Over =0;
            [array replaceObjectAtIndex:0 withObject:@"0"];
            [array replaceObjectAtIndex:2 withObject:@"0"];
            Wicket =0;
            PreOver = 0;
            self.RunLabel.text =@"0";
            self.WicketLavel.text=@"0";
            self.OverLabel.text=@"0.0";
        }
        
     
    }
}
- (IBAction)button_1:(id)sender {
    if (innings == 1) {
        self.MainWork;
    }
    else if (innings == 2)
    {
        self.MainWork;
    }
    else if(innings ==3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning..."
                                                        message:@"Please tap to playAgain button"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancle"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
}

- (IBAction)button_2:(id)sender {
    if (innings == 1) {
        self.MainWork;
    }
    else if (innings == 2)
    {
    self.MainWork;
    }
    else if(innings ==3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning..."
                                                        message:@"Please tap to play Again button"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancle"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)button_3:(id)sender {
    if (innings == 1) {
        self.MainWork;
    }
    else if (innings == 2)
    {
        self.MainWork;
    }
    else if(innings ==3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning..."
                                                        message:@"Please tap to play Again button"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancle"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)button_4:(id)sender {
    if (innings == 1) {
        self.MainWork;
    }
    else if (innings == 2)
    {
        self.MainWork;
    }
    else if(innings ==3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning..."
                                                        message:@"Please tap to play Again button"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancle"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)button_5:(id)sender {
    if (innings == 1) {
        self.MainWork;
    }
    else if (innings == 2)
    {
        self.MainWork;
    }
    else if(innings ==3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning..."
                                                        message:@"Please tap to play Again button"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancle"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (IBAction)button_6:(id)sender {
    if (innings == 1) {
        self.MainWork;
    }
    else if (innings == 2)
    {
        self.MainWork;
    }
    else if(innings ==3)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Warning..."
                                                        message:@"Please tap to play Again button"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancle"
                                              otherButtonTitles:nil];
        [alert show];
    }
}
@end
