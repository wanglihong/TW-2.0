//
//  BrandCollectionViewController.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-24.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "BaseMenuViewController.h"
#import "EGORefreshTableHeaderView.h"

@interface BrandCollectionViewController : BaseMenuViewController
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, weak) IBOutlet UILabel *NoResultsLabel;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
