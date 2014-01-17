//
//  AppDelegate.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-20.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate> {
    NSMutableArray *_addedItems;
    NSMutableArray *_menuItems;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, readonly, nonatomic) RESideMenu *sideMenu;

- (void)showHome;

@end
