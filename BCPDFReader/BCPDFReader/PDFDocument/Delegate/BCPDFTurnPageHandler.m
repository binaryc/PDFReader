//
//  BCPDFTurnPageDelegate.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-13.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFTurnPageHandler.h"
#import "BCPDFScrollView.h"
#import "BCPDFDocument.h"

@implementation BCPDFTurnPageHandler
{
  NSInteger  _pdfIndex;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    _pdfIndex = 1;
  }
  
  return self;
}

- (UIViewController *)pageViewControllerSubControllerAtIndex:(NSInteger)index
{
  UIViewController *controller = [[UIViewController alloc] init];
  BCPDFScrollView *contentView = [[BCPDFScrollView alloc] initWithFrame:kPDFContentViewBounds];
  contentView.document = _pdfDocument;
  [contentView goToPage:index];
  [controller.view addSubview:contentView];
  return controller;
}
#pragma mark -
#pragma mark UIPageViewController Delegate

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{

  NSInteger index = [self pdfPageInViewController:viewController];
  
  if (index == 1 || index == NSNotFound) {
    return nil;
  }

  
  UIViewController *controller = [self pageViewControllerSubControllerAtIndex:(--index)];
  
  return controller;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
  NSInteger index = [self pdfPageInViewController:viewController];
  
  if (index == ([_pdfDocument pageNumber]) || index == NSNotFound) {
    return nil;
  }
  
  UIViewController *controller = [self pageViewControllerSubControllerAtIndex:(++index)];
  
  return controller;
}

- (NSInteger)pdfPageInViewController:(UIViewController *)viewController
{
  for (UIView *subview in viewController.view.subviews) {
    if ([subview isKindOfClass:[BCPDFScrollView class]])
    {
      BCPDFScrollView *contentView = (BCPDFScrollView *)subview;
      _pdfIndex = contentView.pdfPageIndex;
      
      break;
    }
  }
  
  return _pdfIndex;
}

@end
