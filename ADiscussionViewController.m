//
//  ADiscussionViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ADiscussionViewController.h"
#import "globals.h"
#import "Project.h"
#import "Discussion.h"
#import "Comment.h"
#import "NSString_stripHtml.h"
#import "UIImageView+AFNetworking.h"
#import "AFImageRequestOperation.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+TPAdditions.h"






@interface ADiscussionViewController (){


}
@end

@implementation ADiscussionViewController

@synthesize listData;
@synthesize listData2;
@synthesize listData3;

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
    self.listData = [[NSMutableArray alloc]init];
    self.listData2 = [[NSMutableArray alloc]init];
    self.listData3 = [[NSMutableArray alloc]init];
    
    globals *global = [globals sharedInstance];
    Project *p = [global.projects objectAtIndex:global.selectedRow];
    
    
    Discussion *d = [p.discussions objectAtIndex:global.selectedDiscussionIndex];
    
    for(int i =0;i<[d.comments count];i++){
        Comment *c = [d.comments objectAtIndex:i];
       
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [formatter dateFromString:c.created_at];
        [formatter setDateFormat:@"MM/dd/yy"];
        NSString* dateString = [formatter stringFromDate:date];
        
        //NSLog(@"%@", dateString);
        NSString* caption = [NSString stringWithFormat:@"Posted by %@ on %@", c.creator_name, dateString];
        
        
        [listData addObject:[c.content stripHtml]];
        [listData2 addObject:caption];
        [listData3 addObject:c.creator_avatar_url];
        
   
        
    }
    self.navigationItem.title = @"Comments";
   // self.navigationItem.prompt = [NSString stringWithFormat:@"%@",d.title];



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
    return [[[[[global.projects objectAtIndex:global.selectedRow]discussions]objectAtIndex:global.selectedDiscussionIndex]comments]count];
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

    cell.textLabel.text =  [listData objectAtIndex:row];
    
    
    
    cell.detailTextLabel.text = [listData2 objectAtIndex:row];
    
    
    
    NSString* imgURL =  [listData3 objectAtIndex:row];
   // NSURL *url = [NSURL URLWithString:imgURL];
    
  //  [cell.imageView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    UIImageView* imgV = [[UIImageView alloc]init];
    [imgV setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    cell.imageView.image = [imgV.image imageScaledToSize:CGSizeMake(50,50)];
    
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 5.0;
   // AFImageRequestOperation *imgRequest = 
    
//    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    //this will start the image loading in bg
//    dispatch_async(concurrentQueue, ^{        
//        NSData *image = [[NSData alloc] initWithContentsOfURL:url];
//        //this will set the image when loading is finished
//        dispatch_async(dispatch_get_main_queue(), ^{
//            cell.imageView.image = [UIImage imageWithData:image];
//        });
//    });
    
    
    

    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    NSString *cellText = [listData objectAtIndex:indexPath.row];
    UIFont *cellFont = [UIFont systemFontOfSize:14];
    CGSize constraintSize = CGSizeMake(280.0f, MAXFLOAT);
    CGSize labelSize = [cellText sizeWithFont:cellFont constrainedToSize:constraintSize lineBreakMode:UILineBreakModeWordWrap];
    
   // CGSize imageSize = [cell
    
    return labelSize.height + 60;
}





- (NSString *)flattenHTML:(NSString *)html {
    
    NSScanner *thescanner;
    NSString *text = nil;
    
    thescanner = [NSScanner scannerWithString:html];
    
    while ([thescanner isAtEnd] == NO) {
        
        // find start of tag
        [thescanner scanUpToString:@"<" intoString:NULL] ; 
        
        // find end of tag
        [thescanner scanUpToString:@">" intoString:&text] ;
        
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@" "];
        
    } // while //
    
    return html;
    
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
