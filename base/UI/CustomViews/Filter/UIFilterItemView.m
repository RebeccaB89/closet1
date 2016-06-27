//
//  UIFilterItemView.m
//  base
//
//  Created by Rebecca Biaz on 6/21/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIFilterItemView.h"

@interface UIFilterItemView()

- (void)notifyFilterItemViewClicked;

@end

@implementation UIFilterItemView

- (void)layoutData
{
    if (_clothType)
    {
        _imageView.image = _clothType.image;
        if (!_imageView.image)
        {
            self.backgroundColor = _clothType.color;
            _titleLabel.textColor = _clothType.textColor;
            
        }
        else
        {
            self.backgroundColor = [UIColor clearColor];
            _titleLabel.textColor = [UIColor blackColor];

        }
        _titleLabel.text = _clothType.strType;
    }
    else
    {
        _imageView.image = nil;
        _titleLabel.text = NLS(@"Type");
        self.backgroundColor = [UIColor clearColor];
    }
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
}

- (void)setClothType:(ClothType *)clothType
{
    _clothType = clothType;
    
    [self layoutData];
}

- (void)notifyFilterItemViewClicked
{
    if ([self.delegate respondsToSelector:@selector(filterItemViewClicked:)])
    {
        [_delegate filterItemViewClicked:self];
    }
}

- (IBAction)filterClicked:(UIButton *)sender
{
    [self notifyFilterItemViewClicked];
}

@end
