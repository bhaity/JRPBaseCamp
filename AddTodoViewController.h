//
//  AddTodoViewController.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 9/14/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ToDo.h"

@interface AddTodoViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) NSArray* fieldLabels;
@property (strong, nonatomic) NSMutableDictionary * tempValues;
@property (strong, nonatomic) UITextField* currentTextField;
@property (strong, nonatomic) ToDo* todo;

@end
