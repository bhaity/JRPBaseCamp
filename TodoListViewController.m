//
//  TodoListViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TodoListViewController.h"
#import "ToDosViewController.h"
#import "globals.h"
#import "Project.h"
#import "ToDoList.h"
#import "AddTodoListViewController.h"

@interface TodoListViewController ()

@end

@implementation TodoListViewController
@synthesize listData4;
@synthesize listData5;

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
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addToDoList)];
    self.navigationItem.rightBarButtonItem = addButton;
    
  
    
    
    globals *global = [globals sharedInstance];
    self.listData4 =  [[NSMutableArray alloc]init];
    self.listData5 =  [[NSMutableArray alloc]init];
                       
    self.navigationItem.title = @"To-do Lists";
    
    Project* p = [global.projects objectAtIndex:global.selectedRow];
    
    
    
    for(int i =0;i<[p.todolists count];i++){
        ToDoList * t = [p.todolists objectAtIndex:i];

        [listData4 addObject:t.name];
        NSString* remaining = [NSString stringWithFormat:@"%i", t.remaining];
        [listData5 addObject:remaining];
        
    }
    
    //NSLog(@"%@", listData4);
    
  //  NSLog(@"%@", listData5);
    
   
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)addToDoList{
    
    AddTodoListViewController *addController = [[AddTodoListViewController alloc] initWithNibName:@"AddTodoListViewController" bundle:nil];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
        [self presentModalViewController:navigationController animated:YES];
    
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

    return [[[global.projects objectAtIndex:global.selectedRow]todolists]count];
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
    cell.textLabel.text = [listData4 objectAtIndex:row];
    NSString* subtitle = [NSString stringWithFormat:@"%@ to-dos", [listData5 objectAtIndex:row]];
    cell.detailTextLabel.text = subtitle;
    cell.detailTextLabel.font = [UIFont italicSystemFontOfSize:10];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellText = [listData4 objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont systemFontOfSize:14];
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
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    
    globals *global = [globals sharedInstance];
    global.selectedListIndex = indexPath.row;
    
    ToDosViewController *todosViewController =[[ToDosViewController alloc] initWithNibName:@"ToDosViewController" bundle:nil];
    [self.navigationController pushViewController:todosViewController animated:YES];
    
}

@end
