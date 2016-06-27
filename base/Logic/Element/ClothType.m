//
//  ClothType.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ClothType.h"

@implementation ClothType

+ (NSArray *)allClothType
{
    return nil;
}

+ (NSString *)clothTypeStr
{
    return @"Cloth";
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];    
}

- (BOOL)canMultipleSelection
{
    return YES;
}

- (UIColor *)color
{
    return nil;
}

- (UIColor *)textColor
{
    return [UIColor blackColor];
}

- (NSString *)strType
{
    return nil;
}

- (UIImage *)image
{
    return nil;
}

- (NSInteger)numOfTypeForThisCloth
{
    return 0;
}

+ (NSString *)questionChooser
{
    return @"cloth?";
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]])
    {
        ClothType *another = (ClothType *)object;
        BOOL strEqual = [self.strType isEqualToString:another.strType];
        return strEqual;
    }
    
    return NO;
}

@end
