//
//  NSObject+Helpers.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-23.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "NSObject+Helpers.h"
#import "SIAlertView.h"

@implementation NSObject (Helpers)

NSInteger OSVersion() {
    static NSUInteger _deviceSystemMajorVersion = -1;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _deviceSystemMajorVersion = [[[[[UIDevice currentDevice] systemVersion] componentsSeparatedByString:@"."] objectAtIndex:0] intValue];
    });
    return _deviceSystemMajorVersion;
}

NSString * documentPath() {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

NSString * attachmentPath() {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *attachmentFolder = [documentPath() stringByAppendingPathComponent:@"Attachment"];
    BOOL isDir = FALSE;
    BOOL isDirExist = [fileManager fileExistsAtPath:attachmentFolder isDirectory:&isDir];
    if(!(isDirExist && isDir))
    {
        BOOL bCreateDir = [fileManager createDirectoryAtPath:attachmentFolder withIntermediateDirectories:YES attributes:nil error:nil];
        if(!bCreateDir)
        {
            NSLog(@"Create Audio Directory Failed.");
        }
        
        NSLog(@"%@", attachmentFolder);
    }
    return attachmentFolder;
}

void alert(NSString *text, NSString *buttonTitle) {
    if (OSVersion() >= 7) {
        [[[UIAlertView alloc] initWithTitle:nil message:text delegate:nil cancelButtonTitle:buttonTitle otherButtonTitles:nil, nil] show];
    } else {
        SIAlertView *alertView = [[SIAlertView alloc] initWithTitle:nil andMessage:text];
        [alertView addButtonWithTitle:buttonTitle type:SIAlertViewButtonTypeDefault handler:nil];
        [alertView show];
    }
}

@end


@implementation NSNumber (Helpers)

extern NSString *updatedDate(NSNumber *num) {
    
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    NSDateComponents *components = [gregorian components:unitFlags
                                                fromDate:[NSDate dateWithTimeIntervalSince1970:num.floatValue]
                                                  toDate:[NSDate date]
                                                 options:0];
    
    int year    = [components year];
    int month   = [components month];
    int day     = [components day];
    int hour    = [components hour];
    int minute  = [components minute];
    int second  = [components second];
    
    
    if (year) {
        return [NSString stringWithFormat:@"%d %@", year, (year > 1 ? @"years" : @"year")];
    }
    else if (month) {
        return [NSString stringWithFormat:@"%d %@", month, (month > 1 ? @"mons" : @"mon")];
    }
    else if (day) {
        return [NSString stringWithFormat:@"%d %@", day, (day > 1 ? @"days" : @"day")];
    }
    else if (hour) {
        return [NSString stringWithFormat:@"%d %@", hour, (hour > 1 ? @"hrs" : @"hr")];
    }
    else if (minute) {
        return [NSString stringWithFormat:@"%d %@", minute, (minute > 1 ? @"mins" : @"min")];
    }
    else {
        return [NSString stringWithFormat:@"%d %@", second, (second > 1 ? @"secs" : @"sec")];
    }
}

@end


@implementation NSString (Helpers)

extern NSString *standardFileSize(NSString *fileSize) {

    float size = fileSize.floatValue;
    
    if (size > 1024 * 1024)
    {
        return [NSString stringWithFormat:@"%.1fM", size/(1024.f*1024.f)];
    }
    else if (size > 1024)
    {
        return [NSString stringWithFormat:@"%.1fK", size/1024.f];
    }
    else
    {
        return [NSString stringWithFormat:@"%.1fB", size];
    }
}

@end


@implementation UILabel (Helpers)

- (void)setDynamicFrame {
    
    CGSize size = paragraphSize(self.text, self.font, CGSizeMake(280, 1000));
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y + 6, self.frame.size.width, size.height);
}

CGSize paragraphSize(NSString *text, UIFont *font, CGSize size) {
    
    return [text        sizeWithFont:font
                   constrainedToSize:CGSizeMake(size.width, size.height)
                       lineBreakMode:NSLineBreakByWordWrapping];
}

@end
