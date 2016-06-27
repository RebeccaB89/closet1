//
//  ColorClothTypeInfo.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ColorClothTypeInfo.h"

@implementation ColorClothTypeInfo

+ (ColorClothTypeInfo *)colorWithType:(ColorClothType)colorClothType
{
    ColorClothTypeInfo *colorInfo = [[ColorClothTypeInfo alloc] init];
    colorInfo.colorType = colorClothType;
    
    return colorInfo;
}

+ (NSArray *)allClothType
{
    return [NSArray arrayWithObjects:[ColorClothTypeInfo colorWithType:blackColorClothType], [ColorClothTypeInfo colorWithType:whiteColorClothType], [ColorClothTypeInfo colorWithType:redColorClothType], [ColorClothTypeInfo colorWithType:blueColorClothType],[ColorClothTypeInfo colorWithType:pinkColorClothType], [ColorClothTypeInfo colorWithType:purpleColorClothType], [ColorClothTypeInfo colorWithType:orangeColorClothType], [ColorClothTypeInfo colorWithType:greenColorClothType], [ColorClothTypeInfo colorWithType:grayColorClothType], nil];
}

+ (NSString *)clothTypeStr
{
    return @"Color";
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.colorType = [aDecoder decodeIntForKey:@"colorType"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInt:_colorType forKey:@"colorType"];
}

- (NSString *)strType
{
    switch (self.colorType)
    {
        case blackColorClothType:
            return NLS(@"Black");
            break;
        case blueColorClothType:
            return NLS(@"Blue");
            break;
        case orangeColorClothType:
            return NLS(@"Orange");
            break;
        case pinkColorClothType:
            return NLS(@"Pink");
            break;
        case purpleColorClothType:
            return NLS(@"Purple");
            break;
        case redColorClothType:
            return NLS(@"Red");
            break;
        case whiteColorClothType:
            return NLS(@"White");
            break;
        case greenColorClothType:
            return NLS(@"Green");
            break;
        case grayColorClothType:
            return NLS(@"Gray");
            break;
        default:
            return NLS(@"Black");
    }
}

+ (NSString *)questionChooser
{
    return @"Color";
}

- (NSArray *)colorsLikely
{
    switch (self.colorType)
    {
        case blackColorClothType:
            return @[@(whiteColorClothType), @(grayColorClothType)];
            break;
        case blueColorClothType:
            return @[@(blackColorClothType), @(whiteColorClothType)];
            break;
        case orangeColorClothType:
            return @[@(grayColorClothType), @(blackColorClothType)];
            break;
        case pinkColorClothType:
            return @[@(grayColorClothType), @(whiteColorClothType)];
            break;
        case purpleColorClothType:
            return @[@(whiteColorClothType), @(grayColorClothType)];
            break;
        case redColorClothType:
            return @[@(whiteColorClothType), @(blackColorClothType)];
            break;
        case greenColorClothType:
            return @[@(whiteColorClothType), @(blackColorClothType)];
            break;
        case whiteColorClothType:
            return @[@(grayColorClothType), @(blackColorClothType)];
            break;
        case grayColorClothType:
            return @[@(whiteColorClothType), @(blackColorClothType)];
            break;
            
        default:
            return @[];
    }
}

- (UIColor *)color
{
    switch (self.colorType)
    {
        case blackColorClothType:
            return [UIColor blackColor];
            break;
        case blueColorClothType:
            return [UIColor blueColor];
            break;

        case orangeColorClothType:
            return [UIColor orangeColor];
            break;
        case pinkColorClothType:
            return [UIColor colorWithRed:245.0/255.0 green:144.0/255.0 blue:204.0/255.0 alpha:1];
            break;
        case purpleColorClothType:
            return [UIColor purpleColor];
            break;
        case redColorClothType:
            return [UIColor redColor];
            break;
        case greenColorClothType:
            return [UIColor greenColor];
            break;
        case whiteColorClothType:
            return [UIColor whiteColor];
            break;
        case grayColorClothType:
            return [UIColor lightGrayColor];
            break;
            
        default:
            return [UIColor yellowColor];
    }
}

- (UIColor *)textColor
{
    switch (self.colorType)
    {
        case blackColorClothType:
            return [UIColor whiteColor];
            break;
               default:
            return [UIColor blackColor];
    }
}

@end
