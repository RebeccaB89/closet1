//
//  UITagsView.h
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIBubbleContactView.h"
#import "ClothType.h"

#define BUBBLE_HEIGHT 25

@class UITagsView;

@protocol UITagsViewDelegate <NSObject>

- (void)tagsView:(UITagsView *)tagView didDeleteTag:(UIBubbleContactItemView *)bubbleItemTag withClothTypeInfo:(ClothType *)clothTypeInfo;

@end

@interface UITagsView : UIView <HEBubbleViewDataSource, HEBubbleViewDelegate, HEBubbleViewItemDelegate, HEBubbleViewItemDelegate, UIBubbleContactViewDelegate>
{
    __weak IBOutlet UIView *_tagsPlaceHolder;
    
    NSMutableArray *_clothTypeTags;
    
    UIBubbleContactView *_bubbleContactView;
}

- (void)addClothType:(ClothType *)clothType;
- (void)removeAllTabs;
- (NSArray *)clothTypeTags;

@property (nonatomic, weak) id<UITagsViewDelegate> delegate;

@end
