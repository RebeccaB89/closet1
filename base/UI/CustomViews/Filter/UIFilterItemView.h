//
//  UIFilterItemView.h
//  base
//
//  Created by Rebecca Biaz on 6/21/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClothType.h"

@class UIFilterItemView;

@protocol UIFilterItemViewDelegate <NSObject>

- (void)filterItemViewClicked:(UIFilterItemView *)filterItemView;

@end

@interface UIFilterItemView : UIView
{
    __weak IBOutlet UIImageView *_imageView;
    
    __weak IBOutlet UILabel *_titleLabel;
}

- (IBAction)filterClicked:(UIButton *)sender;

@property (nonatomic, strong) ClothType *clothType;
@property (nonatomic, weak) id<UIFilterItemViewDelegate> delegate;

@end
