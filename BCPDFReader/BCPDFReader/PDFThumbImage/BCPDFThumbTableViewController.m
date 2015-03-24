//
//  BCPDFThumbTableViewController.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-10.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFThumbTableViewController.h"

#import "BCPDFThumbImageTable.h"
#import "BCPDFThumbImageTableDelegate.h"
#import "BCPDFThumbImageManager.h"
#import "BCImageContainer.h"
#import "BCThumbImageTableViewCell.h"

#import "BCPDFDocument.h"

@interface BCPDFThumbTableViewController ()

@property (nonatomic, strong) BCPDFThumbImageTableDelegate *delegate;
@property (nonatomic, strong) BCPDFThumbImageTable         *table;
@property (nonatomic, strong) BCPDFDocument                *document;
@property (nonatomic, strong) NSMutableArray               *pdfThumbImages;

@end

@implementation BCPDFThumbTableViewController
{
  BCPDFThumbImageManager *_manager;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [self loadTableView];
  [self loadingThumbImage];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Load View Method

- (void)loadTableView
{
  NSInteger pageCount = self.document.pageNumber;
  _pdfThumbImages = [NSMutableArray array];
  for (int i = 0; i < pageCount; i++) {
    BCImageContainer *container = [[BCImageContainer alloc] init];
    [_pdfThumbImages addObject:container];
  }
  
  _delegate = [[BCPDFThumbImageTableDelegate alloc] initWithThumbImages:_pdfThumbImages];
  _delegate.identifier = @"PDFThumbImageCell";
  
  _table = [[BCPDFThumbImageTable alloc] initWithFrame:CGRectMake(0, 0, 320,320)
                                           andDelegate:_delegate];
  [_table setBackgroundColor:[UIColor greenColor]];
  [self.view addSubview:_table];
  [_table reloadData];
}

- (void)loadingThumbImage
{
   _manager = [[BCPDFThumbImageManager alloc] init];
  [_manager createThumbImageForPDF:self.document waitUntilFinished:NO];
  
  __block NSMutableArray *images = _pdfThumbImages;
  BCPDFThumbImageTable *table = _table;
  _manager.imageHandler = ^(UIImage *image, NSInteger index){
    BCImageContainer *imageContainer = [images objectAtIndex:index];
    imageContainer.realImage = image;
    NSIndexPath *path = [NSIndexPath indexPathForRow:index inSection:0];
    BCThumbImageTableViewCell *cell = (BCThumbImageTableViewCell *)[table cellForRowAtIndexPath:path];
    [cell configCellStyleWithImageContainer:imageContainer];
  };
}

#pragma mark -
#pragma mark Properties Method

- (BCPDFDocument *)document
{
  if (_document) {
    return _document;
  }
  else
  {
    NSString *path = [[NSBundle mainBundle] pathForResource:@"1.pdf" ofType:nil];
    _document = [[BCPDFDocument alloc] initWithPDFPath:path];
    return _document;
  }
}

@end
