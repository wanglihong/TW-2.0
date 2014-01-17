//
//  UIViewController+Helpers.h
//  TW+2.0
//
//  Created by Dennis Yang on 14-1-6.
//  Copyright (c) 2014年 Dennis Yang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (Helpers)

- (void)styleNavigationBarWithFontName:(NSString*)fontName;
- (void)styleNavigationBarButtonItemWithImage:(NSString *)imgName action:(SEL)action isLeft:(BOOL)left;
- (UIViewController *)applicationRootViewController;

@end
