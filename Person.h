//
//  Person.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject {
    NSString* name;
    NSString* email;
    NSString* avatar_url;
}

@property (nonatomic, retain)NSString* name;
@property (nonatomic, retain)NSString* email;
@property (nonatomic, retain)NSString* avatar_url;


@end
