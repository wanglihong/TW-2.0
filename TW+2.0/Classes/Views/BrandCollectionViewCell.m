//
//  BrandCollectionViewCell.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-24.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "BrandCollectionViewCell.h"
#import "Constants.h"

@implementation BrandCollectionViewCell

- (void)awakeFromNib
{
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.font = [UIFont fontWithName:@"Avenir-Black" size:15.0f];
    
    UIColor* mainColor = THEME_COLOR_FULL;
    
    self.bgView.backgroundColor = THEME_COLOR_FULL;
    self.bgView.layer.cornerRadius = 3.0f;
    
    self.clipsToBounds = YES;
    
    
    self.numberLabel.backgroundColor = [UIColor whiteColor];
    self.numberLabel.layer.cornerRadius = 10.0f;
    self.numberLabel.textColor = mainColor;
    self.numberLabel.layer.borderWidth = 0.5f;
    self.numberLabel.layer.borderColor = [UIColor colorWithWhite:0.9 alpha:0.6].CGColor;
}

- (void)setNumber:(NSInteger)count
{
    self.numberLabel.alpha = count > 0 ? 1 : 0 ;
    self.numberLabel.text = [NSString stringWithFormat:@"%d", count];
    
    if (count != 0) {
        CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        rotationAnimation.toValue = [NSNumber numberWithFloat:(M_PI_2)];
        rotationAnimation.duration = 2.0f;
        rotationAnimation.repeatCount = 1;//HUGE_VALF;
        rotationAnimation.autoreverses = YES;
        rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
        [self.numberLabel.layer addAnimation:rotationAnimation forKey:@"rotateAnimation"];
    }
}

- (void)setBrand:(Brand *)brand
{
    _brand = brand;
    
    [self.titleLabel setText:brand.name];
    [self.logoView setImageWithURL:[NSURL URLWithString:brand.iconUrl]];
    [self setNumber:brand.numsUpdate.integerValue];
}

- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self setNeedsDisplay];
}

- (void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    
    if (self.highlighted) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(context, 1, 0, 0, 1);
        CGContextFillRect(context, self.bounds);
    }
}

@end
