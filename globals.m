//
//  globals.m
// 
//
//  Created by Sikandar Shukla on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "globals.h"

@implementation globals

@synthesize topicsArray;
@synthesize topicExcerptsArray;
@synthesize selectedRow;
@synthesize peopleNameArray;
@synthesize avatarArray;
@synthesize topicCountArray;
@synthesize projectsArray;
@synthesize emailsArray;
@synthesize teamCountArray;
@synthesize todoCountArray;
@synthesize teamArray;
@synthesize todolistArray;
@synthesize todosOnAListArray;
@synthesize selectedListIndex;
@synthesize selectedDiscussionIndex;
@synthesize selectedPersonIndex;
@synthesize selectedTeamIndex;
@synthesize people;
@synthesize projects;
@synthesize accesses;
@synthesize selectedTeamMember;
@synthesize myTodoLists;

@synthesize selectedTodoList;
@synthesize selectedPerson;
@synthesize selectedAttachment;
@synthesize selectedDocument;

@synthesize authValue;


+ (globals *)sharedInstance
{
    // the instance of this class is stored here
    static globals *myInstance = nil;
    
    // check to see if an instance already exists
    if (nil == myInstance) {
        myInstance  = [[[self class] alloc] init];
        // initialize variables here
    }
    // return the instance of this class
    return myInstance;
}
@end
