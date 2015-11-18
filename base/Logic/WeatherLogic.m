//
//  WeatherLogic.m
//  base
//
//  Created by rebecca biaz on 10/21/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "WeatherLogic.h"
#import "LocationLogic.h"
#import "NSString-URLArguments.h"

@interface WeatherLogic()
{
    BOOL _requestInProcess;
}

@end

#define TIME_FOR_RELOAD_WEATHER     1800

@implementation WeatherLogic

static WeatherLogic *sharedInstance = nil;

+ (WeatherLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            if (sharedInstance == nil)
            {
                sharedInstance = [[self alloc] init];
            }
        }
    }
    return sharedInstance;
}

- (instancetype)init
{
    self = [super init];
    
    if (self)
    {
        [[LocationLogic sharedInstance] addLocationDependency:self];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(locationChanged:) name:LOCATION_CHANGED_EVENT object:nil];

    }
    
    return self;
}

- (Weather *)currentWeather
{
    return _currentWeather;
}

- (BOOL)weatherInfoForCurrentLocation:(Weather *)weather
                               target:(id)target
                                error:(NSError **)error
                              started:(LogicStarted)startedHandler
                             finished:(LogicFinished)finishedHandler
{
    if (![[LocationLogic sharedInstance] isLocationServiceAvailable])
        return NO;
    CLLocation *location = [LocationLogic sharedInstance].lastLocationCoordinates;
    
    return [self weatherInfoForCoordinates:location.coordinate.latitude longitude:location.coordinate.longitude target:target error:error started:startedHandler finished:finishedHandler];
}

- (BOOL)cityForCurrentLocation:(Weather *)weather
                                error:(NSError **)error
                              started:(LogicStarted)startedHandler
                             finished:(LogicFinished)finishedHandler
{
    if (![[LocationLogic sharedInstance] isLocationServiceAvailable])
        return NO;
    CLLocation *location = [LocationLogic sharedInstance].lastLocationCoordinates;
    
    return [self cityForCoordinates:location.coordinate.latitude longitude:location.coordinate.longitude weather:weather error:error started:startedHandler finished:finishedHandler];
}

- (NSURLRequest *)createGetWeatherForCoordinatesRequest:(double)latitute
                                              longitude:(double)longitude
{
    NSString *woeidQuery = [NSString stringWithUTF8String:[YAHOO_SELECT_WEATHER_FOR_COORDINATES(latitute, longitude) UTF8String]];
    woeidQuery = [woeidQuery stringByEscapingForURLArgument];
    
    NSMutableString* yahooRequest = [NSMutableString stringWithUTF8String:[YAHOO_API_BASE UTF8String]];
    
    [yahooRequest appendString:woeidQuery];
    [yahooRequest appendString:YAHOO_APIS_FORMAT];
    [yahooRequest appendString:YAHOO_APIS_COMPLEMENT];

    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:yahooRequest]];
    
    return request;
}

- (NSURLRequest *)createGetCityForCoordinatesRequest:(double)latitute
                                           longitude:(double)longitude
{
    NSString *woeidQuery = [NSString stringWithUTF8String:[YAHOO_SELECT_CITY_FOR_COORDINATES(latitute, longitude) UTF8String]];
    woeidQuery = [woeidQuery stringByEscapingForURLArgument];
    
    NSMutableString* yahooRequest = [NSMutableString stringWithUTF8String:[YAHOO_API_BASE UTF8String]];
    
    [yahooRequest appendString:woeidQuery];
    [yahooRequest appendString:YAHOO_APIS_FORMAT];
    [yahooRequest appendString:YAHOO_APIS_COMPLEMENT];
    
    
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:yahooRequest]];
    
    return request;
}

- (BOOL)weatherInfoForCoordinates:(double)latitude
                        longitude:(double)longitude
                           target:(id)target
                            error:(NSError **)error
                          started:(LogicStarted)startedHandler
                         finished:(LogicFinished)finishedHandler
{
    NSURLRequest *request = [self createGetWeatherForCoordinatesRequest:latitude longitude:longitude];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
    {
        NSError *jsonError = nil;
        NSDictionary *jsonResponse = [NSJSONSerialization
                              JSONObjectWithData: data
                              options: NSJSONReadingMutableContainers
                              error: &jsonError];
        
        Weather *tempWeather = nil;
        if (!error && jsonResponse)
        {
            tempWeather = [[Weather alloc] init];
            
            NSDictionary *query = [jsonResponse objectForKey:@"query"];
            NSDictionary *diagnostics = [query objectForKey:@"diagnostics"];
            NSArray *urls = [diagnostics objectForKey:@"url"];
            NSString *woeid = nil;
            
            for (NSDictionary *url in urls)
            {
                NSString *content = [url objectForKey:@"content"];
                NSRange range = [content rangeOfString:@"w="];
                if (range.location != NSNotFound)
                {
                    woeid = [content substringFromIndex:range.location+range.length];
                    break;
                }
            }
            
            NSDictionary *results = [query objectForKey:@"results"];
            id channels = [results objectForKey:@"channel"];
            NSDictionary *channel = nil;
            
            if ([channels isKindOfClass:[NSArray class]])
            {
                channel = (NSDictionary *)[channels firstObject];
            }
            else if ([channels isKindOfClass:[NSDictionary class]])
            {
                channel = (NSDictionary *)channels;
            }
            if (!channel)
            {
                tempWeather = nil;
            }
            [tempWeather fillWithDictionaryElement:channel];
            tempWeather.itemId = woeid;
        }
        if (!error)
        {
            error = jsonError;
        }
        if (finishedHandler)
        {
            finishedHandler(error, tempWeather);
        }
        
    }] resume];
    
    return YES;
}

- (BOOL)cityForCoordinates:(double)latitude
                        longitude:(double)longitude
                           weather:(Weather *)weather
                            error:(NSError **)error
                          started:(LogicStarted)startedHandler
                         finished:(LogicFinished)finishedHandler
{
    NSURLRequest *request = [self createGetCityForCoordinatesRequest:latitude longitude:longitude];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
      {
          NSError *jsonError = nil;
          NSDictionary *jsonResponse = [NSJSONSerialization
                                        JSONObjectWithData: data
                                        options: NSJSONReadingMutableContainers
                                        error: &jsonError];
          if (!error && jsonResponse)
          {
              NSDictionary *query = [jsonResponse objectForKey:@"query"];
              
             NSDictionary *results = [query objectForKey:@"results"];
              NSDictionary *Result = [results objectForKey:@"Result"];
              
            NSString *place = [Result objectForKey:@"city"];
              weather.place = place;
          }
          if (!error)
          {
              error = jsonError;
          }
          if (finishedHandler)
          {
              finishedHandler(error, weather);
          }
          
      }] resume];
    
    return YES;
}


/* Notifications */

- (void)locationChanged:(NSNotification *)info
{
    NSDate *date = [NSDate date];
    
    NSTimeInterval i = date.timeIntervalSinceNow;
    NSTimeInterval f = _lastLocationDate.timeIntervalSinceNow;
    NSTimeInterval diff = i - f;
    _lastLocationDate = date;
    if ((diff >= TIME_FOR_RELOAD_WEATHER || !_currentWeather) && !_requestInProcess)
    {
        _requestInProcess = [self weatherInfoForCurrentLocation:nil target:nil error:nil started:^(id data)
        {
            
        } finished:^(NSError *error, id data)
        {
            _requestInProcess = NO;
            if (data && !error)
            {
                _currentWeather = (Weather *)data;
                [Shared postNotification:WEATHER_CHANGED_EVENT userInfo:nil forObject:nil];
                
                [self cityForCurrentLocation:_currentWeather error:&error started:^(id data) {
                    
                } finished:^(NSError *error, id data)
                {
                    _currentWeather = (Weather *)data;
                    [Shared postNotification:WEATHER_CHANGED_EVENT userInfo:nil forObject:nil];
                }];
            }
        }] ;
    }
}

/* End */

@end
