//
//  Discussion.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Discussion : NSObject

@property (nonatomic, retain) NSString* title;
@property (nonatomic, retain) NSString* excerpt;
@property (nonatomic, retain) NSString* url;
@property (nonatomic, retain) NSMutableArray* comments;

@end
