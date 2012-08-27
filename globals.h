//
//  globals.h
//  LunchioPrototypeB
//
//  Created by Sikandar Shukla on 5/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Person.h"
#import "ToDoList.h"
#import "Attachment.h"
#import "Document.h"


@interface globals : NSObject
{
    NSMutableArray *topicsArray;
    NSMutableArray *topicExcerptsArray;
    int selectedRow;
    int selectedListIndex;
    int selectedDiscussionIndex;
    int selectedPersonIndex;
    int selectedTeamIndex;

    
    NSMutableArray *peopleNameArray;
    NSMutableArray *avatarArray;
    NSMutableArray *topicCountArray;
    NSMutableArray *projectsArray;
    NSMutableArray *emailsArray;
    NSMutableArray *todoCountArray;
    NSMutableArray *teamCountArray;
    NSMutableArray *todolistArray;
    NSMutableArray *teamArray;
    NSMutableArray *todosOnAListArray;
    
    Person * selectedPerson; 
    Person * selectedTeamMember;
    ToDoList * selectedTodoList;
    Attachment * selectedAttachment;
    Document * selectedDocument;
    
    
    NSMutableArray *people;
    NSMutableArray *projects;
    NSMutableArray *accesses;
    NSMutableArray *myTodoLists;
    
    NSString* authValue;
    //NSPerson*
    
    
}


@property (nonatomic,retain)NSMutableArray *topicsArray;
@property (nonatomic,retain)NSMutableArray *topicExcerptsArray;
@property int selectedRow;
@property int selectedListIndex;
@property int selectedDiscussionIndex;
@property int selectedPersonIndex;
@property int selectedTeamIndex;
@property (nonatomic,retain)NSMutableArray* peopleNameArray;
@property (nonatomic, retain)NSMutableArray* avatarArray;
@property (nonatomic, retain)NSMutableArray* topicCountArray;
@property (nonatomic, retain)NSMutableArray* projectsArray;
@property (nonatomic, retain)NSMutableArray* emailsArray;
@property (nonatomic, retain)NSMutableArray* todoCountArray;
@property (nonatomic, retain)NSMutableArray* teamCountArray;
@property (nonatomic, retain)NSMutableArray* todolistArray;
@property (nonatomic, retain)NSMutableArray* teamArray;
@property (nonatomic, retain)NSMutableArray* todosOnAListArray;

@property (nonatomic, retain)Person * selectedPerson;
@property (nonatomic, retain)Person * selectedTeamMember;
@property (nonatomic, retain)ToDoList * selectedTodoList;
@property (nonatomic, retain)Attachment * selectedAttachment;
@property (nonatomic, retain)Document * selectedDocument;

@property (nonatomic, retain)NSString* authValue;

@property (nonatomic, retain)NSMutableArray* people;
@property (nonatomic, retain)NSMutableArray* projects;
@property (nonatomic, retain)NSMutableArray* accesses;
@property (nonatomic, retain)NSMutableArray *myTodoLists;





// message from which our instance is obtained
+ (globals *)sharedInstance;
@end
