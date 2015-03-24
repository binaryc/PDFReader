//
//  BCPDFThumbImage.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BCPDFPage;

@interface BCPDFThumbImage : NSObject

@property (nonatomic, strong  ) BCPDFPage *pdf;
@property (nonatomic, readonly) NSString  *baseThumbDirectory;
@property (nonatomic, readonly) UIImage   *thumbPDFImage;
@property (nonatomic, strong  ) NSString  *thumbImageName;

@end
