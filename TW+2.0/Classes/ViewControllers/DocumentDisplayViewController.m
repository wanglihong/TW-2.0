//
//  DocumentDisplayViewController.m
//  TW+2.0
//
//  Created by Dennis Yang on 14-1-7.
//  Copyright (c) 2014年 Dennis Yang. All rights reserved.
//

#import "DocumentDisplayViewController.h"
#import "NSObject+Helpers.h"
#import "UIViewController+Helpers.h"

@interface DocumentDisplayViewController ()

@end

@implementation DocumentDisplayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (OSVersion() < 7) {
        [self styleNavigationBarWithFontName:@"Avenir-Black"];
        [self styleNavigationBarButtonItemWithImage:@"back.png" action:@selector(back:) isLeft:YES];
    }
    
    NSString *urlString = nil;
    NSURLRequest *request = nil;

    // 附件为超链接
    if (self.document.fileUrl.length == 0 && self.document.website.length > 0 ) {
        urlString = self.document.website;
        request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    }
    
    // 附件为本地文件
    else {
        urlString = [NSString stringWithFormat:@"%@/%@.%@", attachmentPath(), self.document.dId, self.document.fileType];
        request = [NSURLRequest requestWithURL:[NSURL fileURLWithPath:urlString]];
    }
    
    [self.contentView setScalesPageToFit:YES];
    [self.contentView loadRequest:request];
    [self.contentView setDelegate:self];
}

- (IBAction)back:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UIWebViewDelegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self.activityIndicator startAnimating];
    [self performSelector:@selector(timeout) withObject:nil afterDelay:30];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self.activityIndicator stopAnimating];
}

- (void)timeout
{
    if ([self.activityIndicator isAnimating]) {
        [self.activityIndicator stopAnimating];
    }
}

@end
