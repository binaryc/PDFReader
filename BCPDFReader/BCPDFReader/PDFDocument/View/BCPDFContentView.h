//
//  BCPDFContentView.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-13.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCPDFDocument;

@interface BCPDFContentView : UIView

@property (nonatomic, assign) NSInteger pageIndex;

- (instancetype)initWithFrame:(CGRect)frame andPDFDocument:(BCPDFDocument *)pdf;

@end
