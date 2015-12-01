//
//  UIClothDresserView.m
//  base
//
//  Created by rebecca biaz on 7/12/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "UIClothDresserView.h"

@implementation UIClothDresserView

- (void)setClothInfo:(Cloth *)clothInfo
{
    _clothInfo = clothInfo;
    [self layoutData];
}

- (void)layoutData
{
    _imageView.image = _clothInfo.image;
}

@end
