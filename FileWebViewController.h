//
//  FileWebViewController.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FileWebViewController : UIViewController<UIWebViewDelegate> {
    IBOutlet UIWebView *webView;
}

@property (strong, nonatomic) IBOutlet UIWebView *webView;
@end
