//
//  DocumentTableViewController.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-24.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "DocumentTableViewController.h"
#import "DocumentTableViewCell.h"
#import "UIViewController+Loaders.h"
#import "UIViewController+Refreshers.h"
#import "UIViewController+Helpers.h"
#import "NSObject+Helpers.h"

@interface DocumentTableViewController ()
{
    IBOutlet UILabel *_NoResultsLabel;
}
@end

@implementation DocumentTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (OSVersion() < 7) {
        [self styleNavigationBarWithFontName:@"Avenir-Black"];
        [self styleNavigationBarButtonItemWithImage:@"back.png" action:@selector(back:) isLeft:YES];
    }
//    [self addRefreshHeaderView];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if ([[_fetchedResultsController fetchedObjects] count] == 0) {
        [UIView animateWithDuration:0.25 animations:^{
            [_NoResultsLabel setAlpha:1.0];
        }];
    }
}

- (void)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
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


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DocumentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    [cell setDocument:[self.fetchedResultsController objectAtIndexPath:indexPath]];
    
    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:cell.bounds];
    selectedBackgroundView.backgroundColor = THEME_COLOR_FULL;
    cell.selectedBackgroundView = selectedBackgroundView;
    
    return cell;
}


#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end
