//
//  UIResultFilterCollectionViewCell.m
//  base
//
//  Created by rebecca biaz on 7/12/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIResultFilterCollectionViewCell.h"

@implementation UIResultFilterCollectionViewCell

- (void)awakeFromNib
{
    // Initialization code
    
    self.layer.borderWidth = 3.0;
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
}

- (void)setCostumeResultInfo:(CostumeResultsInfo *)costumeResultInfo
{
    _costumeResultInfo = costumeResultInfo;
    
    [self layoutData];
}

- (void)layoutData
{
    if (_costumeResultInfo)
    {
        UIImage *upImage = _costumeResultInfo.upClothInfo.image;
        _upImageView.image = upImage;
        UIImage *bottomImage = _costumeResultInfo.bottomClothInfo.image;
        _bottomImageView.image = bottomImage;
    }
    else
    {
        _upImageView.image = nil;
        _bottomImageView.image = nil;
    }
}

@end
