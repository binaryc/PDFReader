//
//  BCPDFContentView.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-13.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFContentView.h"
#import "BCPDFLayer.h"
#import "BCPDFDocument.h"

@implementation BCPDFContentView
{
  BCPDFDocument *_pdf;
}

+ (Class)layerClass
{
  return [BCPDFLayer class];
}

- (instancetype)initWithFrame:(CGRect)frame andPDFDocument:(BCPDFDocument *)pdf
{
  self = [super initWithFrame:frame];

  if (self) {
    _pdf = pdf;
  }
  
  return self;
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
  CGPDFPageRef page = [_pdf pdfPageAtIndex:_pageIndex];
  CGContextSetRGBFillColor(ctx, 1.f, 1.f, 1.f, 1.f);
  CGContextFillRect(ctx, self.bounds);
  CGContextScaleCTM(ctx, 1.f, -1.f);
  CGContextTranslateCTM(ctx, 0, -CGRectGetHeight(self.bounds));
  CGContextConcatCTM(ctx, CGPDFPageGetDrawingTransform(page, kCGPDFCropBox, self.bounds, 0, true));
  CGContextSetRenderingIntent(ctx, kCGRenderingIntentDefault);
  CGContextSetInterpolationQuality(ctx, kCGInterpolationDefault);
  CGContextDrawPDFPage(ctx, page);
}

- (void)setPageIndex:(NSInteger)pageIndex
{
  _pageIndex = pageIndex;
  [self setNeedsLayout];
}

@end