//
//  Cloth.h
//  base
//
//  Created by Rebecca Biaz on 6/17/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "Element.h"
#import "ClothTypeHelper.h"
#import "ItemClothTypeInfo.h"
#import "ColorClothTypeInfo.h"
#import "EventClothTypeInfo.h"
#import "SeasonClothTypeInfo.h"

@interface Cloth : Element

@property (nonatomic, strong) NSString *imagePath;

@property (nonatomic, strong) SeasonClothTypeInfo *seasonTypeInfo;
@property (nonatomic, strong) EventClothTypeInfo *eventTypeInfo;
@property (nonatomic, strong) ColorClothTypeInfo *colorTypeInfo;
@property (nonatomic, strong) ItemClothTypeInfo *itemTypeInfo;

+ (Cloth *)clothWithImagePath:(NSString *)imagePath withSeason:(SeasonClothTypeInfo *)season withEvent:(EventClothTypeInfo *)event withColor:(ColorClothTypeInfo *)color withItemInfo:(ItemClothTypeInfo *)itemInfo;

@end
