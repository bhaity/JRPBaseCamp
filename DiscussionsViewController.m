//
//  DiscussionsViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DiscussionsViewController.h"
#import "ADiscussionViewController.h"
#import "globals.h"
#import "Discussion.h"
#import "Project.h"

@interface DiscussionsViewController ()

@end

@implementation DiscussionsViewController
@synthesize listData2;
@synthesize listData;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    self.listData = [[NSMutableArray alloc]init ];
    self.listData2 = [[NSMutableArray alloc]init ];
    
    globals *global = [globals sharedInstance];

    Project* p = [global.projects objectAtIndex:global.selectedRow];
    
    for(int i =0;i<[p.discussions count];i++){
        Discussion* d = [p.discussions objectAtIndex:i];
        [listData addObject:d.title];
        [listData2 addObject:d.excerpt];
        
    }

    
    //self.listData = [[global.projects objectAtIndex:global];
   // self.listData2 =  //[global.topicsArray objectAtIndex:global.selectedRow];
   // self.listData3 =  //[global.topicExcerptsArray objectAtIndex:global.selectedRow];
    self.navigationItem.title = @"Discussions";

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    globals *global = [globals sharedInstance];
  //  [[global.projects objectAtIndex:global.selectedRow]topics_url];
    
    return [[[global.projects objectAtIndex:global.selectedRow]discussions]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
        
    }
    NSUInteger row = [indexPath row];
         
    
    cell.textLabel.text =  [listData objectAtIndex:row];
    
    //NSString* detail = [listData2 objectAtIndex:row];
   
//   if([detail isKindOfClass:[NSNull class]])
//   {
//       cell.detailTextLabel.text = @"";   
//   }
//   else{
//       cell.detailTextLabel.text = [listData2 objectAtIndex:row];
//   }
    
    
    
    
    //[NSString stringWithFormat:@"%@",[global.topicExcerptsArray objectAtIndex:row]];    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return  cell;

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellText = [listData objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont boldSystemFontOfSize:14];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
    return labelSize.height + 25;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    globals *global = [globals sharedInstance];
    global.selectedDiscussionIndex = indexPath.row;
    
         ADiscussionViewController *aDiscussionViewController = [[ADiscussionViewController alloc] initWithNibName:@"ADiscussionViewController" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:aDiscussionViewController animated:YES];
     
}

@end
