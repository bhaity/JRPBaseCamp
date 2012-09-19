//
//  AddTodoListViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddTodoListViewController.h"

@interface AddTodoListViewController ()

@end

@implementation AddTodoListViewController

@synthesize todoListTitle, todoListDescription;
@synthesize textField;
@synthesize textField2;
@synthesize tap;


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
    tap = [[UITapGestureRecognizer alloc] 
           initWithTarget:self
           action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
    // UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:@"Navigation Title"];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.title = @"New To-do List";


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
-(void)cancelButtonPressed{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)doneButtonPressed{
    if(todoListTitle.length < 1){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"To-do List failed"
                                                        message:@"You must specify a title for the to-do list!" 
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil, nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        
        
    }
    else{
        //[self addToDo:todoTitle withDate:selectedDate andAssignee:selectedPerson];
        [self dismissModalViewControllerAnimated:YES];
        
    }

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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        
        
    }
    if(indexPath.section == 0){
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20,10,75,25)];
        label.textAlignment = UITextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Title:";
        [cell.contentView addSubview:label];
        
        textField = [[UITextField alloc]initWithFrame:CGRectMake(60, 12, 220, 25)];
        [textField setDelegate:self];
        textField.returnKeyType = UIReturnKeyDone;
        
        [textField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell.contentView addSubview:textField];
        
    }
    
    if(indexPath.section == 1){
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20,10,90,25)];
        label.textAlignment = UITextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Description:";
        [cell.contentView addSubview:label];
        
        textField2 = [[UITextField alloc]initWithFrame:CGRectMake(105, 12, 220, 25)];
        [textField2 setDelegate:self];
        textField2.returnKeyType = UIReturnKeyDone;
        
        [textField2 addTarget:self action:@selector(textField2Done:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell.contentView addSubview:textField2];
        
    }
    
    
    
    // Configure the cell...
    
    
    
    return cell;
}
-(IBAction)textFieldDone:(id)sender{
    
    todoListTitle = textField.text;
    NSLog(@"%@", todoListTitle);
    
    [sender resignFirstResponder];
}
-(IBAction)textField2Done:(id)sender{
    
    todoListDescription = textField2.text;
    NSLog(@"%@", todoListDescription);
    
    [sender resignFirstResponder];
}
-(void)dismissKeyboard {
    
    [textField resignFirstResponder];
    [textField2 resignFirstResponder];
    todoListTitle = textField.text;
    todoListDescription = textField2.text;
    //NSLog(@"%@", todoTitle);
    //[self.view removeGestureRecognizer:self.tap];
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
