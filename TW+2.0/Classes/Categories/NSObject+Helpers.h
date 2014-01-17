//
//  NSObject+Helpers.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-23.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Helpers)

extern NSInteger OSVersion();
extern NSString *documentPath();
extern NSString *attachmentPath();
extern void alert(NSString *text, NSString *buttonTitle);

@end


@interface NSNumber (Helpers)

extern NSString *updatedDate(NSNumber *num);

@end


@interface NSString (Helpers)

extern NSString *standardFileSize(NSString *fileSize);

@end


@interface UILabel (Helpers)

- (void)setDynamicFrame;

@end