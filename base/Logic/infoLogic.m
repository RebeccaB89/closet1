//
//  infoLogic.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "infoLogic.h"
#import "FilterLogic.h"

@implementation InfoLogic

static InfoLogic *sharedInstance = nil;

+ (InfoLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            sharedInstance = [InfoLogic load];
            if (sharedInstance == nil)
            {
                sharedInstance = [[self alloc] init];
            }
        }
    }
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [self initialize:nil];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_pants forKey:@"pants"];
    [aCoder encodeObject:_skirts forKey:@"skirts"];
    [aCoder encodeObject:_teeShirts forKey:@"teeShirts"];
    [aCoder encodeObject:_accessory forKey:@"accessory"];
    [aCoder encodeObject:_favorites forKey:@"favorites"];

}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        _pants = [aDecoder decodeObjectForKey:@"pants"];
        _skirts = [aDecoder decodeObjectForKey:@"skirts"];
        _teeShirts = [aDecoder decodeObjectForKey:@"teeShirts"];
        _accessory = [aDecoder decodeObjectForKey:@"accessory"];
        _favorites = [aDecoder decodeObjectForKey:@"favorites"];

        [self initialize:aDecoder];
    }
    return self;
}


- (void)initialize:(NSCoder *)aDecoder
{
    if (!_pants)
    {
        _pants = [NSMutableArray array];
    }
    if (!_skirts)
    {
        _skirts = [NSMutableArray array];
    }
    if (!_teeShirts)
    {
        _teeShirts = [NSMutableArray array];
    }
    if (!_accessory)
    {
        _accessory = [NSMutableArray array];
    }
    
    if (!_favorites)
    {
        _favorites = [NSMutableArray array];
    }
    
    [self loadDataHardCodedIfNeeded];

    for (Cloth *cloth in _pants)
    {
        cloth.delegate = self;
    }
    for (Cloth *cloth in _skirts)
    {
        cloth.delegate = self;
    }
    for (Cloth *cloth in _teeShirts)
    {
        cloth.delegate = self;
    }
    for (Cloth *cloth in _accessory)
    {
        cloth.delegate = self;
    }
    [self save];
    
    [self updateFilterCloths];
}

- (void)loadDataHardCodedIfNeeded
{
    [self loadPantsHardCodedIfNeeded];
    [self loadSkirtsHardCodedIfNeeded];
    [self loadTeeShirtsHardCodedIfNeeded];
    [self loadAccesorysHardCodedIfNeeded];
}

- (void)loadPantsHardCodedIfNeeded
{
    if (_pants.count == 0)
    {
        Cloth *pant11 = [Cloth clothWithImagePath:@"pant1" withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:winterSeasonClothType] , [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType], nil]
                                       withEvents:[NSArray arrayWithObjects: [EventClothTypeInfo eventWithType:workEventClothType],  [EventClothTypeInfo eventWithType:dateEventClothType],  [EventClothTypeInfo eventWithType:interviewEventClothType], nil]
                                       withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:blueColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:pantItemClothType]];
        pant11.delegate = self;
        [self addToArray:_pants cloth:pant11];
        
        Cloth *pant2 = [Cloth clothWithImagePath:@"pant2" withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:winterSeasonClothType] , [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType], nil]
                                       withEvents:[NSArray arrayWithObjects: [EventClothTypeInfo eventWithType:workEventClothType],  [EventClothTypeInfo eventWithType:dateEventClothType],  [EventClothTypeInfo eventWithType:interviewEventClothType], nil]
                                       withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:redColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:pantItemClothType]];
        pant2.delegate = self;

        [self addToArray:_pants cloth:pant2];

        Cloth *pant3 = [Cloth clothWithImagePath:@"pant3"
                                      withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType], nil]
                                       withEvents:[NSArray arrayWithObjects: [EventClothTypeInfo eventWithType:workEventClothType],  [EventClothTypeInfo eventWithType:dateEventClothType], nil]
                                       withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:pinkColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:pantItemClothType]];
        pant3.delegate = self;

        [self addToArray:_pants cloth:pant3];
    }
}

- (void)loadSkirtsHardCodedIfNeeded
{
    if (_skirts.count == 0)
    {
        Cloth *skirt1 = [Cloth clothWithImagePath:@"skirt1"
                                     withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], nil]
                                       withEvents:[NSArray arrayWithObjects: [EventClothTypeInfo eventWithType:dateEventClothType], nil]
                                      withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:pinkColorClothType], nil]
                                     withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
        skirt1.delegate = self;

        [self addToArray:_skirts cloth:skirt1];

        
        Cloth *skirt2 = [Cloth clothWithImagePath:@"skirt2"
                                     withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], nil]
                                      withEvents:[NSArray arrayWithObjects: [EventClothTypeInfo eventWithType:workEventClothType],  [EventClothTypeInfo eventWithType:dateEventClothType], nil]
                                      withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:redColorClothType], nil]
                                     withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
        skirt2.delegate = self;

        [self addToArray:_skirts cloth:skirt2];

        
        Cloth *skirt3 = [Cloth clothWithImagePath:@"skirt3"
                                     withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType], nil]
                                      withEvents:[NSArray arrayWithObjects: [EventClothTypeInfo eventWithType:workEventClothType],  [EventClothTypeInfo eventWithType:dateEventClothType],
                                        [EventClothTypeInfo eventWithType:interviewEventClothType], nil]
                                      withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:grayColorClothType], nil]
                                     withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
        skirt3.delegate = self;

        [self addToArray:_skirts cloth:skirt3];

        
        Cloth *skirt4 = [Cloth clothWithImagePath:@"skirt4"
                                     withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], nil]
                                       withEvents:[NSArray arrayWithObjects: [EventClothTypeInfo eventWithType:workEventClothType],  [EventClothTypeInfo eventWithType:dateEventClothType], nil]
                                      withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:pinkColorClothType], nil]
                                     withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
        skirt4.delegate = self;

        [self addToArray:_skirts cloth:skirt4];

        
        Cloth *skirt5 = [Cloth clothWithImagePath:@"skirt5"
                                     withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType], nil]
                                      withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:dateEventClothType], nil]
                                      withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:blueColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
        skirt5.delegate = self;

        [self addToArray:_skirts cloth:skirt5];
        
        Cloth *skirt6 = [Cloth clothWithImagePath:@"skirt6"
                                      withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType], nil]
                                       withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:dateEventClothType],  [EventClothTypeInfo eventWithType:interviewEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], nil]
                                       withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:blueColorClothType], [ColorClothTypeInfo colorWithType:blackColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
        skirt6.delegate = self;

        [self addToArray:_skirts cloth:skirt6];
        
        Cloth *skirt7 = [Cloth clothWithImagePath:@"skirt7"
                                      withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:winterSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType], nil]
                                       withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:dateEventClothType],  [EventClothTypeInfo eventWithType:interviewEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], nil]
                                       withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:pinkColorClothType], [ColorClothTypeInfo colorWithType:redColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
        skirt7.delegate = self;

        [self addToArray:_skirts cloth:skirt7];
    }
}

- (void)loadTeeShirtsHardCodedIfNeeded
{
    if (_teeShirts.count == 0)
    {
        Cloth *teeShirt1 = [Cloth clothWithImagePath:@"teeShirt1"
                                      withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], nil]
                                       withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:sportEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], nil]
                                       withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:pinkColorClothType], [ColorClothTypeInfo colorWithType:redColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
        teeShirt1.delegate = self;

        [self addToArray:_teeShirts cloth:teeShirt1];
        
        Cloth *teeShirt2 = [Cloth clothWithImagePath:@"teeShirt2"
                                         withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], nil]
                                          withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:sportEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], nil]
                                          withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:orangeColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
        teeShirt2.delegate = self;

        [self addToArray:_teeShirts cloth:teeShirt2];
        
        Cloth *teeShirt3 = [Cloth clothWithImagePath:@"teeShirt3"
                                         withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], nil]
                                          withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:sportEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], nil]
                                          withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:blackColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
        teeShirt3.delegate = self;

        [self addToArray:_teeShirts cloth:teeShirt3];
        
        Cloth *teeShirt4 = [Cloth clothWithImagePath:@"teeShirt4"
                                         withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], nil]
                                          withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:sportEventClothType], nil]
                                          withColors:[NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:blackColorClothType], [ColorClothTypeInfo colorWithType:grayColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
        teeShirt4.delegate = self;

        [self addToArray:_teeShirts cloth:teeShirt4];
        
        Cloth *teeShirt5 = [Cloth clothWithImagePath:@"teeShirt5"
                                         withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType], [SeasonClothTypeInfo seasonWithType:summerSeasonClothType], nil]
                                          withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:sportEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], nil]
                                          withColors:[NSArray arrayWithObjects: [ColorClothTypeInfo colorWithType:blueColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
        teeShirt5.delegate = self;

        [self addToArray:_teeShirts cloth:teeShirt5];
        
        Cloth *teeShirt6 = [Cloth clothWithImagePath:@"teeShirt6"
                                         withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:fallSeasonClothType], [SeasonClothTypeInfo seasonWithType:winterSeasonClothType], nil]
                                          withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:sportEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], nil]
                                          withColors:[NSArray arrayWithObjects: [ColorClothTypeInfo colorWithType:redColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
        teeShirt6.delegate = self;

        [self addToArray:_teeShirts cloth:teeShirt6];
        
        Cloth *teeShirt7 = [Cloth clothWithImagePath:@"teeShirt7"
                                         withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:fallSeasonClothType], [SeasonClothTypeInfo seasonWithType:winterSeasonClothType], [SeasonClothTypeInfo seasonWithType:springSeasonClothType],[SeasonClothTypeInfo seasonWithType:summerSeasonClothType], nil]
                                          withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:sportEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], nil]
                                          withColors:[NSArray arrayWithObjects: [ColorClothTypeInfo colorWithType:blackColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
        teeShirt7.delegate = self;

        [self addToArray:_teeShirts cloth:teeShirt7];
    }
}

- (void)loadAccesorysHardCodedIfNeeded
{
    if (_accessory.count == 0)
    {
        Cloth *accessory1 = [Cloth clothWithImagePath:@"accessory1"
                                         withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType],[SeasonClothTypeInfo seasonWithType:summerSeasonClothType], nil]
                                          withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:sportEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], [EventClothTypeInfo eventWithType:dateEventClothType], nil]
                                          withColors:[NSArray arrayWithObjects: [ColorClothTypeInfo colorWithType:blackColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:accessoryItemClothType]];
        accessory1.delegate = self;

        [self addToArray:_accessory cloth:accessory1];
        
        Cloth *accessory2 = [Cloth clothWithImagePath:@"accessory2"
                                          withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType],[SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType],[SeasonClothTypeInfo seasonWithType:winterSeasonClothType], nil]
                                           withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:interviewEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], [EventClothTypeInfo eventWithType:dateEventClothType], nil]
                                           withColors:[NSArray arrayWithObjects: [ColorClothTypeInfo colorWithType:orangeColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:accessoryItemClothType]];
        accessory2.delegate = self;

        [self addToArray:_accessory cloth:accessory2];
        
        Cloth *accessory3 = [Cloth clothWithImagePath:@"accessory3"
                                          withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType],[SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType],[SeasonClothTypeInfo seasonWithType:winterSeasonClothType], nil]
                                           withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:interviewEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], [EventClothTypeInfo eventWithType:dateEventClothType], nil]
                                           withColors:[NSArray arrayWithObjects: [ColorClothTypeInfo colorWithType:redColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:accessoryItemClothType]];
        accessory3.delegate = self;

        [self addToArray:_accessory cloth:accessory3];
        
        Cloth *accessory4 = [Cloth clothWithImagePath:@"accessory4"
                                          withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType],[SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType],[SeasonClothTypeInfo seasonWithType:winterSeasonClothType], nil]
                                           withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:interviewEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], [EventClothTypeInfo eventWithType:dateEventClothType], nil]
                                           withColors:[NSArray arrayWithObjects: [ColorClothTypeInfo colorWithType:grayColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:accessoryItemClothType]];
        accessory4.delegate = self;

        [self addToArray:_accessory cloth:accessory4];
        
        Cloth *accessory5 = [Cloth clothWithImagePath:@"accessory5"
                                          withSeasons:[NSArray arrayWithObjects:[SeasonClothTypeInfo seasonWithType:springSeasonClothType],[SeasonClothTypeInfo seasonWithType:summerSeasonClothType], [SeasonClothTypeInfo seasonWithType:fallSeasonClothType],[SeasonClothTypeInfo seasonWithType:winterSeasonClothType], nil]
                                           withEvents:[NSArray arrayWithObjects:  [EventClothTypeInfo eventWithType:sportEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], [EventClothTypeInfo eventWithType:dateEventClothType], nil]
                                           withColors:[NSArray arrayWithObjects: [ColorClothTypeInfo colorWithType:blackColorClothType], nil] withItemInfo:[ItemClothTypeInfo itemClothWithType:accessoryItemClothType]];
        accessory5.delegate = self;

        [self addToArray:_accessory cloth:accessory5];
    }
}

- (void)addToArray:(NSMutableArray *)clothArray cloth:(Cloth *)cloth
{
    [clothArray addObject:cloth];
}

- (BOOL)needLoadData
{
    if (_pants.count == 0 || _teeShirts.count == 0 || _skirts.count == 0)
    {
        return YES;
    }
    
    return NO;
}

- (void)updateFilterCloths
{
    _filterCloths = [NSMutableDictionary dictionary];
    
    [self insertClothsInFilter:_pants];
    [self insertClothsInFilter:_skirts];
    [self insertClothsInFilter:_teeShirts];
    [self insertClothsInFilter:_accessory];
}

- (void)insertClothsInFilter:(NSArray *)cloths
{
    for (Cloth *cloth in cloths)
    {
        [self insertFilterForCloth:cloth key:cloth.itemTypeInfo];

        for (ClothType *clothType in cloth.seasonTypeInfos)
        {
            [self insertFilterForCloth:cloth key:clothType];
        }
        for (ClothType *clothType in cloth.colorTypeInfos)
        {
            [self insertFilterForCloth:cloth key:clothType];
        }
        for (ClothType *clothType in cloth.eventTypeInfos)
        {
            [self insertFilterForCloth:cloth key:clothType];
        }
//        [self insertFilterForCloth:cloth key:cloth.seasonTypeInfo];
//        [self insertFilterForCloth:cloth key:cloth.colorTypeInfo];
//        [self insertFilterForCloth:cloth key:cloth.itemTypeInfo];
//        [self insertFilterForCloth:cloth key:cloth.eventTypeInfo];
    }
}

- (void)insertFilterForCloth:(Cloth *)cloth key:(ClothType *)keyClothType
{
    NSMutableArray *clothForKeyClothType = [_filterCloths objectForKey:keyClothType.strType];
    if (!clothForKeyClothType)
    {
        clothForKeyClothType = [NSMutableArray array];
    }
    if (![clothForKeyClothType containsObject:cloth])
    {
        [clothForKeyClothType addObject:cloth];
    }
    [_filterCloths setObject:clothForKeyClothType forKey:keyClothType.strType];
}

- (NSDictionary *)cloths
{
    NSMutableDictionary *cloths = [NSMutableDictionary dictionary];

    [cloths setObject:_pants forKey:@"pants"];
    [cloths setObject:_skirts forKey:@"skirts"];
    [cloths setObject:_teeShirts forKey:@"teeShirts"];
    [cloths setObject:_accessory forKey:@"accessory"];

    return cloths;
}

- (NSDictionary *)filters
{
    return _filterCloths;
}

- (NSArray *)favorites
{
    return _favorites;
}

- (void)addCostumeResultToFavorite:(CostumeResultsInfo *)costume
{
    if (![_favorites containsObject:costume])
    {
        [_favorites addObject:costume];
    }
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
            NSMutableArray *clothForKeyClothType = [_filterCloths objectForKey:clothType.strType];
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
        
        NSMutableArray *clothForKeyClothType = [_filterCloths objectForKey:clothType.strType];
        
        for (Cloth *cloth in result)
        {
            if (![clothForKeyClothType containsObject:cloth])
            {
                [clothToRemove addObject:cloth];
            }
        }
        
//        if (clothForKeyClothType)
//        {
//            [result addObjectsFromArray:clothForKeyClothType];
//        }
//        
//        for (Cloth *cloth in result)
//        {
//            if ([clothForKeyClothType containsObject:cloth])
//            {
//                [clothToRemove addObject:cloth];
//            }
//        }
    }
        
    [result removeObjectsInArray:clothToRemove];
    [result addObjectsFromArray:clothToAdd];

    return result;
}

/* Cloth Delegates */

- (void)clothDidChangedCategories:(Cloth *)cloth
{
    [self save];
    [self updateFilterCloths];
}

- (void)clothDidChangedItemClothType:(Cloth *)cloth fromItemClothType:(ItemClothTypeInfo *)oldItem toItemClothType:(ItemClothTypeInfo *)newItem
{
    if (oldItem.itemType == newItem.itemType)
    {
        return;
    }
    
    switch (oldItem.itemType)
    {
        case pantItemClothType:
            [_pants removeObject:cloth];
            break;
        case teeShirtItemClothType:
            [_teeShirts removeObject:cloth];
            break;
        case skirtItemClothType:
            [_skirts removeObject:cloth];
            break;
        case accessoryItemClothType:
            [_accessory removeObject:cloth];
            break;
            
        default:
            break;
    }
    
    switch (newItem.itemType)
    {
        case pantItemClothType:
            [_pants addObject:cloth];
            break;
        case teeShirtItemClothType:
            [_teeShirts addObject:cloth];
            break;
        case skirtItemClothType:
            [_skirts addObject:cloth];
            break;
        case accessoryItemClothType:
            [_accessory addObject:cloth];
            break;
            
        default:
            break;
    }
    
    [self save];
    [self updateFilterCloths];
    [Shared postNotification:INFOS_DATA_CHANGED];
}

/* End Cloth Delegates */

@end
