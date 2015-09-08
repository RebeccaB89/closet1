//
//  SeasonClothTypeInfo.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "SeasonClothTypeInfo.h"

@implementation SeasonClothTypeInfo

+ (SeasonClothTypeInfo *)seasonWithType:(SeasonClothType)seasonClothType
{
    SeasonClothTypeInfo *seasonInfo = [[SeasonClothTypeInfo alloc] init];
    seasonInfo.seasonType = seasonClothType;
    
    return seasonInfo;
}

+ (NSArray *)allClothType
{
    return [NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:winterSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType], [SeasonClothTypeInfo seasonWithType:springSeasonClothType], nil];
}

+ (NSString *)clothTypeStr
{
    return @"Season";
}

- (UIColor *)color
{
    switch (self.seasonType)
    {
        case summerSeasonClothType:
            return [UIColor yellowColor];
            break;
        case winterSeasonClothType:
            return [UIColor grayColor];
            break;
        case springSeasonClothType:
            return [UIColor greenColor];
            break;
        case fallSeasonClothType:
            return [UIColor brownColor];
            break;
            
        default:
            return [UIColor yellowColor];
    }
}

- (NSString *)strType
{
    switch (self.seasonType)
    {
        case summerSeasonClothType:
            return NLS(@"Summer");
            break;
        case winterSeasonClothType:
            return NLS(@"Winter");
            break;
        case springSeasonClothType:
            return NLS(@"Spring");
            break;
        case fallSeasonClothType:
            return NLS(@"fall");
            break;
            
        default:
            return NLS(@"Summer");
    }
}

@end
