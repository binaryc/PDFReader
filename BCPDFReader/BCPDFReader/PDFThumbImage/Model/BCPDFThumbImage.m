//
//  BCPDFThumbImage.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFThumbImage.h"
#import "BCPDFPage.h"

#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface BCPDFThumbImage ()

@property (nonatomic, readwrite) NSString *baseThumbDirectory;
@property (nonatomic, readwrite) UIImage  *thumbPDFImage;
@property (nonatomic, readonly ) NSString *thumbImagePath;

@end

@implementation BCPDFThumbImage
{
  NSFileManager *_fileManager;
}

#pragma mark -
#pragma mark Properites Method

- (NSString *)baseThumbDirectory
{
  return [NSString stringWithFormat:@"%@/%@", NSHomeDirectory(), @"Documents/Thumbs"];
}

- (UIImage *)thumbPDFImage
{
  if ([self isPDFThumbImageExistInLocal]) {
    return [self thumbImageFromLocal];
  }
  
  return [self drawPDFThumbImage];
}

- (NSString *)thumbImagePath
{
  NSString *imagePath = [NSString stringWithFormat:@"%@/%@", self.baseThumbDirectory, self.thumbImageName];
  return imagePath;
}

#pragma mark -
#pragma mark Public Method


#pragma mark -
#pragma mark Private Method

- (BOOL)isPDFThumbImageExistInLocal
{
  if (!_fileManager) {
    _fileManager = [[NSFileManager alloc] init];
  }
  
  BOOL isExist = [_fileManager fileExistsAtPath:self.thumbImagePath];
  
  return isExist;
}

- (UIImage *)thumbImageFromLocal
{

  UIImage *thmbImage = [UIImage imageWithContentsOfFile:self.thumbImagePath];
  return thmbImage;
}

- (UIImage *)drawPDFThumbImage
{
  CGImageRef thumbImageRef = NULL;
  
  CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
  CGBitmapInfo    info       = kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipFirst;
  CGContextRef    ctx        = CGBitmapContextCreate(NULL, _pdf.size.width, _pdf.size.height,
                                                     8, 0, colorSpace, info);
  
  CGColorSpaceRelease(colorSpace);
  colorSpace = NULL;
  
  if (ctx != NULL)
  {
    CGRect thumbRect = CGRectMake(0, 0, _pdf.size.width, _pdf.size.height);
    CGContextSetRGBFillColor(ctx, 1.f, 1.f, 1.f, 1.f);
    CGContextFillRect(ctx, thumbRect);
    
    CGContextConcatCTM(ctx, CGPDFPageGetDrawingTransform(_pdf.pageRef, kCGPDFCropBox,
                                                         thumbRect, 0, true));
//    CGContextScaleCTM(ctx, 1.f, -1.f);
//    CGContextTranslateCTM(ctx, 0.f, _pdf.size.height);
    CGContextSetRenderingIntent(ctx, kCGRenderingIntentDefault);
    CGContextSetInterpolationQuality(ctx, kCGInterpolationDefault);
    CGContextDrawPDFPage(ctx, _pdf.pageRef);
    
    thumbImageRef = CGBitmapContextCreateImage(ctx);
    CGContextRelease(ctx);
  }
  
  if (thumbImageRef == NULL) {
    return nil;
  }
  
  [self saveCGImage:thumbImageRef];
  
  return [UIImage imageWithCGImage:thumbImageRef scale:1.0 orientation:0];
  
}

- (void)saveCGImage:(CGImageRef)image
{
  NSURL *thumbURL = [NSURL fileURLWithPath:self.thumbImagePath];
  CFURLRef urlRef = (CFURLRef)CFBridgingRetain(thumbURL);
  
  CGImageDestinationRef destination = CGImageDestinationCreateWithURL(urlRef, kUTTypePNG, 1, NULL);
  
  if (destination != NULL) {
    CGImageDestinationAddImage(destination, image, NULL);
    CGImageDestinationFinalize(destination);
    CFRelease(destination);
  }
  
  CFRelease(urlRef);
}

@end
