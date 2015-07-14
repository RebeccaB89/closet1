//
//  ItemClothType.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ItemClothTypeInfo.h"

@implementation ItemClothTypeInfo

+ (ItemClothTypeInfo *)itemClothWithType:(ItemClothType)itemClothType
{
    ItemClothTypeInfo *itemInfo = [[ItemClothTypeInfo alloc] init];
    itemInfo.itemType = itemClothType;
    
    return itemInfo;
}

- (UIColor *)color
{
    switch (self.itemType)
    {
        case teeShirtItemClothType:
            return [UIColor cyanColor];
            break;
        case pantItemClothType:
            return [UIColor blueColor];
            break;
        case skirtItemClothType:
            return [UIColor magentaColor];
            break;
        case accessoryItemClothType:
            return [UIColor orangeColor];
            break;
        default:
            return [UIColor yellowColor];
    }
}

- (NSString *)strType
{
    switch (self.itemType)
    {
        case teeShirtItemClothType:
            return NLS(@"Tee Shirt");
            break;
        case pantItemClothType:
            return NLS(@"Pant");
            break;
        case skirtItemClothType:
            return NLS(@"Skirt");
            break;
        case accessoryItemClothType:
            return NLS(@"Accessory");
            break;
        default:
            return @"";
    }
}

@end
