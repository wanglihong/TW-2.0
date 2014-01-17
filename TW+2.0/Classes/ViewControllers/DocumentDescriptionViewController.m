//
//  DocumentDescriptionViewController.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-27.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "DocumentDescriptionViewController.h"
#import "NSObject+Helpers.h"
#import "CircleProgress.h"
#import "AFNetworking.h"
#import "StoreManager.h"
#import "UIViewController+Helpers.h"
#import "DocumentDisplayViewController.h"

@interface DocumentDescriptionViewController ()
{
    UIBackgroundTaskIdentifier _backgroundTask;
    BOOL _downloading;
}
@end

@implementation DocumentDescriptionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIColor* mainColor = THEME_COLOR_FULL;
    NSString* fontName = @"Avenir-Book";
    NSString* boldItalicFontName = @"Avenir-BlackOblique";
    
    
    self.nameLabel.textColor =  mainColor;
    self.nameLabel.font =  [UIFont fontWithName:boldItalicFontName size:18.0f];
    self.nameLabel.text =  self.document.name;
    
    self.usernameLabel.textColor =  mainColor;
    self.usernameLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.usernameLabel.text =  [NSString stringWithFormat:@"@%@", self.document.author];
    
    UIFont* countLabelFont = [UIFont fontWithName:boldItalicFontName size:20.0f];
    UIColor* countColor = mainColor;
    
    self.followerCountLabel.textColor =  countColor;
    self.followerCountLabel.font =  countLabelFont;
    self.followerCountLabel.text = standardFileSize(self.document.fileSize);
    
    self.followingCountLabel.textColor =  countColor;
    self.followingCountLabel.font =  countLabelFont;
    self.followingCountLabel.text = [self.document.fileType lowercaseString];
    
    self.updateCountLabel.textColor =  countColor;
    self.updateCountLabel.font =  countLabelFont;
    self.updateCountLabel.text = updatedDate(self.document.updateTime);
    
    UIFont* socialFont = [UIFont fontWithName:boldItalicFontName size:10.0f];
    
    self.followerLabel.textColor =  mainColor;
    self.followerLabel.font =  socialFont;
    self.followerLabel.text = @"SIZE";
    
    self.followingLabel.textColor =  mainColor;
    self.followingLabel.font =  socialFont;
    self.followingLabel.text = @"TYPE";
    
    self.updateLabel.textColor =  mainColor;
    self.updateLabel.font =  socialFont;
    self.updateLabel.text = @"UPDATES";
    
    self.bioLabel.textColor =  mainColor;
    self.bioLabel.font =  [UIFont fontWithName:fontName size:14.0f];
    self.bioLabel.text = self.document.describe;
    
    self.profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.borderWidth = 4.0f;
    self.profileImageView.layer.cornerRadius = 55.0f;
    self.profileImageView.layer.borderColor = mainColor.CGColor;
    
    self.profileButton.contentMode = UIViewContentModeScaleToFill;
    self.profileButton.clipsToBounds = YES;
    self.profileButton.layer.borderWidth = 4.0f;
    self.profileButton.layer.cornerRadius = 55.0f;
    self.profileButton.layer.borderColor = mainColor.CGColor;
    self.profileButton.alpha = 0.2f;
    
    
    [self.bioLabel setDynamicFrame];
    [self.profileImageView setImageWithURL:[NSURL URLWithString:self.document.iconUrl]];
    [self.profileButton setBackgroundImage:self.profileImageView.image forState:UIControlStateNormal];
    [self.scrollView setContentSize:[self dynamicContentSize]];
    [self.scrollView setShowsVerticalScrollIndicator:NO];
    

    if (OSVersion() < 7) {
        [self styleNavigationBarWithFontName:@"Avenir-Black"];
        [self styleNavigationBarButtonItemWithImage:@"back.png" action:@selector(back:) isLeft:YES];
    }
    [self updateFavoriteStatus];
    [self updateProfileButtonStatus];
    [self addDownloadProgressObserver];
}

- (void)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)updateFavoriteStatus {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [NSMutableArray arrayWithArray:[defaults objectForKey:@"favorite"]];
    
    if ([favorites containsObject:self.document.dId]) {
        [self styleNavigationBarButtonItemWithImage:@"favorite_delete.png" action:@selector(deleteFavorite:) isLeft:NO];
    } else {
        [self styleNavigationBarButtonItemWithImage:@"favorite_add.png" action:@selector(addFavorite:) isLeft:NO];
    }
}

- (void)addFavorite:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [NSMutableArray arrayWithArray:[defaults objectForKey:@"favorite"]];
    
    [favorites addObject:self.document.dId];
    [defaults setObject:favorites forKey:@"favorite"];
    [self updateFavoriteStatus];
}

- (void)deleteFavorite:(id)sender {
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *favorites = [NSMutableArray arrayWithArray:[defaults objectForKey:@"favorite"]];
    
    [favorites removeObject:self.document.dId];
    [defaults setObject:favorites forKey:@"favorite"];
    [self updateFavoriteStatus];
}

- (CGSize)dynamicContentSize {
    
    float heightShouldBe = self.bioContainer.frame.origin.y + self.bioLabel.frame.size.height + 30;
    return CGSizeMake(320, MAX(self.view.frame.size.height, heightShouldBe));
}

- (void)updateProfileButtonStatus {
    
    if ([self.document exist]) {
        
        [self.profileButton removeTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
        [self.profileButton addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
        [self.profileImageView setAlpha:1.0f];
        
    } else {
        
        [self.profileButton removeTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
        [self.profileButton addTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
        [self.profileImageView setAlpha:0.2f];
    }
}

- (void)addDownloadProgressObserver {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(complete:)
                                                 name:self.document.dId
                                               object:nil];
}

#define PROGRESS_VIEW_TAG 808

- (void)complete:(NSNotification *)notification
{
    NSNumber *progress = [notification object];
    
    CircleProgress *cp = (CircleProgress *)[self.overlayView viewWithTag:PROGRESS_VIEW_TAG];
    if (!cp) {
        cp = [[CircleProgress alloc] initWithFrame:self.profileButton.frame
                                           bgColor:[UIColor clearColor]
                                           pgColor:THEME_COLOR_FULL
                                             width:4.0];
        cp.tag = PROGRESS_VIEW_TAG;
        [self.overlayView addSubview:cp];
    }
    [cp updateProgress:progress.floatValue/100];
    
    if (progress.intValue == 100) {
        [self.profileButton removeTarget:self action:@selector(download:) forControlEvents:UIControlEventTouchUpInside];
        [self.profileButton addTarget:self action:@selector(read:) forControlEvents:UIControlEventTouchUpInside];
        [self.profileImageView setAlpha:1.0f];
    }
}

- (void)download:(id)sender
{
    if (_downloading) {
        return;
    }
    
    _backgroundTask = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:nil];
    
    NSURL *url = [NSURL URLWithString:self.document.fileUrl];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:@"access_token"];
    [request addValue:token forHTTPHeaderField:@"Authorization"];
    
    AFURLConnectionOperation *operation = [[AFURLConnectionOperation alloc] initWithRequest:request];
    AFURLConnectionOperation * __weak weakOperation = operation;
    
    
    
    [operation setDownloadProgressBlock:^(NSUInteger bytesRead,
                                          long long totalBytesRead,
                                          long long totalBytesExpectedToRead) {
        
        float progress_float = (float)totalBytesRead / totalBytesExpectedToRead;
        NSNumber *progress_number = [NSNumber numberWithInt:(int)(progress_float * 100)];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:self.document.dId
                                                            object:progress_number];
    }];
    
    operation.completionBlock = ^ {
        
        NSDictionary *allHeaderFields = [(NSHTTPURLResponse *)weakOperation.response allHeaderFields];
        NSString *contentDisposition = [allHeaderFields valueForKey:@"Content-Disposition"];
        NSString *suffix = [[contentDisposition lastPathComponent] pathExtension];
        
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            [weakOperation.responseData writeToFile:[self fileSavePathWithSuffix:suffix]
                                         atomically:YES];
            
            if (_backgroundTask != UIBackgroundTaskInvalid) {
                [[UIApplication sharedApplication] endBackgroundTask:_backgroundTask];
            }
            
            _downloading = NO;
            [self updateProfileButtonStatus];
            [self performSelector:@selector(read:) withObject:nil afterDelay:0.35];
        });
    };
    
    _downloading = YES;
    [operation start];
}

- (NSString *)fileSavePathWithSuffix:(NSString *)suffix {
    
    [self saveSuffix:suffix];
    
    return [NSString stringWithFormat:@"%@/%@.%@", attachmentPath(), self.document.dId, suffix];
}

- (void)saveSuffix:(NSString *)suffix {
    
    [self.document setValue:suffix forKey:@"fileType"];
    
    NSError *error;
    if (![[StoreManager instance].managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

- (IBAction)read:(id)sender {
    
    if ([self needOpenURL]) {
        
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:self.document.website]];
        
    } else {

        [self performSegueWithIdentifier:@"DisplayDocument" sender:sender];
    }
}

- (BOOL)needOpenURL {
    
    if ([self.document.website rangeOfString:@"itunes.apple.com"].length ||
        [self.document.website rangeOfString:@"itms-services:"].length) {
        
        return YES;
    }
    return NO;
}

@end
