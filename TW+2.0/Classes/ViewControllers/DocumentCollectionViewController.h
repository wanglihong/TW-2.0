//
//  DocumentCollectionViewController.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-27.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "BaseMenuViewController.h"
#import "EGORefreshTableHeaderView.h"

typedef enum {
    ResultTypeDefault = 0,
    ResultTypeFavorite,
    ResultTypeWebAPP,
    ResultTypeAPP,
    ResultTypePDF,
    ResultTypeWebSite,
    ResultTypeMiniSite,
    ResultTypeVideo
} ResultType;

@interface DocumentCollectionViewController : BaseMenuViewController
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
    BOOL _repagging;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) IBOutlet UIView *tableFooterView;
@property (nonatomic, weak) IBOutlet UILabel *NoResultsLabel;
@property (nonatomic) ResultType resultType;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;
- (void)downloadTableViewNextPageDataSource;

@end
