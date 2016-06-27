//
//  SeasonClothTypeInfo.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "SeasonClothTypeInfo.h"

#import "NSDate+Weather.h"

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

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.seasonType = [aDecoder decodeIntForKey:@"seasonType"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInt:_seasonType forKey:@"seasonType"];
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

+ (NSString *)questionChooser
{
    return @"Season";
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

- (BOOL)isGoodForDate:(NSDate *)date withDegree:(CGFloat)degree
{
    [date isSummer];
    [date isSpring];
    [date isAutumn];
    [date isWinter];
    
    [date isDay];
    [date isNight];
    
    [date hourOfDate];

    switch (self.seasonType)
    {
        case summerSeasonClothType:
        {
            if ([date isSummer])
            {
                return YES;
            }
            if ([date isWinter])
            {
                return NO;
            }
            if ([date isSpring])
            {
                if ([date isDay] && degree >= 22)
                {
                    return YES;
                }
                if ([date isNight] && degree >= 18)
                {
                    return YES;
                }
            }
            if ([date isAutumn])
            {
                if ([date isDay] && degree >= 25)
                {
                    return YES;
                }
                if ([date isNight] && degree >= 19)
                {
                    return YES;
                }
            }
            break;
        }
        case winterSeasonClothType:
        {
            if ([date isSummer])
            {
                return NO;
            }
            if ([date isWinter])
            {
                return YES;
            }
            if ([date isSpring])
            {
                if ([date isDay] && degree <= 15)
                {
                    return YES;
                }
                if ([date isNight] && degree <= 14)
                {
                    return YES;
                }
            }
            if ([date isAutumn])
            {
                if ([date isDay] && degree <= 15)
                {
                    return YES;
                }
                if ([date isNight] && degree <= 13)
                {
                    return YES;
                }
            }
            break;
        }
        case springSeasonClothType:
        {
            if ([date isAutumn])
            {
                return NO;
            }
            if ([date isSpring])
            {
                return YES;
            }
            if ([date isWinter])
            {
                if ([date isDay] && degree > 16)
                {
                    return YES;
                }
                if ([date isNight] && degree > 13)
                {
                    return YES;
                }
            }
            if ([date isSummer])
            {
                if ([date isDay] && degree <= 21)
                {
                    return YES;
                }
                if ([date isNight] && degree <= 17)
                {
                    return YES;
                }
            }
            
            break;
        }
        case fallSeasonClothType:
        {
            if ([date isSpring])
            {
                return NO;
            }
            if ([date isAutumn])
            {
                return YES;
            }
            if ([date isWinter])
            {
                if ([date isDay] && degree > 18)
                {
                    return YES;
                }
                if ([date isNight] && degree > 12)
                {
                    return YES;
                }
            }
            if ([date isSummer])
            {
                if ([date isDay] && degree <= 24)
                {
                    return YES;
                }
                if ([date isNight] && degree <= 19)
                {
                    return YES;
                }
            }
            break;

        }
        default:
        {
            return NO;
            break;
        }
    }
    
    return NO;
}

@end
