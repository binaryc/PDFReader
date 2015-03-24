//
//  BCPDFThumbImageOperation.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFThumbImageOperation.h"
#import "BCPDFThumbImage.h"
#import "BCPDFPage.h"

@implementation BCPDFThumbImageOperation
{
  UIImage *_thumbImage;
}

#pragma mark -
#pragma mark Override Method

- (void)main
{
  BCPDFThumbImage *pdfImage = [[BCPDFThumbImage alloc] init];
  pdfImage.thumbImageName   = _identier?_identier:@"default";
  pdfImage.pdf              = self.pdfPage;
  
  _thumbImage = pdfImage.thumbPDFImage;
  [self didFinishCreateThumbImage];
  
}

- (void)cancel
{
  self.delegate = nil;
  [super cancel];
}

#pragma mark -
#pragma mark Private Method

- (void)didFinishCreateThumbImage
{
  if ([self.delegate respondsToSelector:@selector(operation:didFinishCreatePDFThumbImage:atIndex:)])
  {
    [self.delegate operation:self
  didFinishCreatePDFThumbImage:_thumbImage
                       atIndex:self.pdfPage.index];
  }
}

@end
