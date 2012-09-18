//
//  PeopleViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


//
//  FirstViewController.m
//  BasecampHelper
//
//  Created by Sikandar Shukla on 8/16/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PeopleViewController.h"
#import "NSObject+SBJSON.h"
#import "NSData+Additions.h"
#import "ModalViewController.h"
#import "globals.h"
#import "ProfileViewController.h"
#import "Person.h"
//#import "AsyncImageView.h"
#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+TPAdditions.h"




@interface PeopleViewController ()

@end

@implementation PeopleViewController
@synthesize listData;
@synthesize listData2;

@synthesize projectsArray;
@synthesize topicCountArray;
@synthesize tableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    

//    
//    self.listData2 = [[NSMutableArray alloc]init ];
//    self.listData = [[NSMutableArray alloc]init];
//    
//    globals *global = [globals sharedInstance];
//        
//    for(int i=0;i<[global.people count];i++){
//        Person *pp = [global.people objectAtIndex:i];
//        [listData addObject:pp.name];
//        [listData2 addObject:pp.avatar_url];
//        
//    }

    
    //self.projectsArray = [[NSMutableArray alloc] init];
    //self.topicCountArray = [[NSMutableArray alloc] init];
   // self.listData = global.peopleNameArray;
    self.navigationItem.title = @"People";
    
    
}

-(void)viewDidAppear:(BOOL)animated{
    [self.tableView reloadData];
}




- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    self.listData = nil;
    
    
    
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    
    
}




#pragma mark -
#pragma mark Table View Data Source Methods
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    globals *global = [globals sharedInstance];

    return [global.people count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
        return 1;
   }

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    return 50;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    

    globals *global = [globals sharedInstance];
    

    static NSString* SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier]; 
    
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    }
//     else {
//        AsyncImageView* oldImage = (AsyncImageView*)
//        [cell.contentView viewWithTag:999];
//        [oldImage removeFromSuperview];
//        
//        UILabel* oldText = (UILabel*)
//        [cell.contentView viewWithTag:888];
//        [oldText removeFromSuperview];
//    }
    
    cell.textLabel.text = [[global.people objectAtIndex:indexPath.row]name];
    
    
    
    NSString* imgURL =  [[global.people objectAtIndex:indexPath.row]avatar_url];
    UIImageView* imgV = [[UIImageView alloc]init];
    [imgV setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    
    cell.imageView.image = [imgV.image imageScaledToSize:CGSizeMake(43,43)];
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 5.0;

    
   // [cell.imageView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    // THIS SNIPPET MAKES THE IMAGES LOAD WELL, BUT SMALL ON RETINA DISPLAY
    
    
    
       //cell.imageView.frame = CGRectMake(0, 0, 80, 80);
    
    
    //   
//    if ([[UIScreen mainScreen] respondsToSelector:@selector(scale)] && [[UIScreen mainScreen] scale] == 2){
//        //iPhone 4
//    }
//    
//      cell.imageView.contentScaleFactor = [UIScreen mainScreen].scale;
//    
    //    
    
//	CGRect frame;
//	frame.size.width=50; frame.size.height=50;
//	frame.origin.x=0; frame.origin.y=0;
//	AsyncImageView* asyncImage = [[AsyncImageView alloc]
//                                   initWithFrame:frame];
//	asyncImage.tag = 999;
//    
//    
//    
//    CGRect textframe;
//	textframe.size.width=200; textframe.size.height=50;
//	textframe.origin.x=60; frame.origin.y=0;
//    UILabel* customtext = [[UILabel alloc]initWithFrame:textframe];
//    customtext.tag = 888;
//    
//    
//    
//    
//    globals *global = [globals sharedInstance];
//    Person *p= [global.people objectAtIndex:indexPath.row];
//
//	NSURL* url = [NSURL URLWithString:p.avatar_url];//[imageDownload thumbnailURLAtIndex:indexPath.row];
//	[asyncImage loadImageFromURL:url];
//    
//    customtext.text = p.name;
//    [customtext setFont:[UIFont boldSystemFontOfSize:18]];
//    
//	[cell.contentView addSubview:asyncImage];
//    [cell.contentView addSubview:customtext];
    
    
    
    
    
    
    
    
    
    
  /*  static NSString* SimpleTableIdentifier = @"SimpleTableIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    }
    globals *global = [globals sharedInstance];
    
    NSUInteger row = [indexPath row];
    //cell.textLabel.text = [listData objectAtIndex:row];
    Person* p = [[Person alloc]init];
    p = [global.people objectAtIndex:row];
    cell.textLabel.text = p.name;
    
    NSString* imgURL = p.avatar_url;//[global.avatarArray objectAtIndex:row];
    NSURL *url = [NSURL URLWithString:imgURL];
//    NSData *data = [NSData dataWithContentsOfURL:url];
//    UIImage *img = [[UIImage alloc] initWithData:data];
//    cell.imageView.image = img;

    //get a dispatch queue
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //this will start the image loading in bg
    dispatch_async(concurrentQueue, ^{        
        NSData *image = [[NSData alloc] initWithContentsOfURL:url];
        //this will set the image when loading is finished
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.imageView.image = [UIImage imageWithData:image];
        });
    });
    
    
   // cell.detailTextLabel.text = [NSString stringWithFormat:@"Discussions: %@",[topicCountArray objectAtIndex:row]];    
    */
    
    return cell;
    
}

-(NSIndexPath*)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSInteger row = [indexPath row];
    //    if (row==0){
    //        return nil;
    //  }
    return indexPath;
}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //    NSUInteger row = [indexPath row];
    //    
    // NSString *rowValue = [listData objectAtIndex:row];
    
   /* globals *global = [globals sharedInstance];
    global.selectedRow = indexPath.row;
    
    NSString* name = [global.peopleNameArray objectAtIndex:global.selectedRow];
    NSString* email = [global.emailsArray objectAtIndex:global.selectedRow];
    
    UIAlertView *emailAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Emailing %@",name] 
                                                        message:[NSString stringWithFormat:@"%@",email]
                                                       delegate:self 
                                              cancelButtonTitle:@"OK" 
                                              otherButtonTitles:nil, nil];
    [emailAlert show];
    */
    globals *global = [globals sharedInstance];
    global.selectedPersonIndex = indexPath.row;
    global.selectedPerson = [global.people objectAtIndex:global.selectedPersonIndex];
    
    ProfileViewController *profViewController =
    [[ProfileViewController alloc]init];

    [UIView beginAnimations:@"animation" context:nil];
    [self.navigationController pushViewController: profViewController animated:NO];
    [UIView setAnimationDuration: 0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO]; 
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [UIView commitAnimations];
    
//     ModalViewController *mvc = [[ModalViewController alloc] init];  
//    mvc.hidesBottomBarWhenPushed = NO;
//    [mvc setModalTransitionStyle:UIModalTransitionStyleFlipHorizontal];
//   [self presentModalViewController:mvc animated:YES];
    
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

@end
