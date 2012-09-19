//
//  AddTodoViewController.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDDatePickerController.h"
#import "AssigneeTableController.h"
#import "ToDo.h"
#import "Person.h"
#import "Project.h"
#import "ToDoList.h"


@interface AddTodoViewController : UITableViewController <UITextFieldDelegate>
{
    IBOutlet TDDatePickerController* datePickerView;
    IBOutlet AssigneeTableController* assigneeTable;
}

//@property (strong, nonatomic) NSArray* fieldLabels;
//@property (strong, nonatomic) NSMutableDictionary * tempValues;
@property (strong, nonatomic) UITextField* textField;
@property (strong, nonatomic) ToDo* todo;

@property(strong, nonatomic) IBOutlet UILabel* dateLabel;
@property(strong, nonatomic)IBOutlet UILabel* assigneeLabel;

@property(strong, nonatomic)UIGestureRecognizer *tap;





//@property(strong, nonatomic) TDDatePickerController* datePickerView;

@property(strong, nonatomic) NSDate* selectedDate;
@property(strong, nonatomic) Person* selectedPerson;
@property(strong, nonatomic)NSString* todoTitle; 

@end
