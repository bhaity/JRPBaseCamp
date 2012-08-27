//
//  HomeViewController.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"

@class MBProgressHUD;

@interface HomeViewController : UIViewController{
    
}

@property (strong, nonatomic) IBOutlet UITextField *UserField;
@property (strong, nonatomic) IBOutlet UITextField *PasswordField;

- (IBAction)loginButtonPressed:(id)sender;
-(IBAction)backgroundTap:(id)sender;
- (IBAction)showWithLabel:(id)sender;
- (void)hudWasHidden;
-(IBAction)textFieldDoneEditing:(id)sender;






@end
