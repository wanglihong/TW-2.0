//
//  UIViewController+Actions.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-31.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "UIViewController+Actions.h"

@implementation UIViewController (Actions)

@end


@implementation BrandCollectionViewController (Actions)

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"showDocumentTable"])
    {
        DocumentTableViewController *viewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.collectionView indexPathForCell:sender];
        Brand *brand = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        viewController.brand = brand;
        viewController.title = brand.name;
    }
}

@end


#import "DocumentDescriptionViewController.h"

@implementation DocumentCollectionViewController (Actions)

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"ShowDescription2"])
    {
        DocumentDescriptionViewController *viewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Document *doc = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        viewController.document = doc;
        viewController.title = doc.name;
    }
}

@end


@implementation DocumentTableViewController (Actions)

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"ShowDescription1"])
    {
        DocumentDescriptionViewController *viewController = [segue destinationViewController];
        
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        Document *doc = [self.fetchedResultsController objectAtIndexPath:indexPath];
        
        viewController.document = doc;
        viewController.title = doc.name;
    }
}

@end


#import "DocumentDisplayViewController.h"

@implementation DocumentDescriptionViewController (Actions)

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqual: @"DisplayDocument"])
    {
        DocumentDisplayViewController *viewController = (DocumentDisplayViewController *)[[segue destinationViewController] topViewController];
        viewController.document = self.document;
        viewController.title = self.document.name;
    }
}

@end
