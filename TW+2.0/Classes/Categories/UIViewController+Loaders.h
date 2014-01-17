//
//  UIViewController+Loaders.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-27.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//



@interface UIViewController (Loaders)

- (void)handleError:(NSError *)error;

@end


#import "LoginViewController.h"

@interface LoginViewController (Loaders)

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password;

@end


#import "BrandCollectionViewController.h"

@interface BrandCollectionViewController (Loaders)

- (void)requestGetBrandList;

@end


#import "DocumentCollectionViewController.h"

@interface DocumentCollectionViewController (Loaders)

- (void)requestGetDocumentList;
- (void)requestGetNextPageDocuments;

@end


#import "DocumentTableViewController.h"

@interface DocumentTableViewController (Loaders)

- (void)requestGetDocumentList;

@end