//
//  DocumentTableViewCell.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-24.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Document.h"

@interface DocumentTableViewCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UIImageView *profileImageView;
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *updateLabel;
@property (nonatomic, weak) IBOutlet UILabel *dateLabel;
@property (nonatomic, weak) IBOutlet UILabel *commentCountLabel;
@property (nonatomic, weak) IBOutlet UILabel *likeCountLabel;
@property (nonatomic, strong) Document *document;

@end
