//
//  UICostumeViewController.m
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UICostumeViewController.h"
#import "EventClothTypeInfo.h"
#import "ClothTypeHelper.h"

@interface UICostumeViewController ()

@end

@implementation UICostumeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = NLS(@"Costume");

    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tagsView = [UITagsView loadFromNib];
    _tagsView.frame = _tagsPlaceHolder.bounds;
    _tagsView.delegate = self;
    _tagsView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    _tagsPlaceHolder.backgroundColor = [UIColor clearColor];
    _tagsView.backgroundColor = [UIColor grayColor];
    _tagsView.frame = _tagsPlaceHolder.bounds;
    _tagsView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    [_tagsPlaceHolder addSubview:_tagsView];

    _filterLabel.text = NLS(@"Filter");
    
    NSArray *seasonFilters = [ClothTypeHelper seasonClothTypes];
    _seasonFiltersView = [UIFiltersView loadFromNib];
    _seasonFiltersView.delegateFilterItem = self;
    _seasonFiltersView.frame = _filterPlaceHolder.bounds;
    _seasonFiltersView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    _seasonFiltersView.clothTypeFilters = seasonFilters;
    [_filterPlaceHolder addSubview:_seasonFiltersView];
    
    NSArray *eventFilters = [ClothTypeHelper eventClothTypes];
    _eventFiltersView = [UIFiltersView loadFromNib];
    _eventFiltersView.delegateFilterItem = self;

    _eventFiltersView.frame = _filter2PlaceHolder.bounds;
    _eventFiltersView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    _eventFiltersView.clothTypeFilters = eventFilters;
    [_filter2PlaceHolder addSubview:_eventFiltersView];

    NSArray *colorFilters = [ClothTypeHelper colorClothTypes];
    _colorFiltersView = [UIFiltersView loadFromNib];
    _colorFiltersView.delegateFilterItem = self;
    _colorFiltersView.frame = _filter3PlaceHolder.bounds;
    _colorFiltersView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    _colorFiltersView.clothTypeFilters = colorFilters;
    [_filter3PlaceHolder addSubview:_colorFiltersView];

    _resultFilterView = [UIResultFilterView loadFromNib];
    _resultFilterView.frame = _resultsPlaceholder.bounds;
    _resultFilterView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    [_resultsPlaceholder addSubview:_resultFilterView];
}

- (void)reloadData
{
    NSMutableArray *query = [NSMutableArray array];
    for (ClothType *clothType in [_tagsView clothTypeTags])
    {
        [query addObject:clothType.strType];
    }
    [_resultFilterView updateQueryFilter:query];
}

- (void)layoutData
{
    NSMutableString *filter = [NSMutableString stringWithString:NLS(@"Filter is: ")];
    for (ClothType *clothType in [_tagsView clothTypeTags])
    {
        [filter appendFormat:@"%@ ", clothType.strType];
    }
    
    _filterLabel.text = filter;
    
    NSMutableArray *query = [NSMutableArray array];
    for (ClothType *clothType in [_tagsView clothTypeTags])
    {
        [query addObject:clothType];
    }
    [_resultFilterView updateQueryFilter:query];
}

- (int)numOfColorTypeInTagsView
{
    int sum = 0;
    
    for (ClothType *clothType in [_tagsView clothTypeTags])
    {
        if ([clothType isKindOfClass:[ColorClothTypeInfo class]])
        {
            sum++;
        }
    }
    
    return sum;
}

/* UIFilterItemView Delegates */

- (void)filterItemViewClicked:(UIFilterItemView *)filterItemView
{
    if ([[_tagsView clothTypeTags] containsObject:filterItemView.clothType])
    {
        return;
    }
    [_tagsView addClothType:filterItemView.clothType];
    
    if ([filterItemView.clothType isKindOfClass:[EventClothTypeInfo class]])
    {
        _filter2TopContraint.constant = - _seasonFiltersView.height;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    if ([filterItemView.clothType isKindOfClass:[ColorClothTypeInfo class]] && [self numOfColorTypeInTagsView] >=3)
    {
        _filter3TopConstraint.constant = - _eventFiltersView.height;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    if ([filterItemView.clothType isKindOfClass:[SeasonClothTypeInfo class]])
    {
        _filter1TopConstraint.constant = - _tagsPlaceHolder.height;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    [self layoutData];
}

/* End UIFilterItemView Delegates */

/* UITagsView Delegates */

- (void)tagsView:(UITagsView *)tagView didDeleteTag:(UIBubbleContactItemView *)bubbleItemTag withClothTypeInfo:(ClothType *)clothTypeInfo
{
    if ([clothTypeInfo isKindOfClass:[EventClothTypeInfo class]])
    {
        _filter2TopContraint.constant = 0;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    if ([clothTypeInfo isKindOfClass:[ColorClothTypeInfo class]])
    {
        _filter3TopConstraint.constant = 0;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    if ([clothTypeInfo isKindOfClass:[SeasonClothTypeInfo class]])
    {
        _filter1TopConstraint.constant = 0;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    
    [self layoutData];
}

/* End UITagsView Delegates */

@end
