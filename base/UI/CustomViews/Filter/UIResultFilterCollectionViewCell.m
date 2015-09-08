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
        UIImage *upImage = IMAGE(_costumeResultInfo.upClothInfo.imagePath);
        _upImageView.image = upImage;
        UIImage *bottomImage = IMAGE(_costumeResultInfo.bottomClothInfo.imagePath);
        _bottomImageView.image = bottomImage;
    }
    else
    {
        _upImageView.image = nil;
        _bottomImageView.image = nil;
    }
}

@end
