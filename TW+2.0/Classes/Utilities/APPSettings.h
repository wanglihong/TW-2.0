//
//  APPSettings.h
//  TW+(iPhone)
//
//  Created by Dennis Yang on 13-8-26.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPSettings : NSObject

+ (APPSettings *)instance;

- (void)baseSetting;
- (BOOL)accessValid;

@end
