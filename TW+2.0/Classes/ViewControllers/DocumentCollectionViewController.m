//
//  DocumentCollectionViewController.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-27.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "DocumentCollectionViewController.h"
#import "DocumentTableViewCell.h"
#import "UIViewController+Loaders.h"
#import "UIViewController+Refreshers.h"
#import "UIViewController+Helpers.h"
#import "NSObject+Helpers.h"

@interface DocumentCollectionViewController ()

@end

@implementation DocumentCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (OSVersion() < 7) {
        [self styleNavigationBarWithFontName:@"Avenir-Black"];
    }
    
    if (self.resultType == ResultTypeDefault) {
        [self addRefreshHeaderView];
    }
    
    [self.tableFooterView removeFromSuperview];
}

- (void)reloadTableViewDataSource
{
    _reloading = YES;
    [self requestGetDocumentList];
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.tableView];
}

- (void)downloadTableViewNextPageDataSource
{
    [self requestGetNextPageDocuments];
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [(DocumentTableViewCell *)cell setDocument:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBackgroundView.backgroundColor = THEME_COLOR_FULL;
    cell.selectedBackgroundView = selectedBackgroundView;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [[[self.fetchedResultsController sections] objectAtIndex:section] name];
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UILabel *label = [[UILabel alloc] init];
    label.text = [NSString stringWithFormat:@"    %@", [self tableView:tableView titleForHeaderInSection:section]];
    label.font = [UIFont fontWithName:@"Helvetica" size:14.0];
    label.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.1];
    
    return OSVersion() >= 7 ? nil : label;
}

@end
