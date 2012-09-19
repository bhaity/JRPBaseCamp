//
//  TDDatePickerController.h
//
//  Created by Nathan  Reed on 30/09/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"TDSemiModal.h"
#import "Project.h"
#import "Person.h"
#import "ToDo.h"
#import "ToDoList.h"
#import "globals.h"


@interface AssigneeTableController : TDSemiModalViewController {
	id delegate;
    NSIndexPath* checkedIndexPath;
}

@property (nonatomic, strong) IBOutlet id delegate;
@property (nonatomic, strong) IBOutlet UIDatePicker* datePicker;
@property (nonatomic, strong) IBOutlet UITableView* tableView;
@property(nonatomic, strong) NSMutableArray* selectedIndexes;

@property (nonatomic, retain) NSIndexPath* checkedIndexPath;



-(IBAction)saveDateEdit:(id)sender;
-(IBAction)clearDateEdit:(id)sender;
-(IBAction)cancelDateEdit:(id)sender;

@end

@interface NSObject (AssigneeTableControllerDelegate)
-(void)assigneePickerSetAssignee:(AssigneeTableController*)viewController;
-(void)assigneePickerClearAssignee:(AssigneeTableController*)viewController;
-(void)assigneePickerCancel:(AssigneeTableController*)viewController;
@end

