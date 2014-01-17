//
//  UIViewController+Refreshers.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-27.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//



@interface UIViewController (Refreshers)

@end


#import "BrandCollectionViewController.h"

@interface BrandCollectionViewController (Refreshers) <EGORefreshTableHeaderDelegate, UIScrollViewDelegate>

- (void)addRefreshHeaderView;

@end


#import "DocumentCollectionViewController.h"

@interface DocumentCollectionViewController (Refreshers) <EGORefreshTableHeaderDelegate, UIScrollViewDelegate>

- (void)addRefreshHeaderView;

@end


#import "DocumentTableViewController.h"

@interface DocumentTableViewController (Refreshers) <EGORefreshTableHeaderDelegate, UIScrollViewDelegate>

- (void)addRefreshHeaderView;

@end