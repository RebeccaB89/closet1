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
        case multiColorColorClothType:
            return NLS(@"Multi");
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
            
        default:
            return NLS(@"Black");
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
        case multiColorColorClothType:
            return [UIColor clearColor];
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
        case whiteColorClothType:
            return [UIColor whiteColor];
            break;
            
        default:
            return [UIColor yellowColor];
    }
}

@end