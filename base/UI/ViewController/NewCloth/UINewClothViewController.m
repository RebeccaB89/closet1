//
//  UINewClothViewController.m
//  base
//
//  Created by rebecca biaz on 7/16/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UINewClothViewController.h"
#import "FilterLogic.h"

@interface UINewClothViewController ()
{
    NSDictionary *_clothTypes;
}
@end

@implementation UINewClothViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self reloadData];
    [self layoutData];
}

- (void)reloadData
{
    _clothTypes = [[FilterLogic sharedInstance] clothTypes];
}

- (void)setClothInfo:(Cloth *)clothInfo
{
    _clothInfo = clothInfo;
    
    [self layoutData];
}

- (void)layoutData
{
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
//                                                         NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
//    NSString* path = clothInfo.imagePath;
//    UIImage* image = [UIImage imageWithContentsOfFile:path];
//    [self sendAction:path];
//    return image;
    _imageView.image = [UIImage imageWithContentsOfFile:_clothInfo.imagePath];
    [_tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[_clothTypes allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

@end
