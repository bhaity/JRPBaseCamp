//
//  DocumentWebViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DocumentWebViewController.h"
#import "globals.h"
#import "Project.h"
#import "Document.h"

@interface DocumentWebViewController ()

@end

@implementation DocumentWebViewController
@synthesize webView;

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
    globals *global = [globals sharedInstance];
    Document *d = global.selectedDocument;
     self.navigationItem.title = [NSString stringWithFormat:@"%@", d.name];
    
    // Do any additional setup after loading the view from its nib
    
    [webView loadHTMLString:d.content baseURL:nil];
    [self.view addSubview:webView];
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
