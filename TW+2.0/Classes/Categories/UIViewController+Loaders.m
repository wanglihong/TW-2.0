//
//  UIViewController+Loaders.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-27.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "UIViewController+Loaders.h"
#import "AppAPIClient.h"
#import "JsonAnalyzer.h"
#import "AFHTTPRequestOperation.h"
#import "MBProgressHUD.h"
#import "NSObject+Helpers.h"

@implementation UIViewController (Loaders)

- (void)handleError:(NSError *)error
{
    if ([error.domain isEqualToString:AFNetworkingErrorDomain])
    {
        NSDictionary *userInfo = [error userInfo];
        NSString *localizedRecoverySuggestion = [userInfo valueForKey:@"NSLocalizedRecoverySuggestion"];
        NSData *JSONData = [localizedRecoverySuggestion dataUsingEncoding:NSUTF8StringEncoding];
        
        id responseJSON = [NSJSONSerialization JSONObjectWithData:JSONData
                                                          options:NSJSONReadingAllowFragments
                                                            error:nil];
        
        NSString *msg = [(NSDictionary *)responseJSON valueForKey:@"error_msg"];
        NSInteger code = [[(NSDictionary *)responseJSON valueForKey:@"error_code"] integerValue];
        
        switch (code)
        {
//            case 401:
//                [[[UIAlertView alloc] initWithTitle:nil message:@"未授权" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
//                break;
            default:
//                [[[UIAlertView alloc] initWithTitle:nil message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
                alert(msg, @"OK");
                
                break;
        }
    }
    else if ([error.domain isEqualToString:NSURLErrorDomain])
    {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"Connection Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        alert(@"Connection Error", @"OK");
    }
    else
    {
//        [[[UIAlertView alloc] initWithTitle:nil message:@"Internal Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil] show];
        alert(@"Internal Error", @"OK");
    }
}

@end


#import "AppDelegate.h"

@implementation LoginViewController (Loaders)

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password
{
    NSMutableDictionary *params = [self baseParameters];
    [params setValue:userName forKey:@"login"];
    [params setValue:password forKey:@"pass"];

    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[AppAPIClient sharedClient] postPath:@"api/v1/login"
                               parameters:params
                                  success:^(AFHTTPRequestOperation *operation, id JSON) {
                                      
                                      [JsonAnalyzer analyzeAccessInfo:JSON];
                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                      
                                      [[NSUserDefaults standardUserDefaults] setValue:userName forKey:@"username"];
                                      [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
                                      
                                      [self.usernameField resignFirstResponder];
                                      [self.passwordField resignFirstResponder];
                                      
                                      [[self sideMenu] performSelector:@selector(show) withObject:nil afterDelay:0.25];
                                      
                                      AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                                      [delegate performSelector:@selector(showHome) withObject:nil afterDelay:0.5];
                                  }
                                  failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                      
                                      [self handleError:error];
                                      [MBProgressHUD hideHUDForView:self.view animated:YES];
                                  }];
}

@end


@implementation BrandCollectionViewController (Loaders)

- (void)requestGetBrandList
{
    [[AppAPIClient sharedClient] getPath:@"/api/v1/categories"
                              parameters:self.baseParameters
                                 success:^(AFHTTPRequestOperation *operation, id JSON) {
                                     
                                     [self doneLoadingTableViewData];
                                     [JsonAnalyzer analyzeBrand:JSON];
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     
                                     [self doneLoadingTableViewData];
                                     [self handleError:error];
                                 }];
}

@end


#import "Document.h"

@implementation DocumentCollectionViewController (Loaders)

- (void)requestGetDocumentList
{
    if (self.resultType != ResultTypeDefault) {
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil afterDelay:0.25];
        return;
    }
    
    NSMutableDictionary *params = [self baseParameters];
    
    [[AppAPIClient sharedClient] getPath:@"/api/v1/documents"
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id JSON) {
                                     
                                     [self doneLoadingTableViewData];
                                     [JsonAnalyzer analyzeDocument:JSON isLoadMore:[[_fetchedResultsController fetchedObjects] count] == 0];
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     
                                     [self doneLoadingTableViewData];
                                     [self handleError:error];
                                 }];
}

- (void)requestGetNextPageDocuments
{
    if (![self more]) {
        NSLog(@"All documents is loaded.");
        return;
    }
    
    if (_repagging) {
        NSLog(@"TableView is pagging.");
        return;
    }
    
    
    Document *document = [[_fetchedResultsController fetchedObjects] lastObject];
    NSInteger documentTime = document.updateTime.integerValue;
    NSString *maxTime = [NSString stringWithFormat:@"%d", (documentTime - 1)];
    
    NSMutableDictionary *params = [self baseParameters];
    [params setValue:maxTime forKey:@"max_time"];
    
    _repagging = YES;
    [self.tableView addSubview:self.tableFooterView];
    [[AppAPIClient sharedClient] getPath:@"/api/v1/documents"
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id JSON) {
                                     
                                     _repagging = NO;
                                     [self.tableFooterView removeFromSuperview];
                                     [JsonAnalyzer analyzeDocument:JSON isLoadMore:YES];
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     
                                     _repagging = NO;
                                     [self.tableFooterView removeFromSuperview];
                                     [self handleError:error];
                                 }];
}

- (BOOL)more
{
    NSNumber *total = [[NSUserDefaults standardUserDefaults] valueForKey:@"unloadedDocumentsCount"];
    NSLog(@"%d documents left.", [total intValue]);
    return [total intValue] > 0 || [[_fetchedResultsController fetchedObjects] count] <= 0;
}

@end


@implementation DocumentTableViewController (Loaders)

- (void)requestGetDocumentList
{
    NSMutableDictionary *params = [self baseParameters];
    [params setValue:self.brand.cId forKey:@"category_ids"];
    
    [[AppAPIClient sharedClient] getPath:@"/api/v1/documents"
                              parameters:params
                                 success:^(AFHTTPRequestOperation *operation, id JSON) {
                                     
                                     [self doneLoadingTableViewData];
                                     [JsonAnalyzer analyzeDocument:JSON inBrand:self.brand];
                                 }
                                 failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                     
                                     [self doneLoadingTableViewData];
                                     [self handleError:error];
                                 }];
}

@end
