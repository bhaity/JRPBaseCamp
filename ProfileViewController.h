//
//  ProfileViewController.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *textButton;
@property (strong, nonatomic) IBOutlet UIButton *callButton;
@property (strong, nonatomic) IBOutlet UIButton *emailButton;

- (IBAction)textButtonPressed:(id)sender;
- (IBAction)callButtonPressed:(id)sender;

@property (strong, nonatomic) IBOutlet UIImageView *imgView;

- (IBAction)emailButtonPressed:(id)sender;
@end

