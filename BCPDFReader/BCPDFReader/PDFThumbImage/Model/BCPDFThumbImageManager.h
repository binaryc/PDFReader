//
//  BCPDFThumbImageManager.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BCPDFDocument;

typedef void (^ThumbImageCreateCompletionBlock)(UIImage *thumbImage, NSInteger index);

@interface BCPDFThumbImageManager : NSObject

@property (nonatomic, strong) ThumbImageCreateCompletionBlock imageHandler;

- (void)createThumbImageForPDF:(BCPDFDocument *)pdf
             waitUntilFinished:(BOOL)finished;

- (void)cancel;
- (BOOL)cleanThumbImage;


@end
