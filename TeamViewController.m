//
//  TeamViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TeamViewController.h"
#import "globals.h"
#import "Project.h"
#import "Person.h"
#import "NSData+Additions.h"
#import "ProfileViewController.h"
#import "AsyncImageView.h"

@interface TeamViewController ()

@end

@implementation TeamViewController

@synthesize listData;
@synthesize listData2;

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
    
    for(int i =0;i<[p.accesses count];i++){
        Person *pp = [p.accesses objectAtIndex:i];
        [listData addObject:pp.name];
        [listData2 addObject:pp.avatar_url];
        
    }
       self.navigationItem.title = @"Team";


    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}








- (void)viewDidUnload
{
    [super viewDidUnload];
    self.listData2 = nil;
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
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    globals *global = [globals sharedInstance];
    return [[[global.projects objectAtIndex:global.selectedRow]accesses]count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
    static NSString* SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier]; 
    
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    } else {
        AsyncImageView* oldImage = (AsyncImageView*)
        [cell.contentView viewWithTag:999];
        [oldImage removeFromSuperview];
        
        UILabel* oldText = (UILabel*)
        [cell.contentView viewWithTag:888];
        [oldText removeFromSuperview];
    }
    
	CGRect frame;
	frame.size.width=50; frame.size.height=50;
	frame.origin.x=0; frame.origin.y=0;
	AsyncImageView* asyncImage = [[AsyncImageView alloc]
                                  initWithFrame:frame];
	asyncImage.tag = 999;
    
    
    
    CGRect textframe;
	textframe.size.width=200; textframe.size.height=50;
	textframe.origin.x=60; frame.origin.y=0;
    UILabel* customtext = [[UILabel alloc]initWithFrame:textframe];
    customtext.tag = 888;
    
    
    
    
   // globals *global = [globals sharedInstance];
   // Person *p= [global.people objectAtIndex:indexPath.row];
    
	NSURL* url = [NSURL URLWithString:[listData2 objectAtIndex:indexPath.row]];//[imageDownload thumbnailURLAtIndex:indexPath.row];
	[asyncImage loadImageFromURL:url];
    
    customtext.text = [listData objectAtIndex:indexPath.row];
    [customtext setFont:[UIFont boldSystemFontOfSize:18]];
    
	[cell.contentView addSubview:asyncImage];
    [cell.contentView addSubview:customtext];
    
    
    /*  static NSString* SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier]; 
    
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    }
    NSUInteger row = [indexPath row];
    
    
    cell.textLabel.text =  [listData objectAtIndex:row];
    
    NSString* imgURL =  [listData2 objectAtIndex:row];
    NSURL *url = [NSURL URLWithString:imgURL];
    
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //this will start the image loading in bg
    dispatch_async(concurrentQueue, ^{        
        NSData *image = [[NSData alloc] initWithContentsOfURL:url];
        //this will set the image when loading is finished
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:image];
        });
    });
 */
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
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
    global.selectedPersonIndex = indexPath.row;
    global.selectedPerson = [[[global.projects objectAtIndex:global.selectedRow]accesses]objectAtIndex:global.selectedPersonIndex];
    
    ProfileViewController *profViewController =
    [[ProfileViewController alloc]init];
    
    [UIView beginAnimations:@"animation" context:nil];
    [self.navigationController pushViewController: profViewController animated:NO];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO]; 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [UIView commitAnimations];
}

@end
