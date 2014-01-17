//
//  Document.h
//  TW+2.0
//
//  Created by Dennis Yang on 14-1-2.
//  Copyright (c) 2014年 Dennis Yang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Brand;

@interface Document : NSManagedObject

@property (nonatomic, retain) NSString * author;
@property (nonatomic, retain) NSNumber * createTime;
@property (nonatomic, retain) NSString * describe;
@property (nonatomic, retain) NSString * dId;
@property (nonatomic, retain) NSString * fileSize;
@property (nonatomic, retain) NSString * fileType;
@property (nonatomic, retain) NSString * fileUrl;
@property (nonatomic, retain) NSString * iconUrl;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * updateTime;
@property (nonatomic, retain) NSString * website;
@property (nonatomic, retain) NSString * updateDate;
@property (nonatomic, retain) Brand *brand;

- (BOOL)exist;

@end
