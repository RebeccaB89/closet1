//
//  UITagsView.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UITagsView.h"

@interface UITagsView()

- (void)notifyDidDeleteTag:(UIBubbleContactItemView *)bubbleItemTag withClothTypeInfo:(ClothType *)clothTypeInfo;

@end

@implementation UITagsView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    //Set up the bubbleView
    _bubbleContactView = (UIBubbleContactView *)[UIBubbleContactView loadFromNib];
    _bubbleContactView.bubbleDataSource = self;
    _bubbleContactView.bubbleDelegate = self;
    _bubbleContactView.delegateBubbleContactView = self;
    //_bubbleContactView.titleInfoText = NLS(@"Filter: ");
    //_bubbleContactView.alwaysBounceVertical = NO;
    _bubbleContactView.selectionStyle = HEBubbleViewSelectionStyleDefault;
    _bubbleContactView.itemHeight = BUBBLE_HEIGHT;
    _bubbleContactView.rightPaddingImage = [UIBubbleContactItemView widthPaddingImage];

    _bubbleContactView.frame = _tagsPlaceHolder.bounds;
    _bubbleContactView.autoresizingMask = CELL_FULL_AUTORESIZINGMASK;
    [_tagsPlaceHolder addSubview:_bubbleContactView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    [_bubbleContactView reloadData];
}

- (void)addClothType:(ClothType *)clothType
{
    if (!clothType)
    {
        return;
    }
    
    if (!_clothTypeTags)
    {
        _clothTypeTags = [NSMutableArray array];
    }
    
    [_clothTypeTags addObject:clothType];
    
    [self layoutData];
}

- (void)layoutData
{
    NSMutableArray *tagsStrs = [NSMutableArray array];
    for (ClothType *clothInfo in _clothTypeTags)
    {
        [tagsStrs addObject:[clothInfo strType]];
    }
    
    [_bubbleContactView reloadData];
}

- (NSArray *)clothTypeTags
{
    return _clothTypeTags;
}

- (void)deleteSelectedBubbleAtIndex:(NSInteger)index
{
    [_clothTypeTags removeObjectAtIndex:index];
    UIBubbleContactItemView *bubbleItem = (UIBubbleContactItemView *)[_bubbleContactView removeItemAtIndex:index animated:YES];
    [self notifyDidDeleteTag:bubbleItem withClothTypeInfo:bubbleItem.clothTypeInfo];
}

- (void)notifyDidDeleteTag:(UIBubbleContactItemView *)bubbleItemTag withClothTypeInfo:(ClothType *)clothTypeInfo
{
    if ([self.delegate respondsToSelector:@selector(tagsView:didDeleteTag:withClothTypeInfo:)])
    {
        [_delegate tagsView:self didDeleteTag:bubbleItemTag withClothTypeInfo:clothTypeInfo];
    }
}

/* UIBubbleContactView Delegates */

- (void)bubbleView:(UIBubbleContactView *)bubbleContactView didDeleteButtonPressedatIndex:(NSUInteger)index
{
    [self deleteSelectedBubbleAtIndex:index];
}

-(NSInteger)numberOfItemsInBubbleView:(UIBubbleContactView *)bubbleView
{
    return [_clothTypeTags count];
}

- (void)selectedBubbleItem:(HEBubbleViewItem *)item
{
    
}

- (UIBubbleContactItemView *)bubbleView:(UIBubbleContactView *)bubbleViewIN bubbleItemForIndex:(NSInteger)index
{
    NSString *itemIdentifier = BUBBLE_ITEM_REUSEIDENTIFIER;
    
    UIBubbleContactItemView *item = (UIBubbleContactItemView *)[_bubbleContactView dequeueItemUsingReuseIdentifier:itemIdentifier];
    
    if (item == nil)
    {
        item = (UIBubbleContactItemView *)[UIBubbleContactItemView loadFromNib];
        item.delegateBubbleContact = _bubbleContactView;
    }
    
    ClothType *member = [_clothTypeTags objectAtIndex:index];
    item.clothTypeInfo = member;
    
    return item;
}

// called when a bubble gets selected
-(void)bubbleView:(UIBubbleContactView *)bubbleView didSelectBubbleItemAtIndex:(NSInteger)index
{
    
}

// returns wheter to show a menu callout or not for a given index
-(BOOL)bubbleView:(UIBubbleContactView *)bubbleView shouldShowMenuForBubbleItemAtIndex:(NSInteger)index
{
    return YES;
}

/* ////////////////////////////////////////////////////////////////////////////////////////////////////
 
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 !!!!! Always override canBecomeFirstResponder and return YES, otherwise the menu is not shown !!!!!!
 !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
 
 * //////////////////////////////////////////////////////////////////////////////////////////////////// */

-(BOOL)canBecomeFirstResponder
{
    return YES;
}

/* End */

@end
