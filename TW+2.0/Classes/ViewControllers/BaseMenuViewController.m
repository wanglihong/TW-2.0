//
//  BaseMenuViewController.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-24.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "BaseMenuViewController.h"
#import "NSObject+Helpers.h"

@interface BaseMenuViewController ()

@end

@implementation BaseMenuViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (OSVersion() < 7) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 4, 52, 36)];
        [button addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"menu.png"] forState:UIControlStateNormal];
        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
        self.navigationItem.leftBarButtonItem = item;
    } else {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Menu" style:UIBarButtonItemStyleBordered target:self action:@selector(showMenu)];
    }
    
    UIPanGestureRecognizer *gestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(swipeHandler:)];
    [self.view addGestureRecognizer:gestureRecognizer];
}

- (void)swipeHandler:(UIPanGestureRecognizer *)sender
{
    [[self sideMenu] showFromPanGesture:sender];
}

- (void)showMenu
{
    [[self sideMenu] show];
}

@end
