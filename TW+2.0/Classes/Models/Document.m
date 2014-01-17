//
//  Document.m
//  TW+2.0
//
//  Created by Dennis Yang on 14-1-2.
//  Copyright (c) 2014年 Dennis Yang. All rights reserved.
//

#import "Document.h"
#import "Brand.h"
#import "NSObject+Helpers.h"


@implementation Document

@dynamic author;
@dynamic createTime;
@dynamic describe;
@dynamic dId;
@dynamic fileSize;
@dynamic fileType;
@dynamic fileUrl;
@dynamic iconUrl;
@dynamic name;
@dynamic updateTime;
@dynamic website;
@dynamic updateDate;
@dynamic brand;

- (BOOL)exist {
    
    NSString *filePath = [NSString stringWithFormat:@"%@/%@.%@", attachmentPath(), self.dId, self.fileType];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) // 附近在本地存在
        return YES;
    
    else if (self.fileUrl.length == 0) // 没有附件地址（附件为超链接）
        return YES;
    
    else
        return NO;
    
}

@end
