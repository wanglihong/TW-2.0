//
//  DocumentDescriptionViewController.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-27.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "BaseViewController.h"
#import "Document.h"

@interface DocumentDescriptionViewController : BaseViewController

@property (nonatomic, weak) IBOutlet UIImageView* profileImageView;
@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UILabel* usernameLabel;
@property (nonatomic, weak) IBOutlet UILabel* followerLabel;
@property (nonatomic, weak) IBOutlet UILabel* followingLabel;
@property (nonatomic, weak) IBOutlet UILabel* updateLabel;
@property (nonatomic, weak) IBOutlet UILabel* followerCountLabel;
@property (nonatomic, weak) IBOutlet UILabel* followingCountLabel;
@property (nonatomic, weak) IBOutlet UILabel* updateCountLabel;
@property (nonatomic, weak) IBOutlet UILabel* bioLabel;
@property (nonatomic, weak) IBOutlet UIView* overlayView;
@property (nonatomic, weak) IBOutlet UIView* numContainer;
@property (nonatomic, weak) IBOutlet UIView* bioContainer;
@property (nonatomic, weak) IBOutlet UIScrollView* scrollView;
@property (nonatomic, weak) IBOutlet UIButton* profileButton;
@property (nonatomic, strong) Document *document;

@end
