//
//  UIFiltersView.m
//  base
//
//  Created by Rebecca Biaz on 6/21/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIFiltersView.h"


@implementation UIFiltersView

- (void)layoutData
{
    
}

- (void)reloadData
{
    for (UIView *subView in _filterScrollView.subviews)
    {
        [subView removeFromSuperview];
    }
    
    CGFloat itemX = 10;
    CGFloat paddingWidth = 5;
    
    for (ClothType *clothType in self.clothTypeFilters)
    {
        UIFilterItemView *filterItemView = [UIFilterItemView loadFromNib];
        filterItemView.delegate = self.delegateFilterItem;
        filterItemView.backgroundColor = [UIColor clearColor];
        filterItemView.clothType = clothType;
        filterItemView.frame = CGRectMake(itemX, 0, filterItemView.width, filterItemView.height);
        itemX = itemX + filterItemView.width + paddingWidth;
        [_filterScrollView addSubview:filterItemView];
    }
    
    _filterScrollView.contentSize = CGSizeMake(itemX, _filterScrollView.height);
    _filterScrollView.backgroundColor = [UIColor clearColor];
}

- (void)setClothTypeFilters:(NSArray *)clothTypeFilters
{
    _clothTypeFilters = clothTypeFilters;
    
    [self reloadData];
}

@end
