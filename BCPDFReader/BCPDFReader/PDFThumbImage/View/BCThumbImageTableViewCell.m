//
//  BCThumbImageTableViewCell.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCThumbImageTableViewCell.h"
#import "BCImageContainer.h"

@implementation BCThumbImageTableViewCell
{
  UIActivityIndicatorView *_indicator;
  UIImageView             *_contentImageView;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
      [self settingCellStyle];
    }
    return self;
}

- (void)settingCellStyle
{
  self.transform = CGAffineTransformMakeRotation(M_PI/2);
  
  _contentImageView = [[UIImageView alloc] initWithFrame:kThumbImageCellContentImageViewFrame];
  [self.contentView addSubview:_contentImageView];
  
  _indicator = [[UIActivityIndicatorView alloc] initWithFrame:kThumbImageCellIndicatorFrame];
  _indicator.center = _contentImageView.center;
  [self.contentView addSubview:_indicator];
  [self.contentView bringSubviewToFront:_indicator];
}

- (void)configCellStyleWithImageContainer:(BCImageContainer *)imageContainer
{
  if (imageContainer.realImage) {
    [_contentImageView setImage:imageContainer.realImage];
    [_indicator stopAnimating];
  }
  else
  {
    [_contentImageView setImage:imageContainer.defaultImage];
    [_indicator startAnimating];
  }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
