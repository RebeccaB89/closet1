//
//  infoLogic.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "infoLogic.h"
#import "Cloth.h"

@implementation InfoLogic

static InfoLogic *sharedInstance = nil;

+ (InfoLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            //sharedInstance = [InfoLogic load];
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
        [self initialize];
    }
    
    return self;
}

- (void)initialize
{
    _pants = [NSMutableArray array];
    _skirts = [NSMutableArray array];
    _teeShirts = [NSMutableArray array];
    
    if ([self needLoadData])
    {
        [self loadDataHardCoded];
    }
    
    [self updateFilterCloths];
}

- (void)loadDataHardCoded
{
    Cloth *pant1 = [Cloth clothWithImagePath:@"pant1" withSeason:[SeasonClothTypeInfo seasonWithType:summerSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:interviewEventClothType] withColor:[ColorClothTypeInfo colorWithType:blackColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:pantItemClothType]];
    [self addToArray:_pants cloth:pant1];
    
    Cloth *pant2 = [Cloth clothWithImagePath:@"pant2" withSeason:[SeasonClothTypeInfo seasonWithType:winterSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:interviewEventClothType] withColor:[ColorClothTypeInfo colorWithType:blueColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:pantItemClothType]];
    [self addToArray:_pants cloth:pant2];

    Cloth *pant3 = [Cloth clothWithImagePath:@"pant3" withSeason:[SeasonClothTypeInfo seasonWithType:summerSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:interviewEventClothType] withColor:[ColorClothTypeInfo colorWithType:blueColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:pantItemClothType]];
    [self addToArray:_pants cloth:pant3];

    Cloth *pant4 = [Cloth clothWithImagePath:@"pant4" withSeason:[SeasonClothTypeInfo seasonWithType:summerSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:dateEventClothType] withColor:[ColorClothTypeInfo colorWithType:pinkColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:pantItemClothType]];
    [self addToArray:_pants cloth:pant4];

    Cloth *pant5 = [Cloth clothWithImagePath:@"pant5" withSeason:[SeasonClothTypeInfo seasonWithType:summerSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:dateEventClothType] withColor:[ColorClothTypeInfo colorWithType:blueColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:pantItemClothType]];
    [self addToArray:_pants cloth:pant5];

    Cloth *skirt1 = [Cloth clothWithImagePath:@"skirt1" withSeason:[SeasonClothTypeInfo seasonWithType:fallSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:sportEventClothType] withColor:[ColorClothTypeInfo colorWithType:blackColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
    [self addToArray:_skirts cloth:skirt1];

    Cloth *skirt2 = [Cloth clothWithImagePath:@"skirt2" withSeason:[SeasonClothTypeInfo seasonWithType:fallSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:sportEventClothType] withColor:[ColorClothTypeInfo colorWithType:orangeColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
    [self addToArray:_skirts cloth:skirt2];

    Cloth *skirt3 = [Cloth clothWithImagePath:@"skirt3" withSeason:[SeasonClothTypeInfo seasonWithType:winterSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:dateEventClothType] withColor:[ColorClothTypeInfo colorWithType:blackColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
    [self addToArray:_skirts cloth:skirt3];

    Cloth *skirt4 = [Cloth clothWithImagePath:@"skirt4" withSeason:[SeasonClothTypeInfo seasonWithType:springSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:sportEventClothType] withColor:[ColorClothTypeInfo colorWithType:whiteColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:skirtItemClothType]];
    [self addToArray:_skirts cloth:skirt4];
    
    Cloth *teeShirt1 = [Cloth clothWithImagePath:@"teeShirt1" withSeason:[SeasonClothTypeInfo seasonWithType:springSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:sportEventClothType] withColor:[ColorClothTypeInfo colorWithType:blackColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
    [self addToArray:_teeShirts cloth:teeShirt1];

    Cloth *teeShirt2 = [Cloth clothWithImagePath:@"teeShirt2" withSeason:[SeasonClothTypeInfo seasonWithType:springSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:dateEventClothType] withColor:[ColorClothTypeInfo colorWithType:blackColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
    [self addToArray:_teeShirts cloth:teeShirt2];

    Cloth *teeShirt3 = [Cloth clothWithImagePath:@"teeShirt3" withSeason:[SeasonClothTypeInfo seasonWithType:winterSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:workEventClothType] withColor:[ColorClothTypeInfo colorWithType:blueColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
    [self addToArray:_teeShirts cloth:teeShirt3];

    Cloth *teeShirt4 = [Cloth clothWithImagePath:@"teeShirt4" withSeason:[SeasonClothTypeInfo seasonWithType:winterSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:workEventClothType] withColor:[ColorClothTypeInfo colorWithType:blackColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
    [self addToArray:_teeShirts cloth:teeShirt4];

    Cloth *teeShirt5 = [Cloth clothWithImagePath:@"teeShirt5" withSeason:[SeasonClothTypeInfo seasonWithType:springSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:workEventClothType] withColor:[ColorClothTypeInfo colorWithType:orangeColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
    [self addToArray:_teeShirts cloth:teeShirt5];

    Cloth *teeShirt6 = [Cloth clothWithImagePath:@"teeShirt6" withSeason:[SeasonClothTypeInfo seasonWithType:winterSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:dateEventClothType] withColor:[ColorClothTypeInfo colorWithType:multiColorColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
    [self addToArray:_teeShirts cloth:teeShirt6];

    Cloth *teeShirt7 = [Cloth clothWithImagePath:@"teeShirt7" withSeason:[SeasonClothTypeInfo seasonWithType:winterSeasonClothType] withEvent:[EventClothTypeInfo eventWithType:dateEventClothType] withColor:[ColorClothTypeInfo colorWithType:pinkColorClothType] withItemInfo:[ItemClothTypeInfo itemClothWithType:teeShirtItemClothType]];
    [self addToArray:_teeShirts cloth:teeShirt7];
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

    int i = 0;
}

- (void)insertClothsInFilter:(NSArray *)cloths
{
    for (Cloth *cloth in cloths)
    {
        [self insertFilterForCloth:cloth key:cloth.seasonTypeInfo];
        [self insertFilterForCloth:cloth key:cloth.colorTypeInfo];
        [self insertFilterForCloth:cloth key:cloth.itemTypeInfo];
        [self insertFilterForCloth:cloth key:cloth.eventTypeInfo];
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

    return cloths;
}

- (NSDictionary *)filters
{
    return _filterCloths;
}

- (NSArray *)clothsForClothTypeFilters:(NSArray *)filters
{
    NSMutableArray *result = [NSMutableArray array];
    ClothType *clothTypeFirst = [filters firstObject];
    NSMutableArray *clothForKeyClothTypeFirst = [_filterCloths objectForKey:clothTypeFirst.strType];

    if (clothForKeyClothTypeFirst)
    {
        [result addObjectsFromArray:clothForKeyClothTypeFirst];
    }
    
    NSMutableArray *clothToRemove = [NSMutableArray array];
    for (ClothType *clothType in filters)
    {
        NSMutableArray *clothForKeyClothType = [_filterCloths objectForKey:clothType.strType];
        for (Cloth *cloth in result)
        {
            if (![clothForKeyClothType containsObject:cloth])
            {
                [clothToRemove addObject:cloth];
            }
        }
    }
    
    [result removeObjectsInArray:clothToRemove];
    
    return result;
}

@end
