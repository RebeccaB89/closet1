//
//  FilterLogic.m
//  base
//
//  Created by rebecca biaz on 7/16/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FilterLogic.h"
#import "LocationLogic.h"
#import "WeatherLogic.h"
#import "UserInfoLogic.h"
#import "NSDate-Expanded.h"

@implementation FilterLogic

static FilterLogic *sharedInstance = nil;

+ (FilterLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [[self alloc] init];
        }
    }
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        _accordingFilterByMeteo = YES;
        _accordingFilterByColorScheme = NO;
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (NSArray *)clothsForClothTypeFilters:(NSArray *)filters
{
    NSMutableArray *result = [NSMutableArray array];
    
    if (filters.count == 0)
    {
        return result;
    }
    
    NSMutableArray *clothToRemove = [NSMutableArray array];
    NSMutableArray *clothToAdd = [NSMutableArray array];
    
    NSArray *filterColor = filters;
    
    __block NSInteger foundIndex = NSNotFound;
    [filters enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if ([obj isKindOfClass:[ColorClothTypeInfo class]])
        {
            foundIndex = idx;
            // stop the enumeration
            *stop = YES;
        }
    }];
    
    if (foundIndex == NSNotFound)
    {
        filterColor = [[FilterLogic sharedInstance] allItemsForClothType:[ColorClothTypeInfo class]];
    }
    
    for (ClothType *clothType in filterColor)
    {
        if ([clothType isKindOfClass:[ColorClothTypeInfo class]])
        {
            NSMutableArray *clothForKeyClothType = [[[InfoLogic sharedInstance] filters] objectForKey:clothType.strType];
            if (clothForKeyClothType)
            {
                [result addObjectsFromArray:clothForKeyClothType];
            }
        }
    }
    
    for (ClothType *clothType in filters)
    {
        if ([clothType isKindOfClass:[ColorClothTypeInfo class]])
        {
            continue;
        }
        
        NSMutableArray *clothForKeyClothType = [[[InfoLogic sharedInstance] filters] objectForKey:clothType.strType];
        
        for (Cloth *cloth in result)
        {
            if (![clothForKeyClothType containsObject:cloth])
            {
                [clothToRemove addObject:cloth];
            }
        }
    }
    
    [result removeObjectsInArray:clothToRemove];
    [result addObjectsFromArray:clothToAdd];
    
    result = [self clothsAccordingFilterByMeteo:result];
    
    return result;
}

- (NSMutableArray *)clothsAccordingFilterByMeteo:(NSMutableArray *)cloths
{
    if (!self.accordingFilterByMeteo)
    {
        return cloths;
    }
    
    Weather *weather = [[WeatherLogic sharedInstance] currentWeather];
    NSDate *date;// = [NSDate date];
    CGFloat degree = 0;
    if ([[UserInfoLogic sharedInstance] filterDateType] == tomorrowFilterDataType)
    {
        date = [NSDate addDaysToDate:[NSDate date] days:1];
        degree = weather.cDegreesTomorrow;
    }
    else
    {
        date = [NSDate date];
        degree = weather.cDegrees;
    }
    
    NSMutableArray *clothToRemove = [NSMutableArray array];
    for (Cloth *cloth in cloths)
    {
        BOOL goodCloth = NO;
        for (SeasonClothTypeInfo *season in cloth.seasonTypeInfos)
        {
            if ([season isGoodForDate:date withDegree:degree])
            {
                goodCloth = YES;
                break;
            }
        }
        
        if (!goodCloth)
        {
            [clothToRemove addObject:cloth];
        }
    }
    
    [cloths removeObjectsInArray:clothToRemove];
    
    return cloths;
}

- (NSArray *)clothsAccordingFilterByColorScheme:(NSArray *)cloths
{
    if (!self.accordingFilterByColorScheme)
    {
        return cloths;
    }
    
    return cloths;
}

- (NSDictionary *)clothsFiteredByItemType:(NSArray *)clothsFiltered
{
    NSMutableDictionary *results = [NSMutableDictionary dictionary];
    
    for (Cloth *cloth in clothsFiltered)
    {
        NSMutableArray *tempCloth = [results objectForKey:cloth.itemTypeInfo.keyItemTypeStr];
        if (!tempCloth)
        {
            tempCloth = [NSMutableArray array];
        }
        [tempCloth addObject:cloth];
        [results setObject:tempCloth forKey:cloth.itemTypeInfo.keyItemTypeStr];
    }
    
    return results;
}

- (NSDictionary *)clothTypes
{
    NSArray *allClothTypes = [self allClothTypeClass];
    NSMutableDictionary *clothTypes = [NSMutableDictionary dictionary];
    
    for (Class clothTypeClass in allClothTypes)
    {
        NSString *clothTypeClassStr = [clothTypeClass clothTypeStr];
        NSArray *allClothTypeForClass = [self allItemsForClothType:clothTypeClass];
        
        [clothTypes setObject:allClothTypeForClass forKey:clothTypeClassStr];
    }
    
    return clothTypes;
}

- (NSArray *)allClothTypeClass
{
    return [NSArray arrayWithObjects:[ItemClothTypeInfo class], [ColorClothTypeInfo class], [SeasonClothTypeInfo class], [EventClothTypeInfo class],nil];
}

- (NSArray *)allItemsForClothType:(Class)clothTypeclass
{
    return [clothTypeclass allClothType];
}

@end
