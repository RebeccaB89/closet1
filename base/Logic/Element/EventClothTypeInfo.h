//
//  EventClothTypeInfo.h
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "ClothType.h"

typedef enum : NSUInteger {
    workEventClothType,
    dateEventClothType,
    sportEventClothType,
    interviewEventClothType
} EventClothType;

@interface EventClothTypeInfo : ClothType

+ (EventClothTypeInfo *)eventWithType:(EventClothType)eventClothType;

@property (nonatomic, unsafe_unretained) EventClothType eventType;

@end
