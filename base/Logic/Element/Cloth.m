//
//  Cloth.m
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Cloth.h"

@implementation Cloth

+ (Cloth *)clothWithImagePath:(NSString *)imagePath withSeason:(SeasonClothTypeInfo *)season withEvent:(EventClothTypeInfo *)event withColor:(ColorClothTypeInfo *)color withItemInfo:(ItemClothTypeInfo *)itemInfo
{
    Cloth *cloth = [[Cloth alloc] init];
    
    cloth.imagePath = imagePath;
    cloth.seasonTypeInfo = season;
    cloth.eventTypeInfo = event;
    cloth.colorTypeInfo = color;
    cloth.itemTypeInfo = itemInfo;
    
    return cloth;
}

@end
