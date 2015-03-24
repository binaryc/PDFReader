//
//  BCPDFDocument.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFDocument.h"

@implementation BCPDFDocument
{
  NSString        *_path;
  CGPDFDocumentRef _document;
}

- (instancetype)initWithPDFPath:(NSString *)path
{
  self = [super init];
  if (self) {
    _path = path;
    [self PDFDocument];
  }
  
  return self;
}

- (void)PDFDocument
{
  CFStringRef path = CFStringCreateWithCString(NULL,
                                  [_path cStringUsingEncoding:NSUTF8StringEncoding],
                                               kCFStringEncodingUTF8);
  CFURLRef url = CFURLCreateWithFileSystemPath(NULL, path, kCFURLPOSIXPathStyle, 0);
  
  CFRelease(path);
  _document = CGPDFDocumentCreateWithURL(url);
  CFRelease(url);
}

- (NSInteger)pageNumber
{
  return CGPDFDocumentGetNumberOfPages(_document);
}

- (CGPDFPageRef)pdfPageAtIndex:(NSInteger)index
{
  CGPDFPageRef pageRef = CGPDFDocumentGetPage(_document, index);
  return pageRef;
}

- (void)dealloc
{
  CGPDFDocumentRelease(_document);
}

//#pragma mark -
//#pragma mark Singleton Method
//
//static id instance = nil;
//
//+ (instancetype)getInstance
//{
//  @synchronized(self)
//  {
//    if (!instance) {
//      instance = [[BCPDFDocument alloc] init];
//    }
//    
//    return instance;
//  }
//}
//
//+ (instancetype)allocWithZone:(struct _NSZone *)zone
//{
//  @synchronized(self)
//  {
//    if (!instance) {
//      instance = [super allocWithZone:zone];
//    }
//    
//    return instance;
//  }
//}
//
//- (instancetype)copy
//{
//  return self;
//}

@end
