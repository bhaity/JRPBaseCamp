//
//  TDDatePickerController.m
//
//  Created by Nathan  Reed on 30/09/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import "AssigneeTableController.h"

#import "UIImageView+AFNetworking.h"
#import <QuartzCore/QuartzCore.h>
#import "UIImage+TPAdditions.h"




@implementation AssigneeTableController
@synthesize datePicker, delegate, tableView, selectedIndexes, checkedIndexPath;

-(void)viewDidLoad {
    [super viewDidLoad];

	datePicker.date = [NSDate date];
    
    selectedIndexes = [[NSMutableArray alloc]init];

	// we need to set the subview dimensions or it will not always render correctly
	// http://stackoverflow.com/questions/1088163
	for (UIView* subview in datePicker.subviews) {
		subview.frame = datePicker.bounds;
	}
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return YES;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Uncheck the previous checked row
    if(self.checkedIndexPath)
    {
        UITableViewCell* uncheckCell = [tableView
                                        cellForRowAtIndexPath:self.checkedIndexPath];
        uncheckCell.accessoryType = UITableViewCellAccessoryNone;
    }
    if([self.checkedIndexPath isEqual:indexPath])
    {
        self.checkedIndexPath = nil;
    }
    else
    {
        UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        self.checkedIndexPath = indexPath;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSLog(@"%@",self.checkedIndexPath);
    
    
    
    
//    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
//    
//    if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
//        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
//        [selectedIndexes addObject:[NSNumber numberWithInt:indexPath.row]];
//        
//    } 
//    else {
//        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
//        [selectedIndexes removeObject:[NSNumber numberWithInt:indexPath.row]];
//        
//    }
//    
//    [tableView deselectRowAtIndexPath:indexPath animated:NO];
//    
//    for (int i = 0; i < selectedIndexes.count; i++) {
//        
//        NSLog(@"%i", [[selectedIndexes objectAtIndex:i]intValue]);
//        
//    }
    
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    globals *global = [globals sharedInstance];
    Project *p = [global.projects objectAtIndex:global.selectedRow];
    
    return [p.accesses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString* SimpleTableIdentifier = @"SimpleTableIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:SimpleTableIdentifier]; 
    
    if (cell==nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:SimpleTableIdentifier];
    } 
    
    
    //configure the cell
    globals *global = [globals sharedInstance];
    
    Project *p = [global.projects objectAtIndex:global.selectedRow];
    NSLog(@"%@", p.name);
    
    //ToDoList *tdl = [p.todolists objectAtIndex:global.selectedListIndex];
    
    
    cell.textLabel.text = [[p.accesses objectAtIndex:indexPath.row]name];
    
	NSString* imgURL = [[p.accesses objectAtIndex:indexPath.row]avatar_url];//[imageDownload thumbnailURLAtIndex:indexPath.row];
    
    UIImageView* imgV = [[UIImageView alloc]init];
    [imgV setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    cell.imageView.image = [imgV.image imageScaledToSize:CGSizeMake(43,43)];
    
    // [cell.imageView setImageWithURL:[NSURL URLWithString:imgURL] placeholderImage:[UIImage imageNamed:@"icon.png"]];
    
    cell.imageView.layer.masksToBounds = YES;
    cell.imageView.layer.cornerRadius = 5.0;

    
    if([self.checkedIndexPath isEqual:indexPath])
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
    else 
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    } 
    
    
    //cell.textLabel.text = @"aaaa";
    
//    [cell setAccessoryType:UITableViewCellAccessoryNone];
//    for (int i = 0; i < selectedIndexes.count; i++) {
//        NSUInteger num = [[selectedIndexes objectAtIndex:i] intValue];
//        
//        if (num == indexPath.row) {
//            [cell setAccessoryType:UITableViewCellAccessoryCheckmark];
//            // Once we find a match there is no point continuing the loop
//            break;
//        }
//    }
//    
    return cell;
    
}


#pragma mark -
#pragma mark Actions

-(IBAction)saveDateEdit:(id)sender {
	if([self.delegate respondsToSelector:@selector(datePickerSetDate:)]) {
		[self.delegate assigneePickerSetAssignee:self];
	}
}

-(IBAction)clearDateEdit:(id)sender {
	if([self.delegate respondsToSelector:@selector(datePickerClearDate:)]) {
		[self.delegate assigneePickerClearAssignee:self];
	}
}

-(IBAction)cancelDateEdit:(id)sender {
	if([self.delegate respondsToSelector:@selector(datePickerCancel:)]) {
		[self.delegate assigneePickerCancel:self];
	} else {
		//[self dismissSemiModalViewController:self];
	}
    
    
}

#pragma mark -
#pragma mark Memory Management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [super viewDidUnload];

	self.datePicker = nil;
	self.delegate = nil;

}



@end


