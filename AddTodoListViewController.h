//
//  AddTodoListViewController.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 9/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "globals.h"
#import "Project.h"
#import "ToDoList.h"


@interface AddTodoListViewController : UITableViewController <UITextFieldDelegate>

@property(strong, nonatomic)NSString* todoListTitle; 
@property(strong, nonatomic)UITextField *textField;
@property(strong, nonatomic)UITextField *textField2;
@property(strong, nonatomic)NSString* todoListDescription; 
@property(strong, nonatomic)UIGestureRecognizer *tap;

-(void)addTodoList:(NSString*)title withDescription:(NSString*)description;
@end
