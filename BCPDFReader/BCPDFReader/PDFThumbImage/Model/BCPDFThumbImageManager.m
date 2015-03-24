//
//  BCPDFThumbImageManager.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFThumbImageManager.h"
#import "BCPDFThumbImageOperation.h"
#import "BCPDFPage.h"
#import "BCPDFDocument.h"

@interface BCPDFThumbImageManager ()
<BCOperationDelegate>

@end

@implementation BCPDFThumbImageManager
{
  NSOperationQueue *_queue;
  NSString         *_path;
  BCPDFDocument    *_pdfDocument;
}

- (instancetype)init
{
  self = [super init];
  if (self) {
    [self createDirectory];
    [self configOperationQueue];
  }
  return self;
}

- (void)dealloc
{

}

#pragma mark -
#pragma mark Private Method

- (void)createDirectory
{
  NSString *path = [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), @"Documents/Thumbs"];
  NSFileManager *manager = [[NSFileManager alloc] init];
  
  if ([manager fileExistsAtPath:path]) {
    return;
  }
  
  [manager createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
  
}

- (void)configOperationQueue
{
  _queue = [[NSOperationQueue alloc] init];
  [_queue setMaxConcurrentOperationCount:1];
}

- (void)addOperationAtIndex:(NSInteger)index
{
  BCPDFPage *page = [[BCPDFPage alloc] init];
  page.size = CGSizeMake(320, 460);
  page.index = index;
  page.pageRef = [_pdfDocument pdfPageAtIndex:(index + 1)];
  
  BCPDFThumbImageOperation *operation = [[BCPDFThumbImageOperation alloc] init];
  operation.pdfPage = page;
  operation.delegate = self;
  operation.identier = [NSString stringWithFormat:@"thumb%d.png", index];//是否要提出来
  [_queue addOperation:operation];
}

#pragma mark -
#pragma mark Public Method

- (void)createThumbImageForPDF:(BCPDFDocument *)pdf waitUntilFinished:(BOOL)finished
{
  _pdfDocument = pdf;
  NSInteger pdfPageCount = _pdfDocument.pageNumber;
  for (int pageIndex = 0; pageIndex < pdfPageCount; pageIndex++)
  {
    [self addOperationAtIndex:pageIndex];
  }
  
  if (finished) {
    [_queue waitUntilAllOperationsAreFinished];
  }
}

- (void)cancel
{
  [_queue setSuspended:YES];
  
  for (BCPDFThumbImageOperation *operation in _queue.operations) {
    [operation cancel];
  }
}

- (BOOL)cleanThumbImage
{
  NSString *path = [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), @"Documents/Thumbs"];
  NSFileManager *manager = [[NSFileManager alloc] init];
  BOOL succeed = [manager removeItemAtPath:path error:nil];
  return succeed;
}

#pragma mark -
#pragma mark Delegate Method

- (void)operation:(BCPDFThumbImageOperation *)operation didFinishCreatePDFThumbImage:(UIImage *)image atIndex:(NSInteger)index
{
  [[NSOperationQueue mainQueue] addOperationWithBlock:^{
    self.imageHandler(image, index);
  }];
}

@end
