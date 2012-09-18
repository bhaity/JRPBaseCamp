//
//  AddTodoViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddTodoViewController.h"
#import "TDDatePickerController.h"

@interface AddTodoViewController ()

@end

@implementation AddTodoViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
       
    //    UINavigationBar *naviBarObj = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //    [self.view addSubview:naviBarObj];
    
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:nil action:nil];
   // UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:@"Navigation Title"];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.title = @"New To-do";
    
    
}


-(void)cancelButtonPressed{
    [self dismissModalViewControllerAnimated:YES];
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
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
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20,10,75,25)];
        label.textAlignment = UITextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Title:";
        [cell.contentView addSubview:label];
        
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(90, 12, 200, 25)];
        [textField setDelegate:self];
        textField.returnKeyType = UIReturnKeyDone;
        [textField addTarget:self action:@selector(textFieldDone:) forControlEvents:UIControlEventEditingDidEndOnExit];
        [cell.contentView addSubview:textField];

        }
    
    
    if(indexPath.section == 1){
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20,10,75,25)];
        label.textAlignment = UITextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Due by:";
        [cell.contentView addSubview:label];

        UIPickerView *datePicker = [[UIPickerView alloc] init];
       // datePicker setDelegate:self
       
        
        UILabel * label2 = [[UILabel alloc]initWithFrame:CGRectMake(90, 12, 200, 25)];
        label2.text=@"I am a label";
        [cell.contentView addSubview:label2];
        
                           
        UITextField *textField = [[UITextField alloc]initWithFrame:CGRectMake(110, 10, 185, 30)];
        [textField setDelegate:self];
        
        textField.inputView = datePicker;
        
    }
    if(indexPath.section == 2){
        cell.textLabel.text = @"Assignees";
    }
    
    
    return cell;
}



-(IBAction)textFieldDone:(id)sender{
    [sender resignFirstResponder];
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
    
    if(indexPath.section == 1){
        
        TDDatePickerController* datePickerView = [[TDDatePickerController alloc] 
                                                  initWithNibName:@"TDDatePickerController" 
                                                  bundle:nil];
        [datePickerView setDelegate:self];
        [self presentSemiModalViewController:datePickerView];
        //[self datePickerCancel:datePickerView];
//        [self datePickerClearDate:datePickerView];
//        [self datePickerSetDate:datePickerView];
        
       // NSLog(@"%@", datePickerView.datePicker.date);
        
        
    }
    
    if(indexPath.section == 2){
        
        
        TDSemiModalViewController *picker = [[TDSemiModalViewController alloc]init];

            [self presentSemiModalViewController:picker];
        
        
    }
    
    
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}


-(void)datePickerSetDate:(TDDatePickerController*)viewController{
    
    NSLog(@"%@", viewController.datePicker.date);
}

-(void)datePickerClearDate:(TDDatePickerController*)viewController{
    NSLog(@"CLEARING DATE!");
    
}

-(void)datePickerCancel:(TDDatePickerController*)viewController{
    
    [self dismissSemiModalViewController:viewController];
    
    
    //[viewController dismissSemiModalViewController:viewController];
    
    NSLog(@"1234567890");
    
}


@end
