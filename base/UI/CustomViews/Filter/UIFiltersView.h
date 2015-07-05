//
//  UIFiltersView.h
//  base
//
//  Created by Rebecca Biaz on 6/21/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClothType.h"
#import "UIFilterItemView.h"

@interface UIFiltersView : UIView
{
    __weak IBOutlet UIScrollView *_filterScrollView;
}

@property (nonatomic, strong) NSArray *clothTypeFilters;
@property (nonatomic, weak) id<UIFilterItemViewDelegate> delegateFilterItem;

@end
