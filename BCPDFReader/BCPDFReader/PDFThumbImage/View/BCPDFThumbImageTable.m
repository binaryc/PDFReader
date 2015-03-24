//
//  BCPDFThumbImageTable.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFThumbImageTable.h"
#import "BCPDFThumbImageTableDelegate.h"

@implementation BCPDFThumbImageTable

- (id)initWithFrame:(CGRect)frame andDelegate:(BCPDFThumbImageTableDelegate *)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
      [self configTableViewStyle];
      self.delegate   = delegate;
      self.dataSource = delegate;
    }
    return self;
}

- (void)configTableViewStyle
{
  self.transform = CGAffineTransformMakeRotation(-M_PI/2);
  self.showsHorizontalScrollIndicator = NO;
  self.showsVerticalScrollIndicator   = NO;
  self.separatorStyle                 = UITableViewCellSeparatorStyleNone;
  self.rowHeight                      = kPDFThumbTableViewCellRowHeight;
}

@end
