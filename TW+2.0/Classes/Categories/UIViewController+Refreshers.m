//
//  UIViewController+Refreshers.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-27.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "UIViewController+Refreshers.h"

@implementation UIViewController (Refreshers)

@end


@implementation BrandCollectionViewController (Refreshers)

- (void)addRefreshHeaderView
{
    if (_refreshHeaderView == nil) {
        
        CGFloat y = - self.view.bounds.size.height;
        CGRect frame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height);
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:frame];
        view.delegate = self;
		[self.collectionView addSubview:view];
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[_fetchedResultsController fetchedObjects] count] == 0) {
        [UIView animateWithDuration:0.25 animations:^{[self.NoResultsLabel setAlpha:1.0];}];
    }
    
//    NSDate *lastUpdatedDate = [[NSUserDefaults standardUserDefaults] valueForKey:@"BrandListLastUpdatedDate"];
//    NSTimeInterval pastTime = fabs([lastUpdatedDate timeIntervalSinceNow]);
//    
//    if (pastTime > 3600) {  // 3600: An hour
//        
//        [self.collectionView setContentOffset:CGPointMake(0, -75.0) animated:YES];
//        
//        [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDidScroll:)
//                                 withObject:self.collectionView afterDelay:0.4];
//        [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDidEndDragging:)
//                                 withObject:self.collectionView afterDelay:0.4];
//        
//        [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:@"BrandListLastUpdatedDate"];
//        [[NSUserDefaults standardUserDefaults] synchronize];
//    }
}


#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

@end


@implementation DocumentCollectionViewController (Refreshers)

- (void)addRefreshHeaderView
{
    if (_refreshHeaderView == nil) {
        
        CGFloat y = - self.view.bounds.size.height;
        CGRect frame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height);
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:frame];
        view.delegate = self;
		[self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[_fetchedResultsController fetchedObjects] count] == 0) {
        [UIView animateWithDuration:0.25 animations:^{[self.NoResultsLabel setAlpha:1.0];}];
    }
    
    if (self.resultType != ResultTypeDefault) {
        return;
    }
    
    NSDate *lastUpdatedDate = [[NSUserDefaults standardUserDefaults] valueForKey:@"DocumentListLastUpdatedDate"];
    NSTimeInterval pastTime = fabs([lastUpdatedDate timeIntervalSinceNow]);
    
    NSString *justFinishedLogin = [[NSUserDefaults standardUserDefaults] valueForKey:@"justFinishedLogin"];
    
    if (pastTime >= 3600 || justFinishedLogin) {  // 3600: An hour
        
        [self.tableView setContentOffset:CGPointMake(0, -75.0) animated:YES];
        
        [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDidScroll:) withObject:self.tableView afterDelay:0.4];
        [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDidEndDragging:) withObject:self.tableView afterDelay:0.4];
        
        [[NSUserDefaults standardUserDefaults] setValue:[NSDate date] forKey:@"DocumentListLastUpdatedDate"];
        [[NSUserDefaults standardUserDefaults] setValue:nil forKey:@"justFinishedLogin"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}


#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
    
    if (scrollView.contentOffset.y == scrollView.contentSize.height - scrollView.bounds.size.height) {
        [self downloadTableViewNextPageDataSource];
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

@end


@implementation DocumentTableViewController (Refreshers)

- (void)addRefreshHeaderView
{
    if (_refreshHeaderView == nil) {
        
        CGFloat y = - self.view.bounds.size.height;
        CGRect frame = CGRectMake(0, y, self.view.frame.size.width, self.view.frame.size.height);
        
        EGORefreshTableHeaderView *view = [[EGORefreshTableHeaderView alloc] initWithFrame:frame];
        view.delegate = self;
		[self.tableView addSubview:view];
        _refreshHeaderView = view;
    }
    [_refreshHeaderView refreshLastUpdatedDate];
}

//- (void)viewDidAppear:(BOOL)animated
//{
//    [super viewDidAppear:animated];
//    
//    if ([[_fetchedResultsController fetchedObjects] count] == 0) {
//        
//        [self.tableView setContentOffset:CGPointMake(0, -75.0) animated:YES];
//        
//        [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDidScroll:) withObject:self.tableView afterDelay:0.4];
//        [_refreshHeaderView performSelector:@selector(egoRefreshScrollViewDidEndDragging:) withObject:self.tableView afterDelay:0.4];
//    }
//}


#pragma mark - EGORefreshTableHeaderDelegate

- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view
{
	[self reloadTableViewDataSource];
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view
{
	return _reloading; // should return if data source model is reloading
}

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view
{
	return [NSDate date]; // should return date data source was last changed
}


#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
	[_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	[_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView];
}

@end
