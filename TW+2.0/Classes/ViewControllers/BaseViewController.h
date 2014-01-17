//
//  BaseViewController.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-26.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "Constants.h"

@interface BaseViewController : UIViewController <NSFetchedResultsControllerDelegate>
{
    NSFetchedResultsController *_fetchedResultsController;
}

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSMutableDictionary *baseParameters;

@end
