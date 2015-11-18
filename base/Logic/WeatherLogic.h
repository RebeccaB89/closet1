//
//  WeatherLogic.h
//  base
//
//  Created by rebecca biaz on 10/21/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Weather.h"

#define WEATHER_CHANGED_EVENT            @"WEATHER_CHANGED_EVENT"

typedef void (^LogicStarted)(id data);
typedef void (^LogicFinished)(NSError *error, id data);

@interface WeatherLogic : NSObject
{
    NSDate *_lastLocationDate;
    Weather *_currentWeather;
}

+ (WeatherLogic *)sharedInstance;

- (BOOL)weatherInfoForCurrentLocation:(Weather *)weather
                               target:(id)target
                                error:(NSError **)error
                              started:(LogicStarted)startedHandler
                             finished:(LogicFinished)finishedHandler;

- (Weather *)currentWeather;

@end
