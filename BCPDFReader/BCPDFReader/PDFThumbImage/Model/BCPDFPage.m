//
//  BCPDFPage.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFPage.h"

@implementation BCPDFPage

- (void)setPageRef:(CGPDFPageRef)pageRef
{
  if (_pageRef != NULL) {
    CGPDFPageRelease(_pageRef);
    _pageRef = NULL;
  }
  
  _pageRef = CGPDFPageRetain(pageRef);
}

- (void)releasePDFPage
{
  if (_pageRef != NULL)
  {
    CGPDFPageRelease(_pageRef);
    _pageRef = NULL;
  }
}

@end
