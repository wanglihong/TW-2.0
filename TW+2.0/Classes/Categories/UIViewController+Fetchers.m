//
//  UIViewController+Fetchers.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-27.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "UIViewController+Fetchers.h"
#import "StoreManager.h"

@implementation UIViewController (Fetchers)

@end


@implementation BrandCollectionViewController (Fetches)

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *context = [StoreManager instance].managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Brand" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"lastUpdate" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:nameDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    NSError *error;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.collectionView reloadSections:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, self.collectionView.numberOfSections)]];
}

@end


#import "DocumentTableViewCell.h"

@implementation DocumentCollectionViewController (Fetchers)

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *context = [StoreManager instance].managedObjectContext;
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Document" inManagedObjectContext:context];
    NSSortDescriptor *dateDescriptor = [[NSSortDescriptor alloc] initWithKey:@"updateTime" ascending:NO];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:dateDescriptor, nil];
    NSPredicate *predicate = nil;
    
    switch (self.resultType) {
        case ResultTypeFavorite:
        {
            NSMutableArray *favorites = [[NSUserDefaults standardUserDefaults] objectForKey:@"favorite"];
            predicate = [NSPredicate predicateWithFormat:@"dId in %@", favorites];
        }
            break;
            
        case ResultTypeWebAPP:
            predicate = [NSPredicate predicateWithFormat:@"fileType like[cd] %@", @"WebAPP"];
            break;
            
        case ResultTypeAPP:
            predicate = [NSPredicate predicateWithFormat:@"fileType like[cd] %@", @"APP"];
            break;
            
        case ResultTypePDF:
            predicate = [NSPredicate predicateWithFormat:@"fileType like[cd] %@", @"PDF"];
            break;
            
        case ResultTypeWebSite:
            predicate = [NSPredicate predicateWithFormat:@"fileType like[cd] %@", @"WebSite"];
            break;
            
        case ResultTypeMiniSite:
            predicate = [NSPredicate predicateWithFormat:@"fileType like[cd] %@", @"MiniSite"];
            break;
            
        case ResultTypeVideo:
            predicate = [NSPredicate predicateWithFormat:@"fileType like[cd] %@", @"Video"];
            break;
            
        default:
            predicate = nil;
            break;
    }
    
    [request setEntity:entity];
    [request setSortDescriptors:sortDescriptors];
    [request setPredicate:predicate];
//    [request setFetchLimit:_fetchLimit];
//    [request setFetchOffset:_fetchLimit * _fetchPage];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:context sectionNameKeyPath:@"updateDate" cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    NSError *error;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
            
        case NSFetchedResultsChangeUpdate:
//            [(DocumentTableViewCell *)[tableView cellForRowAtIndexPath:indexPath] setDocument:[self.fetchedResultsController objectAtIndexPath:indexPath]];
            [self.tableView moveRowAtIndexPath:indexPath toIndexPath:newIndexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationTop];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationBottom];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
    
    if ([[controller fetchedObjects] count]) {
        [UIView animateWithDuration:0.25 animations:^{[self.NoResultsLabel setAlpha:0];}];
    } else {
        [UIView animateWithDuration:0.25 animations:^{[self.NoResultsLabel setAlpha:1];}];
    }
}

@end


@implementation DocumentTableViewController (Fetchers)

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSManagedObjectContext *context = [StoreManager instance].managedObjectContext;
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Document" inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    
    NSSortDescriptor *nameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:nameDescriptor, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"brand.cId like[cd] %@", self.brand.cId];
    [fetchRequest setPredicate:predicate];
    
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];
    _fetchedResultsController.delegate = self;
    
    NSError *error;
    if (![_fetchedResultsController performFetch:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}


#pragma mark - NSFetchedResultsControllerDelegate

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView reloadData];
}

@end
