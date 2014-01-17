//
//  AppDelegate.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-20.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "AppDelegate.h"
#import "BrandCollectionViewController.h"
#import "DocumentCollectionViewController.h"
#import "LoginViewController.h"
#import "LoadViewController.h"
#import "NSObject+Helpers.h"
#import "StoreManager.h"
#import "APPSettings.h"
#import "Constants.h"
#import "SIAlertView.h"
#import "MobClick.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[APPSettings instance] baseSetting];
    [MobClick startWithAppkey:UMENG_APPKEY reportPolicy:REALTIME channelId:@"iCatholic"];
    [MobClick checkUpdate:@"新版本 " cancelButtonTitle:@"忽略" otherButtonTitles:@"更新"];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    if (OSVersion() < 7) {
        [application setStatusBarStyle:UIStatusBarStyleBlackOpaque];
    }
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    RESideMenuItem *home = [[RESideMenuItem alloc] initWithTitle:@"Home" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"DocumentCollectionNavigationController"];
        DocumentCollectionViewController *viewController = (DocumentCollectionViewController *)navController.topViewController;
        viewController.resultType = ResultTypeDefault;
        viewController.title = @"ALL";
        [menu displayContentController:navController];
    }];
    
    RESideMenuItem *brand = [[RESideMenuItem alloc] initWithTitle:@"Brand" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"BrandCollectionNavigationController"];
        BrandCollectionViewController *viewController = (BrandCollectionViewController *)navController.topViewController;
        viewController.title = @"Brand";
        [menu displayContentController:navController];
    }];
    
    RESideMenuItem *item2 = [[RESideMenuItem alloc] initWithTitle:@"WebApp" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"DocumentCollectionNavigationController"];
        DocumentCollectionViewController *viewController = (DocumentCollectionViewController *)navController.topViewController;
        viewController.resultType = ResultTypeWebAPP;
        viewController.title = @"WebApp";
        [menu displayContentController:navController];
    }];
    
    RESideMenuItem *item3 = [[RESideMenuItem alloc] initWithTitle:@"APP" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"DocumentCollectionNavigationController"];
        DocumentCollectionViewController *viewController = (DocumentCollectionViewController *)navController.topViewController;
        viewController.resultType = ResultTypeAPP;
        viewController.title = @"APP";
        [menu displayContentController:navController];
    }];
    
    RESideMenuItem *item4 = [[RESideMenuItem alloc] initWithTitle:@"PDF" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"DocumentCollectionNavigationController"];
        DocumentCollectionViewController *viewController = (DocumentCollectionViewController *)navController.topViewController;
        viewController.resultType = ResultTypePDF;
        viewController.title = @"PDF";
        [menu displayContentController:navController];
    }];
    
    RESideMenuItem *item5 = [[RESideMenuItem alloc] initWithTitle:@"WebSite" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"DocumentCollectionNavigationController"];
        DocumentCollectionViewController *viewController = (DocumentCollectionViewController *)navController.topViewController;
        viewController.resultType = ResultTypeWebSite;
        viewController.title = @"WebSite";
        [menu displayContentController:navController];
    }];
    
    RESideMenuItem *item6 = [[RESideMenuItem alloc] initWithTitle:@"MiniSite" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"DocumentCollectionNavigationController"];
        DocumentCollectionViewController *viewController = (DocumentCollectionViewController *)navController.topViewController;
        viewController.resultType = ResultTypeMiniSite;
        viewController.title = @"MiniSite";
        [menu displayContentController:navController];
    }];
    
    RESideMenuItem *item7 = [[RESideMenuItem alloc] initWithTitle:@"Video" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"DocumentCollectionNavigationController"];
        DocumentCollectionViewController *viewController = (DocumentCollectionViewController *)navController.topViewController;
        viewController.resultType = ResultTypeVideo;
        viewController.title = @"Video";
        [menu displayContentController:navController];
    }];
    
    RESideMenuItem *favorite = [[RESideMenuItem alloc] initWithTitle:@"Favorite" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"DocumentCollectionNavigationController"];
        DocumentCollectionViewController *viewController = (DocumentCollectionViewController *)navController.topViewController;
        viewController.resultType = ResultTypeFavorite;
        viewController.title = @"Favorite";
        [menu displayContentController:navController];
    }];
    
    RESideMenuItem *category = [[RESideMenuItem alloc] initWithTitle:@"Category +" action:^(RESideMenu *menu, RESideMenuItem *item) {
    
    }];
    category.subItems = @[item2, item3, item4, item5, item6, item7];
    
    RESideMenuItem *login = [[RESideMenuItem alloc] initWithTitle:@"Login" action:^(RESideMenu *menu, RESideMenuItem *item) {
        UINavigationController *navController = [storyboard instantiateViewControllerWithIdentifier:@"LoginNavigationController"];
        [menu displayContentController:navController];
    }];
    
    RESideMenuItem *clear = [[RESideMenuItem alloc] initWithTitle:@"Clear cache" action:^(RESideMenu *menu, RESideMenuItem *item) {
        if (OSVersion() >= 7) {
            [[[UIAlertView alloc] initWithTitle:nil message:@"Are sure to clear cached files ?" delegate:self cancelButtonTitle:@"YES" otherButtonTitles:@"NO", nil] show];
        } else {
            SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:@"Are sure to clear cached files ?"];
            SIAlertViewHandler handler = ^(SIAlertView *alertView){
                NSError *error;
                [[NSFileManager defaultManager] removeItemAtPath:attachmentPath() error:&error];
                if (error) {
                    NSLog(@"Failed to clear cache !");
                }
            };
            [alertView addButtonWithTitle:@"YES" type:SIAlertViewButtonTypeDefault handler:handler];
            [alertView addButtonWithTitle:@"NO" type:SIAlertViewButtonTypeDefault handler:nil];
            [alertView show];
        }
    }];
    
    _sideMenu = [[RESideMenu alloc] initWithItems:@[home, brand, category, favorite, login, clear]];
    _sideMenu.verticalPortraitOffset = 76;
    _sideMenu.verticalLandscapeOffset = 16;
    _sideMenu.hideStatusBarArea = OSVersion() < 7;
    _sideMenu.openStatusBarStyle = UIStatusBarStyleDefault;
    _sideMenu.textColor = [UIColor whiteColor];
    
    // Call the home action rather than duplicating the initialisation
    if ([[APPSettings instance] accessValid])
    {
        home.action(_sideMenu, home);
    }
    else
    {
        login.action(_sideMenu, login);
    }
    
    self.window.rootViewController = _sideMenu;
    self.window.backgroundColor = [UIColor whiteColor];
    
    LoadViewController *loadViewController = [[LoadViewController alloc] init];
    [self.window.rootViewController.view addSubview:loadViewController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)showHome
{
    RESideMenuItem *item = [[_sideMenu items] firstObject];
    item.action(_sideMenu, item);
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    [[StoreManager instance] saveContext];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    [[StoreManager instance] saveContext];
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    [[StoreManager instance] saveContext];
}


#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath:attachmentPath() error:&error];
        if (error) {
            NSLog(@"Failed to clear cache !");
        }
    }
}

@end
