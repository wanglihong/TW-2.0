//
//  BaseViewController.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-26.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

@synthesize fetchedResultsController = _fetchedResultsController;

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (NSMutableDictionary *)baseParameters
{
    return [NSMutableDictionary dictionaryWithObject:kTWAppID forKey:@"app_id"];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

@end
