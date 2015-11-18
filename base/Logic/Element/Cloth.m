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
//    cloth.seasonTypeInfo = season;
//    cloth.eventTypeInfo = event;
//    cloth.colorTypeInfo = color;
    cloth.itemTypeInfo = itemInfo;
    
    return cloth;
}

+ (Cloth *)clothWithImagePath:(NSString *)imagePath withSeasons:(NSArray *)seasons withEvents:(NSArray *)events withColors:(NSArray *)colors withItemInfo:(ItemClothTypeInfo *)itemInfo
{
    Cloth *cloth = [[Cloth alloc] init];
    
    cloth.imagePath = imagePath;
    cloth.seasonTypeInfos = seasons;
    cloth.eventTypeInfos = events;
    cloth.colorTypeInfos = colors;
    cloth.itemTypeInfo = itemInfo;
    
    return cloth;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.imageName = [aDecoder decodeObjectForKey:@"imageName"];
        self.imagePath = [aDecoder decodeObjectForKey:@"imagePath"];
        self.itemTypeInfo = [aDecoder decodeObjectForKey:@"itemTypeInfo"];
        self.seasonTypeInfos = [aDecoder decodeObjectForKey:@"seasonTypeInfos"];
        self.eventTypeInfos = [aDecoder decodeObjectForKey:@"eventTypeInfos"];
        self.colorTypeInfos = [aDecoder decodeObjectForKey:@"colorTypeInfos"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_imageName forKey:@"imageName"];
    [aCoder encodeObject:_imagePath forKey:@"imagePath"];
    [aCoder encodeObject:_itemTypeInfo forKey:@"itemTypeInfo"];
    [aCoder encodeObject:_seasonTypeInfos forKey:@"seasonTypeInfos"];
    [aCoder encodeObject:_eventTypeInfos forKey:@"eventTypeInfos"];
    [aCoder encodeObject:_colorTypeInfos forKey:@"colorTypeInfos"];
}

- (void)notifyItemClothTypeDidChangedFromItemType:(ItemClothTypeInfo *)oldItem toItemType:(ItemClothTypeInfo *)newItem
{
    if ([self.delegate respondsToSelector:@selector(clothDidChangedItemClothType:fromItemClothType:toItemClothType:)])
    {
        [self.delegate clothDidChangedItemClothType:self fromItemClothType:oldItem toItemClothType:newItem];
    }
}

- (void)notifyCategoriesChanged
{
    if ([self.delegate respondsToSelector:@selector(clothDidChangedCategories:)])
    {
        [self.delegate clothDidChangedCategories:self];
    }
}

- (NSArray *)clothtypesForClass:(Class)clothTypeClass
{
    if (clothTypeClass == [ItemClothTypeInfo class])
    {
        return [NSArray arrayWithObject:self.itemTypeInfo];
    }
    if (clothTypeClass == [SeasonClothTypeInfo class])
    {
        return self.seasonTypeInfos;
    }
    if (clothTypeClass == [EventClothTypeInfo class])
    {
        return self.eventTypeInfos;
    }
    if (clothTypeClass == [ColorClothTypeInfo class])
    {
        return self.colorTypeInfos;
    }
    
    return nil;
}

- (void)setItemTypeInfo:(ItemClothTypeInfo *)itemTypeInfo
{
    ItemClothTypeInfo *old = _itemTypeInfo;
    _itemTypeInfo = itemTypeInfo;
    
    [self notifyItemClothTypeDidChangedFromItemType:old toItemType:itemTypeInfo];
}

- (void)setColorTypeInfos:(NSArray *)colorTypeInfos
{
    _colorTypeInfos = colorTypeInfos;
    
    [self notifyCategoriesChanged];
}

- (void)setEventTypeInfos:(NSArray *)eventTypeInfos
{
    _eventTypeInfos = eventTypeInfos;
    [self notifyCategoriesChanged];
}

- (void)setSeasonTypeInfos:(NSArray *)seasonTypeInfos
{
    _seasonTypeInfos = seasonTypeInfos;
    [self notifyCategoriesChanged];
}

@end
