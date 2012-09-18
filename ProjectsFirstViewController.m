//
//  ProjectsFirstViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectsFirstViewController.h"
#import "ProjectsSecondViewController.h"
#import "globals.h"

@interface ProjectsFirstViewController ()

@end

@implementation ProjectsFirstViewController
@synthesize listData;
@synthesize projectsArray;
@synthesize topicCountArray;
//@synthesize tableView;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{//---initialize the arrays---
    

    [super viewDidLoad];   
    self.navigationItem.title = @"Projects";
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;


- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
       self.listData = nil;
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

            return 1;
    }


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    globals *global = [globals sharedInstance];
    return [global.projects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                 initWithStyle:UITableViewCellStyleSubtitle
                 reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    globals *global = [globals sharedInstance];
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [[global.projects objectAtIndex:row]name];
    
   // UIImage *icon = [UIImage imageWithContentsOfFile: imagePath];
   // cell.imageView.image = icon;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
//    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ discussions, %@ todo lists, %@ people",[global.topicCountArray objectAtIndex:row],[global.todoCountArray objectAtIndex:row],[global.teamCountArray objectAtIndex:row]];    
    
    return cell;
   
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

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSInteger row = [indexPath row];
    //    if (row==0){
    //        return nil;
    //  }
    return indexPath;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    globals *global = [globals sharedInstance];
    global.selectedRow = indexPath.row;
    ProjectsSecondViewController *secondViewController =
    [[ProjectsSecondViewController alloc]
     initWithNibName:@"ProjectsSecondViewController" bundle:nil];
    
    [self.navigationController pushViewController:secondViewController animated:YES];
   
}

@end
