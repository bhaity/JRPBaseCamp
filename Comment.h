//
//  Comment.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/22/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Comment : NSObject

@property (nonatomic, retain) NSString* content;
@property (nonatomic, retain) NSString* creator_name;
@property (nonatomic, retain) NSString* creator_avatar_url;
@property (nonatomic, retain) NSString* created_at;

@end
