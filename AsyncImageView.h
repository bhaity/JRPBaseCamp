//
//  AsyncImageView.h
//  JRPBaseCamp
//
//  Created by Sikandar Shukla on 8/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AsyncImageView : UIView{
    NSURLConnection* connection;
    NSMutableData* data;
}
- (void)loadImageFromURL:(NSURL*)url;


@end
