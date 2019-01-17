//
//  ShowTableViewController.m
//  CricketGame
//
//  Created by Tonmoy on 2/10/16.
//  Copyright (c) 2016 Tonmoy. All rights reserved.
//

#import "ShowTableViewController.h"
@interface ShowTableViewController ()

{
    NSInteger count1;
    NSInteger count2;
    NSInteger finalcount;
}
@end

@implementation ShowTableViewController

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

- (IBAction)DoneButton:(id)sender {
    
     [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)EditButton:(id)sender {
    [self.aTableView setEditing:YES animated:YES];
    
    
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        NSString *f = [self.FirstTeamName objectAtIndex:indexPath.row];
         NSString *s = [self.SecondTeamName objectAtIndex:indexPath.row];
        NSString *r1 = [self.dbRun1 objectAtIndex:indexPath.row];
        NSString *r2 = [self.dbRun2 objectAtIndex:indexPath.row];
        NSString *w1 = [self.dbWicket1 objectAtIndex:indexPath.row];
        NSString *w2 = [self.dbWicket2 objectAtIndex:indexPath.row];
        NSString *o1 = [self.dbOver1 objectAtIndex:indexPath.row];
        NSString *o2 = [self.dbOver2 objectAtIndex:indexPath.row];
        
       // NSString *sql3 = [NSString stringWithFormat:@"DELETE from FirstTables where FirstTeamName is '%s'",[f UTF8String]];
        NSString *sql3 = [NSString stringWithFormat:@"DELETE from FirstTbless where FirstTeamName='%s' and FirstRun= '%s' and FirstWicket= '%s' and FirstOver = '%s'",[f UTF8String],[r1 UTF8String],[w1 UTF8String],[o1 UTF8String]];
        
        sqlite3_stmt *statement3;
        [self openDB];
        
        [self.entries removeObjectAtIndex:indexPath.row];
        [self.Secondentriess removeObjectAtIndex:indexPath.row];
        [self.aTableView deleteRowsAtIndexPaths:[NSMutableArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        char *eror;
        
      if (sqlite3_exec(db, [sql3 UTF8String], -1, &statement3, &eror)==SQLITE_OK)
        {
            
            [self.FirstTeamName removeObjectAtIndex:indexPath.row];
           
            NSLog(@"deleted...F");
       
            
        }
        NSString *sql4 = [NSString stringWithFormat:@"DELETE from SecondTbless where SecondTeamName='%s' and SecondRun ='%s' and SecondWicket = '%s' and SecondOver = '%s'",[s UTF8String],[r2 UTF8String],[w2 UTF8String],[o2 UTF8String]];
        sqlite3_stmt *statement4;
        if (sqlite3_exec(db, [sql4 UTF8String], -1, &statement4, &eror)==SQLITE_OK)
        {
            
            [self.SecondTeamName removeObjectAtIndex:indexPath.row];
       

             NSLog(@"deleted...S");
        }
        
       
       
        

    }


}

-(UITableViewCellEditingStyle ) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([CustomTableViewCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([CustomTableViewCell class])];
    
    
    self.dbWicket1 = [[NSMutableArray alloc]init];
    self.dbWicket2 = [[NSMutableArray alloc]init];
    self.dbOver1 = [[NSMutableArray alloc]init];
    self.dbOver2 = [[NSMutableArray alloc]init];
    self.dbRun1 = [[NSMutableArray alloc]init];
    self.dbRun2 = [[NSMutableArray alloc]init];
    self.entries = [[NSMutableArray alloc]init];
    self.FirstTeamName = [[NSMutableArray alloc]init];
    [self openDB];
    NSString *sql = [NSString stringWithFormat:@"SELECT * FROM FirstTbless"];
    sqlite3_stmt *statement;
    
    if (sqlite3_prepare_v2(db, [sql UTF8String], -1, &statement, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statement)== SQLITE_ROW)
        {
            char *field1 = (char *) sqlite3_column_text(statement, 0);
            NSString *FirstTeam =[[NSString alloc]initWithUTF8String:field1];
            
            
            char *field2 = (char *) sqlite3_column_text(statement, 1);
            NSString *FirstRun =[[NSString alloc]initWithUTF8String:field2];
            
            
            char *field3 = (char *) sqlite3_column_text(statement, 2);
            NSString *over =[[NSString alloc]initWithUTF8String:field3];
            
            char *field4 = (char *) sqlite3_column_text(statement, 3);
            NSString *wicket =[[NSString alloc]initWithUTF8String:field4];
            
            NSString *str = [[NSString alloc]initWithFormat:@"  %@     --    %@    --   %@",FirstRun,wicket,over ];
            
            [self.entries addObject:str];
            [self.FirstTeamName addObject:FirstTeam];
            [self.dbRun1 addObject:FirstRun];
            [self.dbWicket1 addObject:wicket];
            [self.dbOver1 addObject:over];
            NSLog(@"%@  %@ %@ %@ \n\n",FirstTeam,FirstRun,over,wicket);
            
        }
        
           }
    
    
    self.Secondentriess = [[NSMutableArray alloc]init];
    self.SecondTeamName = [[NSMutableArray alloc]init];
    [self openDB];
    NSString *sql2 = [NSString stringWithFormat:@"SELECT * FROM SecondTbless"];
    sqlite3_stmt *statement2;
    
    if (sqlite3_prepare_v2(db, [sql2 UTF8String], -1, &statement2, nil)==SQLITE_OK)
    {
        while (sqlite3_step(statement2)== SQLITE_ROW)
        {
            char *field1 = (char *) sqlite3_column_text(statement2, 0);
            NSString *SecondTeam =[[NSString alloc]initWithUTF8String:field1];
            
            
            char *field2 = (char *) sqlite3_column_text(statement2, 1);
            NSString *SecondRun =[[NSString alloc]initWithUTF8String:field2];
            
            
            char *field3 = (char *) sqlite3_column_text(statement2, 2);
            NSString *Secondover =[[NSString alloc]initWithUTF8String:field3];
            
            char *field4 = (char *) sqlite3_column_text(statement2, 3);
            NSString *Secondwicket =[[NSString alloc]initWithUTF8String:field4];
            
            NSString *str2 = [[NSString alloc]initWithFormat:@"  %@     --    %@    --   %@",SecondRun,Secondwicket,Secondover ];
            
            [self.Secondentriess addObject:str2];
            [self.SecondTeamName addObject:SecondTeam];
            [self.dbRun2 addObject:SecondRun];
            [self.dbWicket2 addObject:Secondwicket];
            [self.dbOver2 addObject:Secondover];
            
            
            
           NSLog(@"----%@  %@ %@ %@",SecondRun,Secondwicket,Secondover,Secondwicket);
            
        }
        
    }

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    return self.entries.count;
  
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *CustomCell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([CustomTableViewCell class]) forIndexPath:indexPath];
    
    
    CustomCell.FirstDescription.text = [self.entries objectAtIndex:indexPath.row];
    CustomCell.FirstTeam.text = [self.FirstTeamName objectAtIndex:indexPath.row];
    CustomCell.SecondDescription.text = [self.Secondentriess objectAtIndex:indexPath.row];
    CustomCell.SecondTeam.text = [self.SecondTeamName objectAtIndex:indexPath.row];
    
    return CustomCell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 105.0f;

}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
