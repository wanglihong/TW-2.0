//
//  APPSettings.m
//  TW+(iPhone)
//
//  Created by Dennis Yang on 13-8-26.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "APPSettings.h"

#define token @"54ab0ebddcce4697ab4082c493f7b625"
#define expir @"1234564151354"

static APPSettings *instance = NULL;

@implementation APPSettings

+ (id)instance
{
    @synchronized(self)
	{
        if (instance == NULL)
		{
            instance = [[self alloc] init];
		}
	}
    return(instance);
}

- (void)baseSetting
{
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    
    [defaultValues setValue:nil forKey:@"username"];
    [defaultValues setValue:nil forKey:@"password"];
    [defaultValues setValue:nil forKey:@"access_token"];
    [defaultValues setValue:nil forKey:@"expires_on"];
    [defaultValues setValue:nil forKey:@"justFinishedLogin"];
    [defaultValues setValue:[NSNumber numberWithInteger:0] forKey:@"unloadedDocumentsCount"];
    [defaultValues setValue:[NSDate dateWithTimeIntervalSinceNow:-3600] forKey:@"BrandListLastUpdatedDate"];
    [defaultValues setValue:[NSDate dateWithTimeIntervalSinceNow:-3600] forKey:@"DocumentListLastUpdatedDate"];
    [defaultValues setObject:[NSMutableArray array] forKey:@"favorite"];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
}

- (BOOL)accessValid
{
    NSString *expiresDate = [[NSUserDefaults standardUserDefaults] objectForKey:@"expires_on"];
    if ( expiresDate && ([[NSDate date] timeIntervalSince1970] < [expiresDate doubleValue]) )
        return YES;
    else
        return NO;
}

@end
