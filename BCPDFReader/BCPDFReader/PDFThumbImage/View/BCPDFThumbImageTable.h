//
//  BCPDFThumbImageTable.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BCPDFThumbImageTableDelegate;

@interface BCPDFThumbImageTable : UITableView

- (id)initWithFrame:(CGRect)frame andDelegate:(BCPDFThumbImageTableDelegate *)delegate;

@end
