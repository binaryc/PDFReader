//
//  BCPDFLayer.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-13.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFLayer.h"

#define kPDFLAYERLEVELSOFDETAIL 4 //缩放的级数 2的n次幂
#define kPDFLAYERLEVELSOFBIAS   3 //在2、4、8倍数时，重绘视图

@implementation BCPDFLayer

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self configLayerStyle];
  }
  
  return self;
}

- (void)configLayerStyle
{
  self.levelsOfDetail = kPDFLAYERLEVELSOFDETAIL;
  
  UIScreen *screen = [UIScreen mainScreen];
  CGFloat scale    = [screen scale];
  CGRect bounds    = [screen bounds];
  
  CGFloat width    = CGRectGetWidth(bounds);
  CGFloat height   = CGRectGetHeight(bounds);
  CGFloat w_pixels = width * scale;
  CGFloat h_pixels = height *scale;
  
  CGFloat max = MAX(MAX(w_pixels, h_pixels), 460);
  
  self.levelsOfDetailBias = scale > 1.f ? 1 : kPDFLAYERLEVELSOFBIAS;
  self.tileSize = CGSizeMake(max, max);
}

@end
