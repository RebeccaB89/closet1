//
//  SeasonClothTypeInfo.h
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ClothType.h"

typedef enum : NSUInteger
{
    summerSeasonClothType,
    winterSeasonClothType,
    fallSeasonClothType,
    springSeasonClothType
} SeasonClothType;

@interface SeasonClothTypeInfo : ClothType

+ (SeasonClothTypeInfo *)seasonWithType:(SeasonClothType)seasonClothType;
@property (nonatomic, unsafe_unretained) SeasonClothType seasonType;

@end
