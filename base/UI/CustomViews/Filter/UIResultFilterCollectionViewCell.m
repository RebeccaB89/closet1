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
    
}

@end
