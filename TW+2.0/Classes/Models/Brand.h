//
//  Brand.h
//  TW+2.0
//
//  Created by Dennis Yang on 14-1-3.
//  Copyright (c) 2014年 Dennis Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Brand : NSManagedObject

@property (nonatomic, retain) NSString * cId;
@property (nonatomic, retain) NSNumber * hasUpdate;
@property (nonatomic, retain) NSString * iconUrl;
@property (nonatomic, retain) NSNumber * lastUpdate;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * numsUpdate;
@property (nonatomic, retain) NSString * team;

@end
