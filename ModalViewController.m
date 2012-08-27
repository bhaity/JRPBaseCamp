//
//  ModalViewController.m
//  BasecampHelper
//
//  Created by Sikandar Shukla on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ModalViewController.h"
#import "globals.h"

@interface ModalViewController ()

@end

@implementation ModalViewController
@synthesize listData2;
@synthesize listData3;

//@synthesize topicsArray;
//@synthesize topicsExcerptArray;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    globals *global = [globals sharedInstance];
    self.listData2 =  [global.topicsArray objectAtIndex:global.selectedRow];
    self.listData3 =  [global.topicExcerptsArray objectAtIndex:global.selectedRow];
    
//    NSLog(@"%i", global.selectedRow);
//    NSLog(@"%@", [global.topicsArray objectAtIndex:global.selectedRow]);
    
    
   // NSLog(@"%@", global.topicsArray);
    
    //global.topicsArray = [[NSMutableArray alloc] init];
    
    
    
    
    // Do any additional setup after loading the view from its nib.
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

- (IBAction)dismissView:(id)sender {
    
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Table View Data Source Methods


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.listData2 count];
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString* SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier];
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    }
    NSUInteger row = [indexPath row];
   // globals *global = [globals sharedInstance];
    cell.textLabel.text = [listData2 objectAtIndex:row];
    
    NSString* detail = [listData3 objectAtIndex:row];
    
    if([detail isKindOfClass:[NSNull class]])
    {
     cell.detailTextLabel.text = @"";   
    }
    else{
        cell.detailTextLabel.text = [listData3 objectAtIndex:row];
    }
    //[NSString stringWithFormat:@"%@",[global.topicExcerptsArray objectAtIndex:row]];    
    
    return  cell;
    
}


@end
