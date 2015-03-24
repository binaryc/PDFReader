//
//  BCImage.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCImageContainer : NSObject

@property (nonatomic, strong  ) UIImage *realImage;
@property (nonatomic, readonly) UIImage *defaultImage;

@end
