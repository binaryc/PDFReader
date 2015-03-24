//
//  BCPDFScrollView.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-13.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFScrollView.h"
#import "BCPDFContentView.h"

@interface BCPDFScrollView ()

//@property (nonatomic, readonly) NSInteger currentPage;

@end

static inline CGFloat ZoomScaleFits(CGSize target, CGSize source)
{
  return MIN(target.width / source.width, target.height / source.height);
}

static inline BOOL isZero(CGFloat number)
{
  if (-0.0000001<number<0.000001) {
    return YES;
  }
  
  return NO;
}

@implementation BCPDFScrollView
{
  BCPDFContentView *_pdfContentView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    self.delegate = self;
    [self createPdfContentView];
  }
  return self;
}

- (void)configScrollViewStyle
{
  self.showsHorizontalScrollIndicator = NO;
  self.showsVerticalScrollIndicator   = NO;
  self.scrollEnabled                  = YES;
  self.autoresizingMask               = UIViewAutoresizingFlexibleHeight|
                                        UIViewAutoresizingFlexibleWidth;
  self.bouncesZoom                    = YES;
  self.contentMode                    = UIViewContentModeRedraw;
  self.delaysContentTouches           = NO;
  self.autoresizesSubviews            = NO;
  self.userInteractionEnabled         = YES;
  self.delegate                       = self;
  self.minimumZoomScale               = 1.f;
  self.maximumZoomScale               = 3.f;
  self.zoomScale                      = 2;
  self.contentSize                    = CGSizeMake(2*CGRectGetWidth(self.frame), 2*CGRectGetHeight(self.frame));
//  [self addObserver:self forKeyPath:@"frame" options:0 context:NULL];
}

- (void)createPdfContentView
{
  if (_pdfContentView) {
    [_pdfContentView removeFromSuperview];
    _pdfContentView = nil;
  }
  
  _pdfContentView = [[BCPDFContentView alloc] initWithFrame:self.bounds
                                             andPDFDocument:_document];
  [self addSubview:_pdfContentView];
}

- (void)dealloc
{
//  [self removeObserver:self forKeyPath:@"frame"];
}

#pragma mark -
#pragma mark Properties Method

- (NSInteger)pdfPageIndex
{
  return _pdfContentView.pageIndex;
}

- (void)setDocument:(BCPDFDocument *)document
{
  _document = document;
  [self createPdfContentView];
}

#pragma mark -
#pragma mark Public Method

- (void)goToPage:(NSInteger)index
{
  _pdfContentView.pageIndex = index;
}

#pragma mark -
#pragma mark Private Method

- (void)updateScale
{
  CGFloat zoomScale = ZoomScaleFits(self.bounds.size, _pdfContentView.bounds.size);
  if (isZero(_zoomLevel)) {
    _zoomLevel = 1;
  }
  
  self.minimumZoomScale = zoomScale;
  self.maximumZoomScale = zoomScale * _zoomLevel;
  self.zoomScale        = self.minimumZoomScale;
}

- (void)resetBackViewFrame
{
  CGRect frame = _pdfContentView.frame;
  if (CGRectGetWidth(frame) < CGRectGetWidth(self.frame))
  {
    frame.origin.x = self.contentOffset.x + (CGRectGetWidth(self.frame) - CGRectGetWidth(frame)) / 2;
  }
  
  if (CGRectGetHeight(frame) < CGRectGetHeight(self.frame))
  {
    frame.origin.y = self.contentOffset.y + (CGRectGetHeight(frame) + CGRectGetHeight(self.frame)) / 2;
  }
  
  _pdfContentView.frame = frame; //?
  
  self.contentSize = CGSizeMake(
                    CGRectGetMinX(_pdfContentView.frame) * 2 + CGRectGetWidth(_pdfContentView.frame)
              , CGRectGetMinY(_pdfContentView.frame) * 2 + CGRectGetHeight(_pdfContentView.frame));
  
  self.contentOffset = CGPointZero;
}

#pragma mark -
#pragma mark Properties Method


#pragma mark -
#pragma mark Delegate Method

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
  return _pdfContentView;
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view
{
  
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(CGFloat)scale
{
  self.contentSize = CGSizeMake(
                                CGRectGetMinX(_pdfContentView.frame) * 2 + CGRectGetWidth(_pdfContentView.frame)
                                , CGRectGetMinY(_pdfContentView.frame) * 2 + CGRectGetHeight(_pdfContentView.frame));
}

#pragma mark -
#pragma mark Observer Method
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
  if (object == self && [keyPath isEqualToString:@"frame"])
  {
    [self updateScale];
    [self resetBackViewFrame];
  }
}

@end
