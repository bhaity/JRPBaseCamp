//
//  AddTodoViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddTodoViewController.h"
#import "globals.h"


@interface AddTodoViewController ()

@end

@implementation AddTodoViewController
@synthesize selectedDate;
@synthesize selectedPerson;
@synthesize todoTitle;
@synthesize textField;
@synthesize dateLabel;
@synthesize tap;

//@synthesize datePickerView;


                                          
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
    
    tap = [[UITapGestureRecognizer alloc] 
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    [tap setCancelsTouchesInView:NO];

    
   datePickerView = [[TDDatePickerController alloc]initWithNibName:@"TDDatePickerController" bundle:nil];
    //    UINavigationBar *naviBarObj = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    //    [self.view addSubview:naviBarObj];
    
    
    UIBarButtonItem* cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelButtonPressed)];
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneButtonPressed)];
   // UINavigationItem *navigItem = [[UINavigationItem alloc] initWithTitle:@"Navigation Title"];
    
    self.navigationItem.rightBarButtonItem = doneButton;
    self.navigationItem.leftBarButtonItem = cancelButton;
    self.navigationItem.title = @"New To-do";
    
    
}


-(void)cancelButtonPressed{
    [self dismissModalViewControllerAnimated:YES];
}

-(void)doneButtonPressed{
    [self addToDo:todoTitle withDate:selectedDate andAssignee:selectedPerson];
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
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20,10,75,25)];
        label.textAlignment = UITextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:14];
        label.backgroundColor = [UIColor clearColor];
        label.text = @"Due by:";
        [cell.contentView addSubview:label];

        dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(80, 9, 200, 25)];
        dateLabel.text=@""; 
        dateLabel.backgroundColor = [UIColor clearColor];
        
        [cell.contentView addSubview:dateLabel];
        
    }
    if(indexPath.section == 2){
        
        cell.textLabel.text = @"Assignees";
        cell.textLabel.font = [UIFont boldSystemFontOfSize:14];
    }
    
    
    return cell;
}



-(void)dismissKeyboard {
   
    [textField resignFirstResponder];
    todoTitle = textField.text;
    NSLog(@"%@", todoTitle);
     //[self.view removeGestureRecognizer:self.tap];
}
//- (void)touchesEnded: (NSSet *)touches withEvent: (UIEvent *)event {
//	for (UIView* view in self.view.subviews) {
//		if ([view isKindOfClass:[UITextField class]])
//			[view resignFirstResponder];
//	}
//}
//
-(IBAction)textFieldDone:(id)sender{
    
    todoTitle = textField.text;
    NSLog(@"%@", todoTitle);
    
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
        [datePickerView setDelegate:self];
        [self presentSemiModalViewController:datePickerView];
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
    
    selectedDate = datePickerView.datePicker.date;
    NSLog(@"%@", selectedDate);
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM d yyyy "];
    dateLabel.text = [formatter stringFromDate:selectedDate];
    
    [self dismissSemiModalViewController:datePickerView];
    
    
}

-(void)datePickerClearDate:(TDDatePickerController*)viewController{
   // NSLog(@"CLEARING DATE!");
    selectedDate = NULL;
    dateLabel.text = @"";
    NSLog(@"%@", selectedDate);
    [self dismissSemiModalViewController:datePickerView];
    
}

-(void)datePickerCancel:(TDDatePickerController*)viewController{
    
    [self dismissSemiModalViewController:datePickerView];
    
    
    //[viewController dismissSemiModalViewController:viewController];
    
    NSLog(@"1234567890");
    
}

-(void)addToDo:(NSString*)title withDate:(NSDate*)date andAssignee:(Person*)person{
    
    ToDo* todo = [[ToDo alloc]init];
    todo.name = title;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
   [formatter setDateFormat:@"yyyy-MM-dd"];
    
    todo.due_at = [formatter stringFromDate:date];
    NSLog(@"%@", todo.due_at);
    NSLog(@"%@", todo.name);
    
    
    globals *global = [globals sharedInstance];
   // Project* p = [global.projects objectAtIndex:global.selectedRow];

    
    [[[[[global.projects objectAtIndex:global.selectedRow]todolists]objectAtIndex:global.selectedListIndex]todos]addObject:todo];
    
//    for (int i = 0;i<[[[[[global.projects objectAtIndex:global.selectedRow]todolists ]objectAtIndex:global.selectedListIndex]todos]count];i++){
//        NSLog(@"%@", [[[[[global.projects objectAtIndex:global.selectedRow]todolists ]objectAtIndex:global.selectedListIndex]todos]objectAtIndex:i]);
//    }
    
    
    
    NSString* testURL = @"https://basecamp.com/1931784/api/v1/projects/954014/todolists/2308424/todos.json";
    
    NSMutableURLRequest * testPostRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:testURL]];
    [testPostRequest setHTTPMethod:@"POST"];
    [testPostRequest setValue:global.authValue forHTTPHeaderField:@"Authorization"];
    
    
    NSMutableDictionary* testDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:todo.name,@"content",
                                     todo.due_at, @"due_at",
                                     NULL, @"assignee",
                                     nil];
    
    
    
    NSData* httpBodyData=[NSJSONSerialization dataWithJSONObject:testDict options:0 error:nil];
    
    [testPostRequest setHTTPBody:httpBodyData];
    [testPostRequest setValue:@"application/json; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    
    
    NSError *error = [[NSError alloc]init];
    NSHTTPURLResponse *urlResponse = nil;
    
    NSData *responseData = [NSURLConnection sendSynchronousRequest:testPostRequest returningResponse:&urlResponse error:&error];
    
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    
    
    NSLog(@"Response code: %d", [urlResponse statusCode]);
    if ([urlResponse statusCode] >=200 && [urlResponse statusCode] <300)
    {
        NSLog(@"Response ==> %@", result);
        
    }

    
}


@end
