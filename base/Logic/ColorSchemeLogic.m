//
//  ColorSchemeLogic.m
//  base
//
//  Created by rebecca biaz on 12/21/15.
//  Copyright © 2015 rebecca. All rights reserved.
//

#import "ColorSchemeLogic.h"

@implementation ColorSchemeLogic

static ColorSchemeLogic *sharedInstance = nil;

+ (ColorSchemeLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
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
    _colorSchemes = [NSMutableDictionary dictionary];
    NSArray *allClothType = [ColorClothTypeInfo allClothType];
    for (ColorClothTypeInfo *clothType in allClothType)
    {
        [_colorSchemes setObject:clothType.colorsLikely forKey:clothType.strType];
    }
}

- (NSArray *)colorsLikelyColor:(ColorClothTypeInfo *)colorType
{
    NSArray *colors = [_colorSchemes objectForKey:colorType.strType];
    if ([colors isKindOfClass:[NSNull class]])
    {
        return nil;
    }
    return colors;
}

@end
