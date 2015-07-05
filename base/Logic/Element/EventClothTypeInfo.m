//
//  EventClothTypeInfo.m
//  base
//
//  Created by Rebecca Biaz on 6/18/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "EventClothTypeInfo.h"

@implementation EventClothTypeInfo

+ (EventClothTypeInfo *)eventWithType:(EventClothType)eventClothType
{
    EventClothTypeInfo *eventInfo = [[EventClothTypeInfo alloc] init];
    eventInfo.eventType = eventClothType;
    
    return eventInfo;
}


- (UIColor *)color
{
    switch (self.eventType)
    {
        case dateEventClothType:
            return [UIColor yellowColor];
            break;
        case interviewEventClothType:
            return [UIColor grayColor];
            break;
        case sportEventClothType:
            return [UIColor greenColor];
            break;
        case workEventClothType:
            return [UIColor brownColor];
            break;
            
        default:
            return [UIColor yellowColor];
    }
}

- (NSString *)strType
{
    switch (self.eventType)
    {
        case dateEventClothType:
            return NLS(@"Date");
            break;
        case interviewEventClothType:
            return NLS(@"Interview");
            break;
        case sportEventClothType:
            return NLS(@"Sport");
            break;
        case workEventClothType:
            return NLS(@"Work");
            break;
            
        default:
            return NLS(@"Date");
    }
}

@end