//
//  HomeViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HomeViewController.h"
#import "MBProgressHUD.h"
#import "globals.h"
#import "NSData+Additions.h"
#import "NSObject+SBJSON.h"
#import "Person.h"
#import "Project.h"
#import "Discussion.h"
#import "ToDoList.h"
#import "Comment.h"
#import "ToDo.h"
#import "Attachment.h"
#import "Document.h"
 
@interface HomeViewController ()
@end

@implementation HomeViewController
@synthesize UserField;
@synthesize PasswordField;

MBProgressHUD *HUD;
NSString* username;
NSString* password;


- (void)hudWasHidden { // Remove HUD from screen when the HUD was hidden 
    [HUD removeFromSuperview]; 
}


- (IBAction) showWithLabel:(id)sender {
    // Should be initialized with the windows frame so the HUD disables all user input by covering the entire screen HUD = [[MBProgressHUD alloc] initWithWindow:[[[UIApplication]] sharedApplication].keyWindow];
    // Add HUD to screen [self.view.window addSubview:HUD];
    // Register for HUD callbacks so we can remove it from the window at the right time HUD.delegate = self;
    HUD.labelText = @"Loading";
    // Show the HUD while the provided method executes in a new thread [HUD showWhileExecuting:@selector(myTask) onTarget:self withObject:nil animated:YES];
}

- (IBAction)loginButtonPressed:(id)sender {
    globals *global = [globals sharedInstance];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Login to Basecamp"
                                                    message:@"Enter your details below." 
                                                   delegate:self 
                                          cancelButtonTitle:@"Cancel" 
                                          otherButtonTitles:@"Login", nil];
    alert.alertViewStyle = UIAlertViewStyleLoginAndPasswordInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *title = [alertView buttonTitleAtIndex:buttonIndex];
    
   if([title isEqualToString:@"Login"])
   {
        UITextField *user = [alertView textFieldAtIndex:0];
        UITextField* pass = [alertView textFieldAtIndex:1];
        username = user.text;
        password = pass.text;
    
        if (buttonIndex == 1)
        {
            HUD = [[MBProgressHUD alloc] initWithView:self.view];
            HUD.labelText = @"Connecting...";
            //   HUD.mode = MBProgressHUDMo;
            [self.view addSubview:HUD];
            [HUD show:YES];
            [HUD showWhileExecuting:@selector(connectBasecamp) onTarget:self withObject:nil animated:YES];
        }
        
   }
    
}


- (IBAction)backgroundTap:(id)sender{
    [UserField resignFirstResponder];
    [PasswordField resignFirstResponder];
}

- (void) connectBasecamp
{
    globals *global = [globals sharedInstance];
    global.avatarArray = [[NSMutableArray alloc]init];
    
    UIAlertView *erroralert = [[UIAlertView alloc] initWithTitle:@"Whoops!" 
                                                    message:@" There was a problem logging in. Check your username and password and try again."
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                               
                                          otherButtonTitles:nil, nil];
    
    UIAlertView *confalert = [[UIAlertView alloc] initWithTitle:@"Success!" 
                                                         message:[NSString stringWithFormat:@"You are now logged in as %@.",username]
                                                        delegate:self 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil, nil];
    
    
    //Basic Auth
    NSString* URL = @"https://basecamp.com/1931784/api/v1/projects.json";
    NSString *authStr = [NSString stringWithFormat:@"%@:%@",username,password];
    NSData *authData = [authStr dataUsingEncoding:NSUTF8StringEncoding];
    NSString *authValue = [NSString stringWithFormat:@"Basic %@", [authData base64Encoding]];
    global.authValue = authValue;
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:URL]];
    [request setValue:authValue forHTTPHeaderField:@"Authorization"];
    [request setValue:@"bhaity@gmail.com" forHTTPHeaderField:@"Contact"];
    
    // Perform request and get JSON back as a NSData object
    NSError *error = nil;
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    if (error){
        [erroralert show];
    }
    else{
        [confalert show];
        
        global.people = [[NSMutableArray alloc]init];
        global.projects = [[NSMutableArray alloc]init];
        global.accesses = [[NSMutableArray alloc]init];
        global.myTodoLists = [[NSMutableArray alloc]init];
        
       
        
    //new request to view people.
    NSString* peopleURL = @"https://basecamp.com/1931784/api/v1/people.json";
    NSMutableURLRequest *peopleRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:peopleURL]];
    [peopleRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
    NSData *peopleResponse = [NSURLConnection sendSynchronousRequest:peopleRequest returningResponse:nil error:nil];
    NSString *json_people = [[NSString alloc] initWithData:peopleResponse encoding:NSUTF8StringEncoding];
    
       for(int k=0;k<[[json_people JSONValue] count];k++){
            Person* p = [[Person alloc]init];
            p.name = [[[json_people JSONValue] objectAtIndex:k]objectForKey:@"name"];
            p.email = [[[json_people JSONValue] objectAtIndex:k]objectForKey:@"email_address"];
            p.avatar_url = [[[json_people JSONValue] objectAtIndex:k]objectForKey:@"avatar_url"];
            [global.people addObject:p];
        }
   ///*     
    //new request to view user and his assigned todos.
        NSString* meURL = @"https://basecamp.com/1931784/api/v1/people/me.json";
        NSMutableURLRequest *meRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:meURL]];
        [meRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
        NSData *meResponse = [NSURLConnection sendSynchronousRequest:meRequest returningResponse:nil error:nil];
        NSString *json_me = [[NSString alloc] initWithData:meResponse encoding:NSUTF8StringEncoding];
        
        NSString*mytodosURL = [[[json_me JSONValue] objectForKey:@"assigned_todos"]objectForKey:@"url"];
        NSMutableURLRequest *mytodosRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:mytodosURL]];
        [mytodosRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
        NSData *mytodosResponse = [NSURLConnection sendSynchronousRequest:mytodosRequest returningResponse:nil error:nil];
        NSString *json_mytodos = [[NSString alloc] initWithData:mytodosResponse encoding:NSUTF8StringEncoding];
        
        NSLog(@"%@", json_mytodos);
        
        for(int k=0;k<[[json_mytodos JSONValue] count];k++){
            ToDoList * tdl = [[ToDoList alloc]init];
            tdl.todos = [[NSMutableArray alloc]init];
            tdl.name = [[[json_mytodos JSONValue]objectAtIndex:k]objectForKey:@"name"];
            tdl.remaining = [[[[json_mytodos JSONValue]objectAtIndex:k]objectForKey:@"assigned_todos"]count];
            
            
            for(int j=0;j<[[[[json_mytodos JSONValue]objectAtIndex:k] objectForKey:@"assigned_todos"]count];j++){
                
                ToDo * td = [[ToDo alloc]init];
                td.name = [[[[[json_mytodos JSONValue]objectAtIndex:k]objectForKey:@"assigned_todos"]objectAtIndex:j]objectForKey:@"content"];
                td.due_at = [[[[[json_mytodos JSONValue]objectAtIndex:k]objectForKey:@"assigned_todos"]objectAtIndex:j]objectForKey:@"due_at"];
                
                [tdl.todos addObject:td];
                
            }
            
            [global.myTodoLists addObject:tdl];
            
        }
        
      // Get JSON as a NSString from NSData response
        NSString *json_projects = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    
        
        for(int i=0;i<[[json_projects JSONValue] count];i++){
        
            //new request to view details of individual projects.
            NSString* projectURL = [[[json_projects JSONValue] objectAtIndex:i] objectForKey:@"url"];
            NSMutableURLRequest *projectDetailsRequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:projectURL]];
            [projectDetailsRequest setValue:authValue forHTTPHeaderField:@"Authorization"];
            NSData *projectDetailsResponse = [NSURLConnection sendSynchronousRequest:projectDetailsRequest returningResponse:nil error:nil];
            NSString *json_projectDetails = [[NSString alloc] initWithData:projectDetailsResponse encoding:NSUTF8StringEncoding];
        
            //adding the projects
            Project* p = [[Project alloc]init];
            p.discussions = [[NSMutableArray alloc ]init];
            p.todolists = [[NSMutableArray alloc]init];
            p.accesses = [[NSMutableArray alloc]init];
            p.attachments = [[NSMutableArray alloc]init];
            p.documents = [[NSMutableArray alloc]init];
            
            p.name = [[json_projectDetails JSONValue] objectForKey:@"name"];
            p.accesses_url = [[[json_projectDetails JSONValue] objectForKey:@"accesses"]objectForKey:@"url"];
            p.attachments_url = [[[json_projectDetails JSONValue] objectForKey:@"attachments"]objectForKey:@"url"];
            p.documents_url = [[[json_projectDetails JSONValue] objectForKey:@"documents"]objectForKey:@"url"];
            p.topics_url = [[[json_projectDetails JSONValue] objectForKey:@"topics"]objectForKey:@"url"];
            p.todolists_url = [[[json_projectDetails JSONValue] objectForKey:@"todolists"]objectForKey:@"url"];
            
            NSMutableURLRequest *topicsrequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:p.topics_url]];
            [topicsrequest setValue:authValue forHTTPHeaderField:@"Authorization"];
            NSData *topicsresponse = [NSURLConnection sendSynchronousRequest:topicsrequest returningResponse:nil error:nil];
            NSString* json_topics = [[NSString alloc] initWithData:topicsresponse encoding:NSUTF8StringEncoding];  
            
            for(int i=0;i<[[json_topics JSONValue] count];i++){
               
                Discussion* d = [[Discussion alloc]init];
                d.comments = [[NSMutableArray alloc]init];
                d.title = [[[json_topics JSONValue] objectAtIndex:i]objectForKey:@"title"];
                d.excerpt = [[[json_topics JSONValue] objectAtIndex:i]objectForKey:@"excerpt"];
                d.url = [[[[json_topics JSONValue] objectAtIndex:i]objectForKey:@"topicable"]objectForKey:@"url"];
                
                NSMutableURLRequest *commentsrequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:d.url]];
                [commentsrequest setValue:authValue forHTTPHeaderField:@"Authorization"];
                NSData *commentsresponse = [NSURLConnection sendSynchronousRequest:commentsrequest returningResponse:nil error:nil];
                NSString* json_comments = [[NSString alloc] initWithData:commentsresponse encoding:NSUTF8StringEncoding]; 
                
                   for(int i=0;i<[[[json_comments JSONValue]objectForKey:@"comments"] count];i++){
                           Comment *c = [[Comment alloc]init];
                           c.content = [[[[json_comments JSONValue] objectForKey:@"comments"]objectAtIndex:i] objectForKey:@"content"];
                           c.creator_name = [[[[[json_comments JSONValue] objectForKey:@"comments"] objectAtIndex:i] objectForKey:@"creator"] objectForKey:@"name"];
                           c.creator_avatar_url = [[[[[json_comments JSONValue] objectForKey:@"comments"] objectAtIndex:i] objectForKey:@"creator"] objectForKey:@"avatar_url"];
                           c.created_at = [[[[json_comments JSONValue] objectForKey:@"comments"]objectAtIndex:i] objectForKey:@"created_at"];
                           
                           [d.comments addObject:c]; 
                   }
                [p.discussions addObject:d];
            }
            
            
            NSMutableURLRequest *todolistsrequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:p.todolists_url]];
            [todolistsrequest setValue:authValue forHTTPHeaderField:@"Authorization"];
            NSData *todolistsresponse = [NSURLConnection sendSynchronousRequest:todolistsrequest returningResponse:nil error:nil];
            NSString* json_todolists = [[NSString alloc] initWithData:todolistsresponse encoding:NSUTF8StringEncoding];
              
            for(int i=0;i<[[json_todolists JSONValue] count];i++){
                
                ToDoList* t = [[ToDoList alloc]init];
                t.todos = [[NSMutableArray alloc]init];
                t.name = [[[json_todolists JSONValue] objectAtIndex:i]objectForKey:@"name"];
                t.url = [[[json_todolists JSONValue] objectAtIndex:i]objectForKey:@"url"];
                t.remaining = [[[[json_todolists JSONValue] objectAtIndex:i]objectForKey:@"remaining_count"]intValue];
                t.isCompleted = (BOOL)[[[json_todolists JSONValue] objectAtIndex:i]objectForKey:@"completed"];
                
                                
                NSMutableURLRequest *todosrequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:t.url]];
                [todosrequest setValue:authValue forHTTPHeaderField:@"Authorization"];
                NSData *todosresponse = [NSURLConnection sendSynchronousRequest:todosrequest returningResponse:nil error:nil];
                NSString* json_todos = [[NSString alloc] initWithData:todosresponse encoding:NSUTF8StringEncoding]; 
                
                for(int i=0;i<[[[[json_todos JSONValue]objectForKey:@"todos"]objectForKey:@"remaining"] count];i++){
                    ToDo* td = [[ToDo alloc]init];
                    td.isCompleted = NO;
                    td.due_at =  [[[[[json_todos JSONValue] objectForKey:@"todos"]objectForKey:@"remaining"]objectAtIndex:i]objectForKey:@"due_at"];
                    td.name = [[[[[json_todos JSONValue] objectForKey:@"todos"]objectForKey:@"remaining"]objectAtIndex:i]objectForKey:@"content"];
                    [t.todos addObject:td];
                }
                [p.todolists addObject:t];
            }
            
            NSMutableURLRequest *accessesrequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:p.accesses_url]];
            [accessesrequest setValue:authValue forHTTPHeaderField:@"Authorization"];
            NSData *accessesresponse = [NSURLConnection sendSynchronousRequest:accessesrequest returningResponse:nil error:nil];
            NSString* json_accesses = [[NSString alloc] initWithData:accessesresponse encoding:NSUTF8StringEncoding];
            
            for(int i=0;i<[[json_accesses JSONValue] count];i++){
                Person* pp = [[Person alloc]init];
                pp.name = [[[json_accesses JSONValue] objectAtIndex:i]objectForKey:@"name"];
                pp.email = [[[json_accesses JSONValue] objectAtIndex:i]objectForKey:@"email_address"];
                pp.avatar_url = [[[json_accesses JSONValue] objectAtIndex:i]objectForKey:@"avatar_url"];
                [p.accesses addObject:pp];
            }
                
            
            NSMutableURLRequest *attachmentsrequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:p.attachments_url]];
            [attachmentsrequest setValue:authValue forHTTPHeaderField:@"Authorization"];
            NSData *attachmentsresponse = [NSURLConnection sendSynchronousRequest:attachmentsrequest returningResponse:nil error:nil];
            NSString* json_attachments = [[NSString alloc] initWithData:attachmentsresponse encoding:NSUTF8StringEncoding];
            
            for(int i=0;i<[[json_attachments JSONValue] count];i++){
                Attachment* a = [[Attachment alloc]init];
                a.name = [[[json_attachments JSONValue] objectAtIndex:i]objectForKey:@"name"];
                a.url = [[[json_attachments JSONValue] objectAtIndex:i]objectForKey:@"url"];
                [p.attachments addObject:a];
            }
            
            NSMutableURLRequest *documentsrequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:p.documents_url]];
            [documentsrequest setValue:authValue forHTTPHeaderField:@"Authorization"];
            NSData *documentsresponse = [NSURLConnection sendSynchronousRequest:documentsrequest returningResponse:nil error:nil];
            NSString* json_documents = [[NSString alloc] initWithData:documentsresponse encoding:NSUTF8StringEncoding];
            
            for(int i=0;i<[[json_documents JSONValue] count];i++){
                
                Document *d = [[Document alloc]init];
                d.name = [[[json_documents JSONValue] objectAtIndex:i]objectForKey:@"title"];
                d.url = [[[json_documents JSONValue] objectAtIndex:i]objectForKey:@"url"];
                
                NSMutableURLRequest *documentrequest=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:d.url]];
                [documentrequest setValue:authValue forHTTPHeaderField:@"Authorization"];
                NSData *documentresponse = [NSURLConnection sendSynchronousRequest:documentrequest returningResponse:nil error:nil];
                NSString* json_document = [[NSString alloc] initWithData:documentresponse encoding:NSUTF8StringEncoding];
                
                d.content = [[json_document JSONValue]objectForKey:@"content"];
                [p.documents addObject:d];
                    
            }
            
            NSLog(@"%@", json_documents);
        
            [global.projects addObject:p];
        }
            
                       
//        if([global.people count]>0){
//            [[[[[self tabBarController] tabBar] items] 
//              objectAtIndex:2] setBadgeValue:[NSString stringWithFormat: @"%d", [global.people count]]];
//            [[[[[self tabBarController] tabBar] items] 
//              objectAtIndex:1] setBadgeValue:[NSString stringWithFormat: @"%d", [global.projects count]]];
//        }
//        
        int todocount = 0;
        for(int i = 0;i<[global.myTodoLists count];i++){
            todocount = todocount + [[[global.myTodoLists objectAtIndex:i] todos] count];
        }
        
        [[[[[self tabBarController] tabBar] items] 
          objectAtIndex:3] setBadgeValue:[NSString stringWithFormat: @"%d", todocount]];
 //    */   
        
    }
   // NSLog(@"%@",[[global.projects objectAtIndex:1]attachments]);
    
    
    }
   
  -(IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)myTodosButtonPressed:(id)sender {
    
    globals * global = [globals sharedInstance];
    NSLog(@"%@", global.myTodoLists);
    for(int i=0;i<[global.myTodoLists count];i++){
        NSLog(@"%@", [[global.myTodoLists objectAtIndex:i]todos]);

    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setUserField:nil];
    [self setPasswordField:nil];
    //[self setUserSelected:nil];
    
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
