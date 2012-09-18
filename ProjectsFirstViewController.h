//
//  ProjectsFirstViewController.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProjectsFirstViewController : UITableViewController

@property (strong, nonatomic) NSArray *listData;
@property(nonatomic,retain) NSMutableArray *projectsArray; 
@property(nonatomic,retain) NSMutableArray *topicCountArray;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end

