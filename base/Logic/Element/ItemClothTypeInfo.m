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

+ (NSArray *)allClothType
{
    return [NSArray arrayWithObjects:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType], [ItemClothTypeInfo itemClothWithType:pantItemClothType], [ItemClothTypeInfo itemClothWithType:skirtItemClothType], [ItemClothTypeInfo itemClothWithType:accessoryItemClothType], nil];
}

+ (NSString *)clothTypeStr
{
    return @"Item";
}

+ (NSString *)keyForUpItem
{
    return NLS(@"UP");
}

+ (NSString *)keyForBottomItem
{
    return NLS(@"BOTTOM");
}

+ (NSString *)keyForAccessoryItem
{
    return NLS(@"Accessory");
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.itemType = [aDecoder decodeIntForKey:@"itemType"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInt:_itemType forKey:@"itemType"];
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

- (BOOL)canMultipleSelection
{
    return NO;
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

+ (NSString *)questionChooser
{
    return @"item cloth?";
}

- (BOOL)isUPItem
{
    if (self.itemType == teeShirtItemClothType )
    {
        return YES;
    }
    return NO;
}

- (BOOL)isBottomItem
{
    if (self.itemType == pantItemClothType || self.itemType == skirtItemClothType)
    {
        return YES;
    }
    return NO;
}

- (BOOL)isAccessoryItem
{
    if (self.itemType == accessoryItemClothType )
    {
        return YES;
    }
    return NO;
}

- (NSString *)keyItemTypeStr
{
    switch (self.itemType)
    {
        case teeShirtItemClothType:
            return [ItemClothTypeInfo keyForUpItem];
            break;
        case pantItemClothType:
            return [ItemClothTypeInfo keyForBottomItem];
            break;
        case skirtItemClothType:
            return [ItemClothTypeInfo keyForBottomItem];
            break;
        case accessoryItemClothType:
            return [ItemClothTypeInfo keyForAccessoryItem];
            break;
        default:
            return @"";
    }
}

@end
