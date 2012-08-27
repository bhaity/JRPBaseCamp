//
//  ToDoList.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ToDoList : NSObject

@property(nonatomic, retain) NSString* name;
@property(nonatomic, retain) NSString* url;
@property(nonatomic, retain) NSMutableArray* todos;
@property BOOL isCompleted;
@property int remaining;




@end
