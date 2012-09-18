//
//  TeamViewController.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TeamViewController : UITableViewController

@property (nonatomic, retain)NSMutableArray* listData;
@property (nonatomic, retain)NSMutableArray* listData2;

-(void)teamEmail;

@end
