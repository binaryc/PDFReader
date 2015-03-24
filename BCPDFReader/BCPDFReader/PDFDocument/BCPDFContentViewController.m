//
//  BCPDFContentViewController.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-10.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFContentViewController.h"
#import "BCPDFDocument.h"
#import "BCPDFTurnPageHandler.h"

@interface BCPDFContentViewController ()

@property (nonatomic, strong) UIPageViewController *pdfPageViewController;

@end

@implementation BCPDFContentViewController
{
  UIPageViewControllerTransitionStyle       _transtionStyle;
  UIPageViewControllerNavigationOrientation _naviOrientation;
  NSInteger                                 _pdfIndex;
  BCPDFDocument                             *_pdfDocument;
  BCPDFTurnPageHandler                      *_turnPageHandler;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

  [self pageTurnStyle];
  [self createPDFDocument];
  [self configPDFPageTurnPageHandler];
  [self configPageViewController];
  
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
  
}

#pragma mark -
#pragma mark Private Method

- (void)createPDFDocument
{
  NSString *path = [[NSBundle mainBundle] pathForResource:@"1.pdf" ofType:nil];
  _pdfDocument = [[BCPDFDocument alloc] initWithPDFPath:path];
}

- (void)configPDFPageTurnPageHandler
{
  _turnPageHandler = [[BCPDFTurnPageHandler alloc] init];
  _turnPageHandler.pdfDocument = _pdfDocument;
}

- (void)configPageViewController
{
  
  
  NSDictionary *options =[NSDictionary dictionaryWithObject:
                          [NSNumber numberWithInteger:UIPageViewControllerSpineLocationMin]
                                                     forKey: UIPageViewControllerOptionSpineLocationKey];
  
  self.pdfPageViewController = [[UIPageViewController alloc]
                                        initWithTransitionStyle:_transtionStyle
                                          navigationOrientation:_naviOrientation
                                                        options:options];

  self.pdfPageViewController.dataSource = _turnPageHandler;
  self.pdfPageViewController.doubleSided = NO;
  
  UIViewController *controller = [_turnPageHandler pageViewControllerSubControllerAtIndex:1];
  
  [self.pdfPageViewController setViewControllers:@[controller]
                                       direction:UIPageViewControllerNavigationDirectionForward
                                        animated:NO
                                      completion:nil];
  
  [self addChildViewController:self.pdfPageViewController];
  [self.view addSubview:self.pdfPageViewController.view];
}

- (void)pageTurnStyle
{
  switch (_style) {
    case BCPDFPageTurnPageVerticalScrollStyle:
      _transtionStyle  = UIPageViewControllerTransitionStyleScroll;
      _naviOrientation = UIPageViewControllerNavigationOrientationVertical;
      break;
    case BCPDFPageTurnPageHrozinalScrollStyle:
      _transtionStyle  = UIPageViewControllerTransitionStyleScroll;
      _naviOrientation = UIPageViewControllerNavigationOrientationHorizontal;
      break;
    case BCPDFPageTurnPageCurlStyle:
      _transtionStyle = UIPageViewControllerTransitionStylePageCurl;
      break;
    default:
      break;
  }
}

@end
