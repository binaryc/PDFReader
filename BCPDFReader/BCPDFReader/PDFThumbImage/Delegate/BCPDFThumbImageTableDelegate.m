//
//  BCPDFThumbImageTableDelegate.m
//  BCPDFReader
//
//  Created by Bin Chen on 14-10-11.
//  Copyright (c) 2014年 TouchDream. All rights reserved.
//

#import "BCPDFThumbImageTableDelegate.h"
#import "BCThumbImageTableViewCell.h"

@interface BCPDFThumbImageTableDelegate ()

@property (nonatomic, copy) NSArray *datasource;

@end

@implementation BCPDFThumbImageTableDelegate

- (instancetype)initWithThumbImages:(NSArray *)images
{
  self = [super init];
  if (self) {
    self.datasource = images;
  }
  
  return self;
}

#pragma mark -
#pragma mark TableView Delegate Method

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.datasource count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  BCThumbImageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.identifier];
  if (!cell) {
    cell = [[BCThumbImageTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:self.identifier];
  }
  
  [cell configCellStyleWithImageContainer:[self.datasource objectAtIndex:indexPath.row]];
  return cell;
}

@end
