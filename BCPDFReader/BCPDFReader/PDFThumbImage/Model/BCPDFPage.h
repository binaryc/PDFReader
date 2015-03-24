//
//  BCPDFPage.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCPDFPage : NSObject

@property (nonatomic) size_t       index;
@property (nonatomic) CGSize       size;
@property (nonatomic) CGPDFPageRef pageRef;

- (void)releasePDFPage;

@end
