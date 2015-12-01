//
//  CostumeResultsInfo.m
//  base
//
//  Created by rebecca biaz on 7/13/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "CostumeResultsInfo.h"

@implementation CostumeResultsInfo

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.upClothInfo = [aDecoder decodeObjectForKey:@"upClothInfo"];
        self.bottomClothInfo = [aDecoder decodeObjectForKey:@"bottomClothInfo"];
        self.accessoryInfo = [aDecoder decodeObjectForKey:@"accessoryInfo"];
        self.isFavorite = [aDecoder decodeBoolForKey:@"isFavorite"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_upClothInfo forKey:@"upClothInfo"];
    [aCoder encodeObject:_bottomClothInfo forKey:@"bottomClothInfo"];
    [aCoder encodeObject:_accessoryInfo forKey:@"accessoryInfo"];
    [aCoder encodeBool:_isFavorite forKey:@"isFavorite"];
}

- (BOOL)isEqual:(id)object
{
    if ([object isKindOfClass:[self class]])
    {
        CostumeResultsInfo *another = (CostumeResultsInfo *)object;
        BOOL costumeEqual = NO;
        costumeEqual = another.upClothInfo == self.upClothInfo && another.bottomClothInfo ==self.bottomClothInfo && another.accessoryInfo ==self.accessoryInfo;
 
        return costumeEqual;
    }
    
    return NO;
}

@end
