//
//  Project.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Project : NSObject{
    NSString* name;
    NSString* accesses_url;
    NSString* attachments_url;
    NSString* documents_url;
    NSString* topics_url;
    NSString* todolists_url;
    
    NSMutableArray* discussions;
    NSMutableArray* todolists;
    NSMutableArray* accesses;
    NSMutableArray* attachments;
    NSMutableArray* documents;
    int ID;
    
    
    
}

@property int ID;
@property (nonatomic,retain)NSString* name;
@property (nonatomic,retain)NSString* accesses_url;
@property (nonatomic,retain)NSString* attachments_url;
@property (nonatomic,retain)NSString* documents_url;
@property (nonatomic,retain)NSString* topics_url;
@property (nonatomic,retain)NSString* todolists_url;

@property (nonatomic, retain)NSMutableArray* accesses;
@property (strong, nonatomic)NSMutableArray* discussions;
@property (nonatomic, retain)NSMutableArray* todolists;
@property (nonatomic, retain)NSMutableArray* attachments;
@property (nonatomic, retain)NSMutableArray* documents;

@end
