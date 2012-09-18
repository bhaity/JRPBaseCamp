//
//  ToDosViewControllerViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ToDosViewController.h"
#import "Project.h"
#import "ToDoList.h"
#import "ToDo.h"
#import "globals.h"
#import "AddTodoViewController.h"
#import "AddTodoNavController.h"


@interface ToDosViewController ()

@end


@implementation ToDosViewController

//@synthesize listData;
//@synthesize listData2;

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
    //self.listData = [[NSMutableArray alloc]init];
   // self.listData2 = [[NSMutableArray alloc]init];
    
    globals *global = [globals sharedInstance];
    Project *p = [global.projects objectAtIndex:global.selectedRow];
    ToDoList *tdl = [p.todolists objectAtIndex:global.selectedListIndex];
    
    for(int i =0;i<[tdl.todos count];i++){
        ToDo *t = [tdl.todos objectAtIndex:i];
        //NSString* caption = [NSString stringWithFormat:@"Due at %@", t.due_at];
        //[listData addObject:t.name];
        //[listData2 addObject:t.due_at];
        
    }
    self.navigationItem.title = @"To-dos";
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTodo)];
      self.navigationItem.rightBarButtonItem = addButton;
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)viewWillAppear:(BOOL)animated{
    [self.tableView reloadData];
}
-(void)addTodo{

//    AddTodoViewController *add = [[AddTodoViewController alloc]init];
//    [self presentModalViewController:add animated:YES];

    // Present it as a modal view and wrap the controller in a navigation controller to provide a navigation bar in case you want to add edit, save, etc buttons
    // ModalViewController is the view controller file name that gets the .h file included at the top, also make sure the XIB name is the same name
    AddTodoViewController *addController = [[AddTodoViewController alloc] initWithNibName:@"AddTodoViewController" bundle:nil];
    //addController.delegate = self;
    
    // This is where you wrap the view up nicely in a navigation controller
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:addController];
    
    // You can even set the style of stuff before you show it
   // navigationController.navigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    // And now you want to present the view in a modal fashion all nice and animated
    
    
    
    
    //navigationController.navigationItem
    [self presentModalViewController:navigationController animated:YES];
    
    // make sure you release your stuff

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
    return [[[[[global.projects objectAtIndex:global.selectedRow]todolists]objectAtIndex:global.selectedListIndex]todos]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString* SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier]; 
    
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
        cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
        cell.textLabel.numberOfLines = 0;
        cell.textLabel.font = [UIFont systemFontOfSize:14];
        
    }
    NSUInteger row = [indexPath row];
    cell.detailTextLabel.font = [UIFont italicSystemFontOfSize:10];
    
    
    globals *global = [globals sharedInstance];
    Project *p = [global.projects objectAtIndex:global.selectedRow];
    ToDoList *tdl = [p.todolists objectAtIndex:global.selectedListIndex];
    
    for(int i =0;i<[tdl.todos count];i++){
        ToDo *t = [tdl.todos objectAtIndex:i];
    }
    
    
    cell.textLabel.text =  [[tdl.todos objectAtIndex:row]name];
    
    if ([[[tdl.todos objectAtIndex:row]due_at] isKindOfClass:[NSNull class]])
    {
        cell.detailTextLabel.text = @"";
    }
    else{
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [formatter dateFromString:[[tdl.todos objectAtIndex:row]due_at]];
        [formatter setDateFormat:@"MM/dd/yy"];
        NSString* dateString = [formatter stringFromDate:date];
        cell.detailTextLabel.text =[NSString stringWithFormat:@"Due by %@", dateString];
    }

    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    globals *global = [globals sharedInstance];
    Project *p = [global.projects objectAtIndex:global.selectedRow];
    ToDoList *tdl = [p.todolists objectAtIndex:global.selectedListIndex];

    
    NSString *cellText = [[tdl.todos objectAtIndex:indexPath.row]name];
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
}

@end
