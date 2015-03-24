//
//  BCPDFScrollView.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-13.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCPDFDocument;

@interface BCPDFScrollView : UIScrollView
<UIScrollViewDelegate>

@property (nonatomic, assign  ) CGFloat       zoomLevel;
@property (nonatomic, strong  ) BCPDFDocument *document;
@property (nonatomic, readonly) NSInteger     pdfPageIndex;

- (void)goToPage:(NSInteger)index;

@end
