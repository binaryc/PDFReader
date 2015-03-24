//
//  BCRootViewController.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-10.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCRootViewController.h"

#import "BCPDFContentViewController.h"
#import "BCPDFThumbTableViewController.h"

@interface BCRootViewController ()

@property (nonatomic, strong) BCPDFContentViewController    *pdfContentViewController;
@property (nonatomic, strong) BCPDFThumbTableViewController *pdfThumbTableViewController;

@end

@implementation BCRootViewController

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
  
    [self loadPDFContentViewController];
    [self loadPDFThumbTableViewController];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

#pragma mark -
#pragma mark Load View Controller

- (void)loadPDFContentViewController
{
  self.pdfContentViewController = [[BCPDFContentViewController alloc] init];
  self.pdfContentViewController.style = BCPDFPageTurnPageCurlStyle;
  [self addChildViewController:self.pdfContentViewController
            withChildViewFrame:kPDFContentViewFrame];
}

- (void)loadPDFThumbTableViewController
{
  self.pdfThumbTableViewController = [[BCPDFThumbTableViewController alloc] init];
  [self addChildViewController:self.pdfThumbTableViewController
            withChildViewFrame:kPDFThumbTableViewFrame];
  [self.view bringSubviewToFront:self.pdfThumbTableViewController.view];
}

- (void)addChildViewController:(UIViewController *)childController withChildViewFrame:(CGRect)frame
{
  [childController.view setFrame:frame];
  [self addChildViewController:childController];
  [self.view addSubview:childController.view];
}


@end
