//
//  DocumentDisplayViewController.h
//  TW+2.0
//
//  Created by Dennis Yang on 14-1-7.
//  Copyright (c) 2014年 Dennis Yang. All rights reserved.
//

#import "BaseViewController.h"
#import "Document.h"

@interface DocumentDisplayViewController : BaseViewController <UIWebViewDelegate>

@property (nonatomic, weak) IBOutlet UIWebView *contentView;
@property (nonatomic, weak) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (nonatomic, strong) Document *document;

@end
