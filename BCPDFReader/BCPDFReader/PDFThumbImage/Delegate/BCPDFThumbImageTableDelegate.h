//
//  BCPDFThumbImageTableDelegate.h
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BCPDFThumbImageTableDelegate : NSObject
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) NSString *identifier;

- (instancetype)initWithThumbImages:(NSArray *)images;

@end
