//
//  ClothTypeHelper.h
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SeasonClothTypeInfo.h"
#import "ColorClothTypeInfo.h"
#import "EventClothTypeInfo.h"

@interface ClothTypeHelper : NSObject

+ (NSArray *)seasonClothTypes;
+ (NSArray *)eventClothTypes;
+ (NSArray *)colorClothTypes;

@end
