//
//  ColorClothTypeInfo.h
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ClothType.h"

typedef enum : NSUInteger {
    blackColorClothType,
    whiteColorClothType,
    redColorClothType,
    blueColorClothType,
    pinkColorClothType,
    purpleColorClothType,
    orangeColorClothType,
    multiColorColorClothType
} ColorClothType;

@interface ColorClothTypeInfo : ClothType

+ (ColorClothTypeInfo *)colorWithType:(ColorClothType)colorClothType;


@property (nonatomic, unsafe_unretained) ColorClothType colorType;

@end
