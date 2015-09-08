//
//  ClothTypeHelper.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ClothTypeHelper.h"

@implementation ClothTypeHelper

+ (NSArray *)seasonClothTypes
{
    NSMutableArray *seasons = [NSMutableArray array];

    for (int i = summerSeasonClothType; i <= springSeasonClothType; i++)
    {
        [seasons addObject:[SeasonClothTypeInfo seasonWithType:i]];
    }
    
    return seasons;
}

+ (NSArray *)colorClothTypes
{
    NSMutableArray *seasons = [NSMutableArray array];
    
    for (int i = blackColorClothType; i <= multiColorColorClothType; i++)
    {
        [seasons addObject:[ColorClothTypeInfo colorWithType:i]];
    }
    
    return seasons;
}

+ (NSArray *)eventClothTypes
{
    NSMutableArray *events = [NSMutableArray array];
    
    for (int i = workEventClothType; i <= interviewEventClothType; i++)
    {
        [events addObject:[EventClothTypeInfo eventWithType:i]];
    }
    
    return events;
}

@end
