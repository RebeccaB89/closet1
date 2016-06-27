//
//  UICategoriesChooserScrollView.m
//  base
//
//  Created by rebecca biaz on 11/12/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UICategoriesChooserScrollView.h"
#import "UICategoryChooserView.h"
#import "FilterLogic.h"

@implementation UICategoriesChooserScrollView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;

    [_previousButton setTitle:NLS(@"previous") forState:UIControlStateNormal];
    
    [_nextButton setTitle:NLS(@"next") forState:UIControlStateNormal];
}

- (void)updateClothInfo
{
    for (UIView *subview in _scrollView.subviews)
    {
        if ([subview isKindOfClass:[UICategoryChooserView class]])
        {
            UICategoryChooserView *categoryChooserView = (UICategoryChooserView *)subview;
            NSArray *newSelectedTypes = categoryChooserView.selectedTypes;

            if ([categoryChooserView.clothType class] == [ItemClothTypeInfo class])
            {
                if ([newSelectedTypes firstObject])
                {
                    _clothInfo.itemTypeInfo = [newSelectedTypes firstObject];
                }
            }
            if ([categoryChooserView.clothType class] == [SeasonClothTypeInfo class])
            {
                if (newSelectedTypes)
                {
                    _clothInfo.seasonTypeInfos = newSelectedTypes;
                }
            }
            if ([categoryChooserView.clothType class] == [EventClothTypeInfo class])
            {
                if (newSelectedTypes)
                {
                    _clothInfo.eventTypeInfos = newSelectedTypes;
                }
            }
            if ([categoryChooserView.clothType class] == [ColorClothTypeInfo class])
            {
                if (newSelectedTypes)
                {
                    _clothInfo.colorTypeInfos = newSelectedTypes;
                }
            }            
        }
    }
}

- (void)setClothInfo:(Cloth *)clothInfo
{
    _clothInfo = clothInfo;
    
    [self layoutData];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _scrollView.contentSize = CGSizeMake(_scrollView.width * _pageControl.numberOfPages, _scrollView.height);
}

- (void)layoutData
{
    NSArray *subViews = _scrollView.subviews;
    for (UIView *subView in subViews)
    {
        [subView removeFromSuperview];
    }
    
    if (_clothInfo)
    {
        int i = 0;
        
        NSArray *allClothTypes = [[FilterLogic sharedInstance] allClothTypeClass];
        
        for (Class clothTypeClass in allClothTypes)
        {
            UICategoryChooserView *categoryChooserVier = [self categoryChooserView:clothTypeClass];
            categoryChooserVier.frame = _scrollView.bounds;
            categoryChooserVier.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
            categoryChooserVier.left = i;
            i = i + categoryChooserVier.width;
            [categoryChooserVier setSelectedTypes:[_clothInfo clothtypesForClass:clothTypeClass]];
            [_scrollView addSubview:categoryChooserVier];
        }
            
        _scrollView.contentSize = CGSizeMake(i, _scrollView.height);
        _pageControl.numberOfPages = _scrollView.subviews.count;
    }
    
    [self layoutButtons];
}

- (void)layoutButtons
{
    _previousButton.hidden = NO;
    _nextButton.hidden = NO;

    if (_pageControl.currentPage == _pageControl.numberOfPages - 1)
    {
        _nextButton.hidden = YES;
    }
    if (_pageControl.currentPage == 0)
    {
        _previousButton.hidden = YES;
    }
}

- (UICategoryChooserView *)categoryChooserView:(Class)clothTypeInfo
{
    UICategoryChooserView *categoryChooserView = [UICategoryChooserView loadFromNib];
    categoryChooserView.clothType = [clothTypeInfo new];
    
    return categoryChooserView;
}

- (IBAction)previousClicked:(id)sender
{
    _pageControl.currentPage --;
    if (_pageControl.currentPage < 0)
    {
        _pageControl.currentPage = 0;
    }
    _scrollView.contentOffset = CGPointMake(_pageControl.currentPage * _scrollView.width, 0);
    
    [self layoutButtons];
}

- (IBAction)nextButton:(UIButton *)sender
{
    _pageControl.currentPage ++;
    if (_pageControl.currentPage >= _pageControl.numberOfPages)
    {
        _pageControl.currentPage = _pageControl.numberOfPages -1;
    }
    _scrollView.contentOffset = CGPointMake(_pageControl.currentPage * _scrollView.width, 0);
    
    [self layoutButtons];
}

/* UIScrollView delegates */

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // _testOptionsView.testOptionType = testOptionTypeStop;
    
    CGFloat pageWidth = scrollView.width;
    int page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    _pageControl.currentPage = page;
    
    [self layoutButtons];
}
/* End UIScrollView delegates */

@end
