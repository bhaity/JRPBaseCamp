//
//  FileWebViewController.m
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FileWebViewController.h"
#import "globals.h"
#import "Project.h"
#import "Attachment.h"

@interface FileWebViewController ()

@end

@implementation FileWebViewController
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
    [webView setDelegate:self];
    
    globals *global = [globals sharedInstance];
    Attachment * a = global.selectedAttachment;
    
    NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:a.url]];
    [request setValue:global.authValue forHTTPHeaderField:@"Authorization"];
    
    self.navigationItem.title = [NSString stringWithFormat:@"%@", a.name];

   // NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    
    
   // NSURL *targetURL = [NSURL URLWithString:a.url];
   // NSURLRequest *request = [NSURLRequest requestWithURL:targetURL];
    
    [webView loadRequest:request];
    webView.multipleTouchEnabled = YES;
    webView.scalesPageToFit = YES;
    [self.view addSubview:webView];
    
    // Do any additional setup after loading the view from its nib.
}

//- (void)webViewDidStartLoad:(UIWebView *)webView {
//    [[UIApplication sharedApplication]
//     setNetworkActivityIndicatorVisible:YES];
//}
//
//- (void)webViewDidFinishLoad:(UIWebView *)webView {
//    [[UIApplication sharedApplication]
//     setNetworkActivityIndicatorVisible:NO];
//}
//
//- (void)webView:(UIWebView *)webView didFailLoadWithError:
//(NSError *)error {
//    [[UIApplication sharedApplication]
//     setNetworkActivityIndicatorVisible:NO];
//}

-(void)webViewDidStartLoad:(UIWebView *) webView {
    UIActivityIndicatorView *actInd = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    UIBarButtonItem *actItem = [[UIBarButtonItem alloc] initWithCustomView:actInd];
    
    self.navigationItem.rightBarButtonItem = actItem;
    
    [actInd startAnimating];

}
-(void)webViewDidFinishLoad:(UIWebView *) webView{
    self.navigationItem.rightBarButtonItem = nil;
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
