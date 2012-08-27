//
//  ToDo.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDo : NSObject

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain)NSString* due_at;
@property BOOL isCompleted;
@property (nonatomic, retain)NSString* parentToDoList;

@end
