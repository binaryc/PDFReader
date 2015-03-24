//
//  BCPDFTurnPageDelegate.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-13.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BCPDFDocument;

@interface BCPDFTurnPageHandler : NSObject
<UIPageViewControllerDelegate,
UIPageViewControllerDataSource>

@property (nonatomic, strong) BCPDFDocument *pdfDocument;

- (UIViewController *)pageViewControllerSubControllerAtIndex:(NSInteger)index;

@end
