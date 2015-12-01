//
//  Weather.m
//  PaddleLink
//
//  Created by Action Item on 2/18/14.
//  Copyright (c) 2014 hAcx. All rights reserved.
//

#import "Weather.h"

#define WIND_DIRECTION_MIDDLE_RANGE     22 // TODO: Need to implement double range to support jumps of 22.5
#define WIND_DIRECTION_NORTH            0
#define WIND_DIRECTION_NORTH_WEST       315

@implementation Weather

+ (float)celciusToFahrenheit:(float)celcius
{
    return roundf(((9.0 / 5.0) * celcius) + 32);
}

+ (float )fahrenheitToCelcius:(float)fahrenheit
{
    return roundf((5.0/9.0) * (fahrenheit-32));
}

+ (NSArray *)windImages
{
    return [[NSArray alloc] initWithObjects:IMAGE(@"NEVWWindDirectionN.png"),
                                            IMAGE(@"NEVWWindDirectionNE.png"),
                                            IMAGE(@"NEVWWindDirectionNE.png"),
                                            IMAGE(@"NEVWWindDirectionE.png"),
                                            IMAGE(@"NEVWWindDirectionE.png"),
                                            IMAGE(@"NEVWWindDirectionSE.png"),
                                            IMAGE(@"NEVWWindDirectionSE.png"),
                                            IMAGE(@"NEVWWindDirectionS.png"),
                                            IMAGE(@"NEVWWindDirectionS.png"),
                                            IMAGE(@"NEVWWindDirectionSW.png"),
                                            IMAGE(@"NEVWWindDirectionSW.png"),
                                            IMAGE(@"NEVWWindDirectionW.png"),
                                            IMAGE(@"NEVWWindDirectionW.png"),
                                            IMAGE(@"NEVWWindDirectionNW.png"),
                                            IMAGE(@"NEVWWindDirectionNW.png"), nil];
}

+ (NSMutableArray *)windDirectionRanges
{
    NSMutableArray *windDirectionRangesArray = [[NSMutableArray alloc] init];
    double startLocationValue = WIND_DIRECTION_NORTH;
    double length = WIND_DIRECTION_MIDDLE_RANGE;
    while (startLocationValue <= WIND_DIRECTION_NORTH_WEST + length)
    {
        NSRange range = NSMakeRange(startLocationValue, length);
        NSValue *value = [NSValue valueWithRange:range];
        
        [windDirectionRangesArray addObject:value];
        startLocationValue = startLocationValue + length + 1;
    }
    
    return windDirectionRangesArray;
}

+ (NSArray *)windDirectionTitles
{
    return [[NSArray alloc] initWithObjects:@"N",
                                            @"NE",
                                            @"NE",
                                            @"E",
                                            @"E",
                                            @"SE",
                                            @"SE",
                                            @"S",
                                            @"S",
                                            @"SW",
                                            @"SW",
                                            @"W",
                                            @"W",
                                            @"NW",
                                            @"NW", nil];
}

+ (NSString *)translateWindDirectionAndImageFromWeather:(Weather *)weather image:(UIImage **)windDirectionImage
{
    NSArray *windDirectionRanges = [self windDirectionRanges];
    NSArray *windImages = [self windImages];
    NSArray *windDirectionTitles = [self windDirectionTitles];
    
    int windDirection = (int)weather.windDirection;
    for (int i=0; i<windDirectionRanges.count; i++)
    {
        NSValue *rangeValue = (NSValue *)[windDirectionRanges objectAtIndex:i];
        if (NSLocationInRange(windDirection, [rangeValue rangeValue]))
        {
            *windDirectionImage = [windImages objectAtIndex:i];
            return [windDirectionTitles objectAtIndex:i];
        }
    }
    
    return nil;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
	if (self = [super initWithCoder:aDecoder])
	{
        self.place = [aDecoder decodeObjectForKey:@"place"];
        self.condition = [aDecoder decodeObjectForKey:@"condition"];
        self.cDegrees = [aDecoder decodeFloatForKey:@"cDegrees"];
        self.fDegrees = [aDecoder decodeFloatForKey:@"fDegrees"];
        self.windDirection = [aDecoder decodeFloatForKey:@"windDirection"];
        self.windSpeed = [aDecoder decodeFloatForKey:@"windSpeed"];
    }
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
    
    [aCoder encodeObject:_place forKey:@"place"];
    [aCoder encodeObject:_condition forKey:@"condition"];
    [aCoder encodeFloat:_cDegrees forKey:@"cDegrees"];
    [aCoder encodeFloat:_fDegrees forKey:@"fDegrees"];
    [aCoder encodeFloat:_windDirection forKey:@"windDirection"];
    [aCoder encodeFloat:_windSpeed forKey:@"windSpeed"];
}

- (BOOL)isEqual:(id)object
{
    if (!object || ![object isKindOfClass:[self class]]) return NO;
    
    Weather *other = object;
    if (other == self || [other.place isEqual:self.place])
    {
        return YES;
    }
    
    return NO;
}

- (void)setCDegrees:(float)cDegrees
{
    _cDegrees = cDegrees;
    _fDegrees = [Weather celciusToFahrenheit:_cDegrees];
}

- (void)setFDegrees:(float)fDegrees
{
    _fDegrees = fDegrees;
    _cDegrees = [Weather fahrenheitToCelcius:_fDegrees];
}

- (void)setCDegreesTomorrow:(float)cDegreesTomorrow
{
    _cDegreesTomorrow = cDegreesTomorrow;
    _fDegreesTomorrow = [Weather celciusToFahrenheit:_cDegreesTomorrow];
}

- (void)setFDegreesTomorrow:(float)fDegreesTomorrow
{
    _fDegreesTomorrow = fDegreesTomorrow;
    _cDegreesTomorrow = [Weather fahrenheitToCelcius:_fDegreesTomorrow];
}

- (void)fillWithDictionaryElement:(id)element
{
    [super fillWithDictionaryElement:element];
    
    //fill from yahoo xml
    
    self.title = [self getObjectFromKey:element key:@"title"];
    self.subTitle = [self getObjectFromKey:element key:@"lastBuildDate"];
    NSDictionary *location = [self getObjectFromKey:element key:@"location"];
    if (!location)
    {
        location = [self getObjectFromKey:element key:@"yweather:location"];
    }
    self.place = [self getObjectFromKey:location key:@"city" defaultValue:self.place];
    
    NSDictionary *item = [self getObjectFromKey:element key:@"item"];
    NSDictionary *units = [self getObjectFromKey:element key:@"yweather:units"];
    if (!units)
    {
        units = [self getObjectFromKey:element key:@"units"];
    }
    NSDictionary *conditions = [self getObjectFromKey:item key:@"yweather:condition"];

    if (!conditions)
    {
        conditions = [self getObjectFromKey:item key:@"condition"];
    }

    NSString *temperatureUnit;
    if (conditions)
    {
        if (units)
        {
            temperatureUnit = [self getObjectFromKey:units key:@"temperature"];
            NSString *temperature = [self getObjectFromKey:conditions key:@"temp"];
            if ([temperatureUnit isEqualToString:YAHOO_FAHRENHEIT_UNIT])
            {
                self.fDegrees = [temperature floatValue];
            }
            else if ([temperatureUnit isEqualToString:YAHOO_CELCIUS_UNIT])
            {
                self.cDegrees = [temperature floatValue];
            }
        }
        
        self.condition = [self getObjectFromKey:conditions key:@"text"];
        int code = [[self getObjectFromKey:conditions key:@"code"] intValue];
        self.imageUrl = [NSString stringWithFormat:@"http://l.yimg.com/a/i/us/nws/weather/gr/%dd.png", code];
    }
    
    NSArray *forecast = [self getObjectFromKey:item key:@"forecast"];

    if (forecast)
    {
        NSDictionary *today = [forecast firstObject];
        if (today)
        {
            NSString *temperatureHight = [self getObjectFromKey:today key:@"high"];
            CGFloat tempHight = [temperatureHight floatValue];
            
            NSString *temperatureLow = [self getObjectFromKey:today key:@"low"];
            CGFloat tempLow = [temperatureLow floatValue];
            NSString *text = [self getObjectFromKey:today key:@"text"];
            
            NSMutableString *todayInfoStr = [NSMutableString string];
            [todayInfoStr appendFormat:@"%@\n", text];
            [todayInfoStr appendFormat:@"High: %@ ", temperatureHight];
            [todayInfoStr appendFormat:@"Low: %@", temperatureLow];

            self.todayInfo = todayInfoStr;
        }
        
        NSDictionary *tomorrow;
        if (forecast.count > 1)
        {
            tomorrow = [forecast objectAtIndex:1];
        }
        
        if (tomorrow)
        {
            NSString *temperatureHight = [self getObjectFromKey:tomorrow key:@"high"];
            CGFloat tempHight = [temperatureHight floatValue];
            
            NSString *temperatureLow = [self getObjectFromKey:tomorrow key:@"low"];
            CGFloat tempLow = [temperatureLow floatValue];
            NSString *text = [self getObjectFromKey:tomorrow key:@"text"];
            
            NSMutableString *tomorrowInfoStr = [NSMutableString string];
            [tomorrowInfoStr appendFormat:@"%@\n", text];
            [tomorrowInfoStr appendFormat:@"High: %@ ", temperatureHight];
            [tomorrowInfoStr appendFormat:@"Low: %@", temperatureLow];
            
            self.tomorrowInfo = tomorrowInfoStr;
            
            CGFloat tempTomorrow = (tempHight + tempLow )/ 2;
            if ([temperatureUnit isEqualToString:YAHOO_FAHRENHEIT_UNIT])
            {
                self.fDegreesTomorrow = tempTomorrow;
            }
            else if ([temperatureUnit isEqualToString:YAHOO_CELCIUS_UNIT])
            {
                self.cDegreesTomorrow = tempTomorrow;
            }
        }
    }
    
    NSDictionary *wind = [self getObjectFromKey:element key:@"yweather:wind"];
    if (!wind)
    {
        wind = [self getObjectFromKey:element key:@"wind"];
    }
    if (wind)
    {
        self.windDirection = [[self getObjectFromKey:wind key:@"direction"] floatValue];
        self.windSpeed = [[self getObjectFromKey:wind key:@"speed"] floatValue];
    }
}

@end
