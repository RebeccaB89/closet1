//
//  ItemClothType.h
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ClothType.h"

typedef enum : NSUInteger
{
    teeShirtItemClothType,
    pantItemClothType,
    skirtItemClothType,
    accessoryItemClothType
} ItemClothType;

@interface ItemClothTypeInfo : ClothType

+ (ItemClothTypeInfo *)itemClothWithType:(ItemClothType)itemClothType;

@property (nonatomic, unsafe_unretained) ItemClothType itemType;

@end
