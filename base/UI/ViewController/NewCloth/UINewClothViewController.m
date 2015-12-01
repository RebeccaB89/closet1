//
//  UINewClothViewController.m
//  base
//
//  Created by rebecca biaz on 7/16/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UINewClothViewController.h"
#import "FilterLogic.h"
#import "UICategoriesChooserScrollView.h"

@interface UINewClothViewController ()
{
    NSDictionary *_clothTypes;
}
@end

@implementation UINewClothViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _categoryChooserScrollView = [UICategoriesChooserScrollView loadFromNib];
    _categoryChooserScrollView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    _categoryChooserScrollView.frame = _categoryPlaceholder.bounds;
    
    [_categoryPlaceholder addSubview:_categoryChooserScrollView];
    
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(done)];
    [self.navigationItem setRightBarButtonItem:doneButton];
    [self reloadData];
    [self layoutData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_categoryChooserScrollView updateClothInfo];
}

- (void)done
{
    [[InfoLogic sharedInstance] addCloth:_clothInfo];
    
    if (self.popToRoot)
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
    else
        [self.navigationController popViewControllerAnimated:YES];
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
    _imageView.image = _clothInfo.image;
    
    _categoryChooserScrollView.clothInfo = self.clothInfo;
}

@end
