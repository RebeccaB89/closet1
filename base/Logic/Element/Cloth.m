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
    NSArray *seasons = [NSArray arrayWithObject:season];
    NSArray *events = [NSArray arrayWithObject:event];
    NSArray *colors = [NSArray arrayWithObject:color];
    
    return [Cloth clothWithImagePath:imagePath withSeasons:seasons withEvents:events withColors:colors withItemInfo:itemInfo];
//    Cloth *cloth = [[Cloth alloc] init];
//    
//    cloth.imagePath = imagePath;
////    cloth.seasonTypeInfo = season;
////    cloth.eventTypeInfo = event;
////    cloth.colorTypeInfo = color;
//    cloth.itemTypeInfo = itemInfo;
//    
//    return cloth;
}

+ (Cloth *)clothWithImagePath:(NSString *)imagePath withSeasons:(NSArray *)seasons withEvents:(NSArray *)events withColors:(NSArray *)colors withItemInfo:(ItemClothTypeInfo *)itemInfo
{
    Cloth *cloth = [[Cloth alloc] init];
    
    cloth.imagePath = imagePath;
    cloth.image = IMAGE(imagePath);
    if (!cloth.image)
    {
        cloth.image = [UIImage imageWithContentsOfFile:imagePath];
    }
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

        self.image = [aDecoder decodeObjectForKey:@"image"];

        if (!self.image)
        {
            self.image = IMAGE(self.imagePath);
        }
        _itemTypeInfo = [aDecoder decodeObjectForKey:@"itemTypeInfo"];
        _seasonTypeInfos = [aDecoder decodeObjectForKey:@"seasonTypeInfos"];
        _eventTypeInfos = [aDecoder decodeObjectForKey:@"eventTypeInfos"];
        _colorTypeInfos = [aDecoder decodeObjectForKey:@"colorTypeInfos"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_imageName forKey:@"imageName"];
    [aCoder encodeObject:_image forKey:@"image"];

    if (!_image)
    {
        int i =0;
    }
    [aCoder encodeObject:_imagePath forKey:@"imagePath"];
    [aCoder encodeObject:_itemTypeInfo forKey:@"itemTypeInfo"];
    [aCoder encodeObject:_seasonTypeInfos forKey:@"seasonTypeInfos"];
    [aCoder encodeObject:_eventTypeInfos forKey:@"eventTypeInfos"];
    [aCoder encodeObject:_colorTypeInfos forKey:@"colorTypeInfos"];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]])
    {
        Cloth *another = (Cloth *)object;
        
        BOOL pathEqual = [another.imagePath isEqualToString:self.imagePath];
        return pathEqual;
    }
    
    return NO;
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
    if ([_colorTypeInfos isEqualToArray:colorTypeInfos])
    {
        return;
    }
    _colorTypeInfos = colorTypeInfos;
    
    [self notifyCategoriesChanged];
}

- (void)setEventTypeInfos:(NSArray *)eventTypeInfos
{
    if ([_eventTypeInfos isEqualToArray:eventTypeInfos])
    {
        return;
    }
    _eventTypeInfos = eventTypeInfos;
    [self notifyCategoriesChanged];
}

- (void)setSeasonTypeInfos:(NSArray *)seasonTypeInfos
{
    if ([_seasonTypeInfos isEqualToArray:seasonTypeInfos])
    {
        return;
    }
    _seasonTypeInfos = seasonTypeInfos;
    [self notifyCategoriesChanged];
}

@end
