//
//  MyTodoListsViewController.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyTodoListsViewController : UITableViewController

@property (nonatomic, retain)NSMutableArray* listData;
@property (nonatomic, retain)NSMutableArray* listData2;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
