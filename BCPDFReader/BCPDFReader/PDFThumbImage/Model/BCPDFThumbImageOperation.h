//
//  BCPDFThumbImageOperation.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@class BCPDFPage;
@class BCPDFThumbImageOperation;

@protocol BCOperationDelegate <NSObject>

- (void)operation:(BCPDFThumbImageOperation *)operation
    didFinishCreatePDFThumbImage:(UIImage *)image
    atIndex:(NSInteger)index;

@end

@interface BCPDFThumbImageOperation : NSOperation

@property (nonatomic, strong) BCPDFPage           *pdfPage;
@property (nonatomic, strong) NSString            *identier;
@property (nonatomic, assign) id<BCOperationDelegate> delegate;

@end
