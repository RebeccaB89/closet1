//
//  FilterLogic.m
//  base
//
//  Created by rebecca biaz on 7/16/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "FilterLogic.h"
#import "LocationLogic.h"

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
    }
    
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
