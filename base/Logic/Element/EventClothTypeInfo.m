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

+ (NSArray *)allClothType
{
    return [NSArray arrayWithObjects:[EventClothTypeInfo eventWithType:dateEventClothType], [EventClothTypeInfo eventWithType:workEventClothType], [EventClothTypeInfo eventWithType:sportEventClothType], [EventClothTypeInfo eventWithType:interviewEventClothType], [EventClothTypeInfo eventWithType:casualEventClothType], [EventClothTypeInfo eventWithType:formalEventClothType], nil];
}

+ (NSString *)clothTypeStr
{
    return @"Event";
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder])
    {
        self.eventType = [aDecoder decodeIntForKey:@"eventType"];
    }
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeInt:_eventType forKey:@"eventType"];
}

+ (NSString *)questionChooser
{
    return @"Event";
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
        case casualEventClothType:
            return [UIColor cyanColor];
            break;
        case formalEventClothType:
            return [UIColor purpleColor];
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
        case casualEventClothType:
            return NLS(@"Casual");
            break;
        case formalEventClothType:
            return NLS(@"Formal");
            break;
            
        default:
            return NLS(@"Date");
    }
}

@end
