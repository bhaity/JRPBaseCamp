//
//  ProjectsSecondViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProjectsSecondViewController.h"
#import "DiscussionsViewController.h"
#import "TodoListViewController.h"
#import "FilesViewController.h"
#import "TeamViewController.h"
#import "globals.h"
#import "DocumentsViewController.h"




@interface ProjectsSecondViewController ()

@end

@implementation ProjectsSecondViewController

NSMutableArray* listOfOptions;// = [[NSMutableArray alloc]init];


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
    globals *global = [globals sharedInstance];

    
    listOfOptions = [[NSMutableArray alloc] init];
    //---add items---
    [listOfOptions addObject:@"Discussions"];
    [listOfOptions addObject:@"To-do Lists"];
    [listOfOptions addObject:@"Files"];
    [listOfOptions addObject:@"Text Documents"];
    [listOfOptions addObject:@"Team"];
    //---set the title---
    self.navigationItem.title = [[global.projects objectAtIndex:global.selectedRow]name];


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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [listOfOptions count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSString *cellValue = [listOfOptions objectAtIndex:indexPath.row];
    cell.textLabel.text = cellValue;   
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        DiscussionsViewController *discussionsViewController =
        [[DiscussionsViewController alloc]
         initWithNibName:@"ProjectsSecondViewController" bundle:nil];
        [self.navigationController pushViewController:discussionsViewController animated:YES];
    }
     if(indexPath.row == 1){
         TodoListViewController *todoListViewController =
         [[TodoListViewController alloc]
          initWithNibName:@"TodoListViewController" bundle:nil];
         [self.navigationController pushViewController:todoListViewController animated:YES];
     }
    if(indexPath.row == 4){
        TeamViewController *teamViewController =
        [[TeamViewController alloc]
         initWithNibName:@"TeamViewController" bundle:nil];
        [self.navigationController pushViewController:teamViewController animated:YES];
    }
    if(indexPath.row == 2){
        FilesViewController *filesViewController =
        [[FilesViewController alloc]
         initWithNibName:@"FilesViewController" bundle:nil];
        [self.navigationController pushViewController:filesViewController animated:YES];
    }
    if(indexPath.row == 3){
        DocumentsViewController *documentsViewController =
        [[DocumentsViewController alloc]
         initWithNibName:@"DocumentsViewController" bundle:nil];
        [self.navigationController pushViewController:documentsViewController animated:YES];
    }
     else{
         NSLog(@"other view controller");
     }
        
}

@end
