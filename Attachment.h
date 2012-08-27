//
//  Attachment.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Attachment : NSObject{
    
    NSString* name;
    NSString* url;
    
}

@property(nonatomic, retain)NSString* name;
@property(nonatomic, retain)NSString* url;

@end
