//
//  BCPDFContentViewController.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-10.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, BCPDFPageTurnPageStyle)
{
  BCPDFPageTurnPageVerticalScrollStyle,
  BCPDFPageTurnPageHrozinalScrollStyle,
  BCPDFPageTurnPageCurlStyle
};

@class BCPDFTurnPageHandler;

@interface BCPDFContentViewController : UIViewController

@property (nonatomic, assign) BCPDFPageTurnPageStyle style;
//@property (nonatomic, assign) BCPDFTurnPageHandler   *pdfHandler;

@end
