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
#import "NSDate+Weather.h"
#import "NSDate-Expanded.h"
#import "FilterLogic.h"

@interface UICostumeViewController ()

@end

@implementation UICostumeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    CAGradientLayer *btnGradient = [CAGradientLayer layer];
    //[UIColor lightGrayColor]
    [self.view.layer insertSublayer:btnGradient atIndex:0];
    btnGradient.frame = self.view.bounds;
    btnGradient.colors = [NSArray arrayWithObjects:
                          (id)LOGIN_BUTTON_GRADIENT_START.CGColor,
                          (id)LOGIN_BUTTON_GRADIENT_END.CGColor,
                          nil];

    
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
    
    [self reloadData];
    [self layoutData];
}

- (void)reloadData
{
    NSMutableArray *query = [NSMutableArray array];
    for (ClothType *clothType in [_tagsView clothTypeTags])
    {
        [query addObject:clothType];
    }
    
    [FilterLogic sharedInstance].accordingFilterByMeteo = _segmentedControl.selectedSegmentIndex;

    ClothType *clothTypeForFilterOption = [self clothTypeForFilterOption:[[FilterLogic sharedInstance] accordingFilterByMeteo]];
    if (clothTypeForFilterOption)
    {
        [query addObject:clothTypeForFilterOption];
    }

    [_resultFilterView updateQueryFilter:query];
}

- (void)layoutData
{
    ClothType *clothTypeForFilterOption = [self clothTypeForFilterOption:[FilterLogic sharedInstance].accordingFilterByMeteo];
    if (clothTypeForFilterOption)
    {
        [self clothTypeChoosed:clothTypeForFilterOption];
    }

//    NSMutableArray *query = [NSMutableArray array];
//    for (ClothType *clothType in [_tagsView clothTypeTags])
//    {
//        [query addObject:clothType];
//    }
//    
//    ClothType *clothTypeForFilterOption = [self clothTypeForFilterOption:[[FilterLogic sharedInstance] accordingFilterByMeteo]];
//    if (clothTypeForFilterOption)
//    {
//        [query addObject:clothTypeForFilterOption];
//    }
//    
//    [_resultFilterView updateQueryFilter:query];
}

- (ClothType *)clothTypeForFilterOption:(FilterMeteoOption)filterMeteoOption
{
    switch (filterMeteoOption)
    {
        case filterMeteoOptionToday:
        {
            NSDate *today = [NSDate date];
            if ([today isSpring])
            {
                return [SeasonClothTypeInfo seasonWithType:springSeasonClothType];
            }
            if ([today isSummer])
            {
                return [SeasonClothTypeInfo seasonWithType:summerSeasonClothType];
            }
            if ([today isWinter])
            {
                return [SeasonClothTypeInfo seasonWithType:winterSeasonClothType];
            }
            if ([today isAutumn])
            {
                return [SeasonClothTypeInfo seasonWithType:fallSeasonClothType];
            }

            break;
        }
        case filterMeteoOptionTomorrow:
        {
            NSDate *today = [NSDate addDaysToDate:[NSDate date] days:1];
            if ([today isSpring])
            {
                return [SeasonClothTypeInfo seasonWithType:springSeasonClothType];
            }
            if ([today isSummer])
            {
                return [SeasonClothTypeInfo seasonWithType:summerSeasonClothType];
            }
            if ([today isWinter])
            {
                return [SeasonClothTypeInfo seasonWithType:winterSeasonClothType];
            }
            if ([today isAutumn])
            {
                return [SeasonClothTypeInfo seasonWithType:fallSeasonClothType];
            }
            break;
        }
        case filterMeteoOptionManual:
        {
            return nil;
            break;
        }
            
        default:
            return nil;
            break;
    }
    return nil;
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

- (void)clothTypeChoosed:(ClothType *)clothType
{
    if ([clothType isKindOfClass:[EventClothTypeInfo class]])
    {
        _filter2TopContraint.constant = - _seasonFiltersView.height;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    if ([clothType isKindOfClass:[ColorClothTypeInfo class]] && [self numOfColorTypeInTagsView] >=3)
    {
        _filter3TopConstraint.constant = - _eventFiltersView.height;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    if ([clothType isKindOfClass:[SeasonClothTypeInfo class]])
    {
        _filter1TopConstraint.constant = - _tagsPlaceHolder.height;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}

- (void)clothTypeRemoved:(ClothType *)clothType
{
    if ([clothType isKindOfClass:[EventClothTypeInfo class]])
    {
        _filter2TopContraint.constant = 0;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    if ([clothType isKindOfClass:[ColorClothTypeInfo class]])
    {
        _filter3TopConstraint.constant = 0;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
    if ([clothType isKindOfClass:[SeasonClothTypeInfo class]])
    {
        _filter1TopConstraint.constant = 0;
        [UIView animateWithDuration:0.4 animations:^{
            [self.view layoutIfNeeded];
        }];
    }
}


/* UIFilterItemView Delegates */

- (void)filterItemViewClicked:(UIFilterItemView *)filterItemView
{
    if ([[_tagsView clothTypeTags] containsObject:filterItemView.clothType])
    {
        return;
    }
    [_tagsView addClothType:filterItemView.clothType];
    
    [self clothTypeChoosed:filterItemView.clothType];
    
    [self reloadData];

    [self layoutData];
}

/* End UIFilterItemView Delegates */

/* UITagsView Delegates */

- (void)tagsView:(UITagsView *)tagView didDeleteTag:(UIBubbleContactItemView *)bubbleItemTag withClothTypeInfo:(ClothType *)clothTypeInfo
{
    [self clothTypeRemoved:clothTypeInfo];
    
    [self reloadData];
    
    [self layoutData];
}

/* End UITagsView Delegates */

- (IBAction)filterOptionChanged:(UISegmentedControl *)sender
{
    [_tagsView removeAllTabs];
    
    ClothType *clothTypeForFilterOptionRemoved = [self clothTypeForFilterOption:[FilterLogic sharedInstance].accordingFilterByMeteo];
    if (clothTypeForFilterOptionRemoved)
    {
        [self clothTypeRemoved:clothTypeForFilterOptionRemoved];
    }
    
    [FilterLogic sharedInstance].accordingFilterByMeteo = _segmentedControl.selectedSegmentIndex;
    
    ClothType *clothTypeForFilterOption = [self clothTypeForFilterOption:[FilterLogic sharedInstance].accordingFilterByMeteo];
    if (clothTypeForFilterOption)
    {
        [self clothTypeChoosed:clothTypeForFilterOption];
    }
    
    [self reloadData];
    
    [self layoutData];
}

@end
