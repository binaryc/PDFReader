//
//  BCPDFDocument.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCPDFDocument : NSObject

@property (nonatomic, readonly) NSInteger pageNumber;
@property (nonatomic, strong  ) NSString *pdfPath;

- (instancetype)initWithPDFPath:(NSString *)path;

- (CGPDFPageRef)pdfPageAtIndex:(NSInteger)index;

@end
