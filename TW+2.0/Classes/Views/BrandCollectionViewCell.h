//
//  BrandCollectionViewCell.h
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-24.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brand.h"

@interface BrandCollectionViewCell : UICollectionViewCell

@property (nonatomic, weak) IBOutlet UIView *bgView;
@property (nonatomic, weak) IBOutlet UIImageView *logoView;
@property (nonatomic, weak) IBOutlet UILabel *titleLabel;
@property (nonatomic, weak) IBOutlet UILabel *numberLabel;
@property (nonatomic, strong) Brand *brand;

- (void)setNumber:(NSInteger)count;

@end
