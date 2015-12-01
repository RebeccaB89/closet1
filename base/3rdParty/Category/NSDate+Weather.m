//
//  NSDate+Weather.m
//  base
//
//  Created by rebecca biaz on 11/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "NSDate+Weather.h"

@implementation NSDate (Weather)

- (NSInteger)monthOfDate
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    NSInteger month = [components month];
    
    return month;
}

- (NSInteger)hourOfDate
{
    NSCalendar *Calendar =[ [NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [Calendar components:(NSYearCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit) fromDate:self];
    
    return [components hour];
}

- (BOOL)isSummer
{
    NSInteger month = [self monthOfDate];
    if (month >= 6 && month <= 8)
    {
        return YES;
    }
    
    return NO;
}
- (BOOL)isWinter
{
    NSInteger month = [self monthOfDate];
    if (month >= 12 && month <= 2)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isSpring
{
    NSInteger month = [self monthOfDate];
    if (month >= 3 && month <= 5)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isAutumn
{
    NSInteger month = [self monthOfDate];
    if (month >= 9 && month <= 11)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isMorning
{
    NSInteger hour = [self hourOfDate];
    
    if (hour >= 6 && hour <= 11)
    {
        return YES;
    }
    
    return NO;
}

- (BOOL)isNoon
{
    NSInteger hour = [self hourOfDate];
    
    if ([self isSummer] || [self isSpring])
    {
        if (hour >= 12 && hour <= 19)
        {
            return YES;
        }
    }
    
    if ([self isWinter] || [self isAutumn])
    {
        if (hour >= 12 && hour <= 16)
        {
            return YES;
        }
    }
    
    return NO;
}

- (BOOL)isNight
{
    NSInteger hour = [self hourOfDate];
    
    if ([self isSummer] || [self isSpring])
    {
        if (hour >= 20 && hour <= 5)
        {
            return YES;
        }
    }
    
    if ([self isWinter] || [self isAutumn])
    {
        if (hour >= 17 && hour <= 5)
        {
            return YES;
        }
    }
    
    return NO;
}

@end
