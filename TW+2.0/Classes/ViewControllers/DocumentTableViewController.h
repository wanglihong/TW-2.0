//
//  DocumentTableViewController.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-24.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "BaseViewController.h"
#import "Brand.h"
#import "EGORefreshTableHeaderView.h"

@interface DocumentTableViewController : BaseViewController
{
    EGORefreshTableHeaderView *_refreshHeaderView;
    BOOL _reloading;
}

@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) Brand *brand;

- (void)reloadTableViewDataSource;
- (void)doneLoadingTableViewData;

@end
