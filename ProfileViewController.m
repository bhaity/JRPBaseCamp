//
//  ProfileViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ProfileViewController.h"
#import "Person.h"
#import "globals.h"
#import <AddressBook/AddressBook.h>

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize textButton;
@synthesize callButton;
@synthesize emailButton;

@synthesize imgView;

NSString* personPhoneNumber;



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
    //UIImageView * imgView = [[UIImageView alloc]init ];
    globals *global = [globals sharedInstance];
    
    Person * p = global.selectedPerson;
    
    self.navigationItem.title = [p name];
    
    NSURL *url = [NSURL URLWithString:[p avatar_url]];
    NSData *data = [[NSData alloc] initWithContentsOfURL:url];
    UIImage *tmpImage = [[UIImage alloc] initWithData:data];
    
    imgView.image = tmpImage;
       
    [emailButton setTitle:[NSString stringWithFormat:@"Email %@", p.name] forState:UIControlStateNormal];
    [callButton setTitle:[NSString stringWithFormat:@"Call %@", p.name] forState:UIControlStateNormal];
    [textButton setTitle:[NSString stringWithFormat:@"Text %@", p.name] forState:UIControlStateNormal];
    
    
    

    // Do any additional setup after loading the view from its nib.
    
}
-(void) viewWillDisappear:(BOOL)animated {
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound) {
        [UIView beginAnimations:@"animation2" context:nil];
        [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
        [UIView setAnimationDuration: 0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.navigationController.view cache:NO]; 
        [UIView commitAnimations];
    }
    [super viewWillDisappear:animated];
}
- (void)viewDidUnload
{
    [self setImgView:nil];

    [self setEmailButton:nil];
    [self setCallButton:nil];
    [self setTextButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)emailButtonPressed:(id)sender {
    globals *global = [globals sharedInstance];
    Person * p = global.selectedPerson;
    
    UIAlertView *emailAlert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Emailing %@",p.name] 
                                                         message:[NSString stringWithFormat:@"%@",p.email]
                                                        delegate:self 
                                               cancelButtonTitle:@"OK" 
                                               otherButtonTitles:nil, nil];
    [emailAlert show];

    
    
    
}

-(void)getPhoneNumber{
    globals *global = [globals sharedInstance];
    Person * p = global.selectedPerson;

    ABAddressBookRef addressBook = ABAddressBookCreate();
    NSArray *people = (__bridge_transfer NSArray*)ABAddressBookCopyPeopleWithName(addressBook,(__bridge CFStringRef) p.name);
    
    if ((people != nil) && [people count])
	{
		ABRecordRef person = (__bridge ABRecordRef)[people objectAtIndex:0];
        NSMutableArray *phoneNumbers = [[NSMutableArray alloc] init];
        ABMultiValueRef multiPhones = ABRecordCopyValue(person,kABPersonPhoneProperty);
        for(CFIndex i=0;i<ABMultiValueGetCount(multiPhones);++i) {
            CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(multiPhones, i);
            NSString *phoneNumber = (__bridge NSString *) phoneNumberRef;
            [phoneNumbers addObject:phoneNumber];
        }
        
        personPhoneNumber = [phoneNumbers objectAtIndex:0];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" 
														message:[NSString stringWithFormat:@"Contacting %@ at %@",p.name,personPhoneNumber ] 
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
        [alert show];
        
	}
	else 
	{
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Whoops!" 
														message:[NSString stringWithFormat:@"%@ was not found in your contacts.",p.name] 
													   delegate:nil 
											  cancelButtonTitle:@"OK" 
											  otherButtonTitles:nil];
		[alert show];
        
	}
    
    
}

- (IBAction)textButtonPressed:(id)sender {
    [self getPhoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel:%@", personPhoneNumber]]];
}

- (IBAction)callButtonPressed:(id)sender {
    [self getPhoneNumber];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@", personPhoneNumber]]];
}
@end
