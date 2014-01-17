//
//  BrandCollectionViewController.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-24.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "BrandCollectionViewController.h"
#import "BrandCollectionViewCell.h"
#import "Brand.h"
#import "UIViewController+Helpers.h"
#import "UIViewController+Loaders.h"
#import "UIViewController+Fetchers.h"
#import "UIViewController+Refreshers.h"
#import "DocumentTableViewController.h"
#import "NSObject+Helpers.h"

@interface BrandCollectionViewController ()

@end

@implementation BrandCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (OSVersion() < 7) {
        [self styleNavigationBarWithFontName:@"Avenir-Black"];
    }
//    [self addRefreshHeaderView];
}

- (void)reloadTableViewDataSource
{
    _reloading = YES;
    [self requestGetBrandList];
}

- (void)doneLoadingTableViewData
{
    _reloading = NO;
	[_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.collectionView];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    BrandCollectionViewCell *cell = (BrandCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    cell.brand = [self.fetchedResultsController objectAtIndexPath:indexPath];
    return cell;
}

@end
