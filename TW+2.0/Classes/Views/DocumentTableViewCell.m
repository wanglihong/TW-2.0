//
//  DocumentTableViewCell.m
//  TW+2.0
//
//  Created by Dennis Yang on 13-12-24.
//  Copyright (c) 2013年 Dennis Yang. All rights reserved.
//

#import "DocumentTableViewCell.h"
#import "Constants.h"
#import "NSObject+Helpers.h"

@implementation DocumentTableViewCell

- (void)awakeFromNib
{
    UIColor* mainColor = THEME_COLOR_FULL;
    UIColor* neutralColor = [UIColor colorWithWhite:0.4 alpha:1.0];
    
    UIColor* mainColorLight = THEME_COLOR_TRANSLUCENT;
    UIColor* lightColor = [UIColor colorWithWhite:0.7 alpha:1.0];
    
    NSString* fontName = @"Avenir-Book";
    NSString* boldItalicFontName = @"Avenir-BlackOblique";
    NSString* boldFontName = @"Avenir-Black";
    
    self.nameLabel.textColor =  mainColor;
    self.nameLabel.font =  [UIFont fontWithName:boldFontName size:14.0f];
    
    self.updateLabel.textColor =  neutralColor;
    self.updateLabel.font =  [UIFont fontWithName:fontName size:12.0f];
    
    self.dateLabel.textColor = lightColor;
    self.dateLabel.font =  [UIFont fontWithName:boldItalicFontName size:8.0f];
    
    self.commentCountLabel.textColor = mainColorLight;
    self.commentCountLabel.font =  [UIFont fontWithName:boldItalicFontName size:10.0f];
    
    self.likeCountLabel.textColor = mainColorLight;
    self.likeCountLabel.font =  [UIFont fontWithName:boldItalicFontName size:10.0f];
    
    self.profileImageView.clipsToBounds = YES;
    self.profileImageView.layer.cornerRadius = 20.0f;
    self.profileImageView.layer.borderWidth = 2.0f;
    self.profileImageView.layer.borderColor = mainColorLight.CGColor;
}

- (void)setDocument:(Document *)document
{
    _document = document;
    
    self.nameLabel.text = document.name;
    self.updateLabel.text = document.describe;
    self.likeCountLabel.text = document.fileType;
    self.dateLabel.text = updatedDate(document.updateTime);
    self.commentCountLabel.text = standardFileSize(document.fileSize);

    [self.profileImageView setImageWithURL:[NSURL URLWithString:document.iconUrl]];
}

@end
