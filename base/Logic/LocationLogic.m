//
//  LocationLogic.m
//  base
//
//  Created by rebecca biaz on 10/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import "LocationLogic.h"

#define SIMULATE_LOCATION 1
#define DIRECTIONS_LOGIC_LAST_LOCATION_KEY      @"lastLocation"


@implementation LocationLogic

@synthesize locationManager = _locationManager;

static LocationLogic *sharedInstance = nil;

+ (LocationLogic *)sharedInstance
{
    @synchronized(self)
    {
        if (sharedInstance == nil)
        {
            //sharedInstance = [InfoLogic load];
            if (sharedInstance == nil)
            {
                sharedInstance = [[self alloc] init];
            }
        }
    }
    return sharedInstance;
}

- (id)init
{
    if (self = [super init])
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnteredBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appEnteredForeground) name:UIApplicationWillEnterForegroundNotification object:nil];
        
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [self init])
    {
        _lastLocation = [aDecoder decodeObjectForKey:DIRECTIONS_LOGIC_LAST_LOCATION_KEY];
    }
    return self;
}

- (void)dealloc
{
    [_locationManager stopUpdatingLocation];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_lastLocation forKey:DIRECTIONS_LOGIC_LAST_LOCATION_KEY];
}

- (CLLocationManager *)locationManager
{
    if (!_locationManager)
        [self startLocationEvents];
    return _locationManager;
}

- (CLLocation *)lastLocationCoordinates
{
#if SIMULATE_LOCATION
    return [[CLLocation alloc] initWithLatitude:32.0833 longitude:34.8000];
#endif
    CLLocation *lastLocation = _lastLocation;
    return lastLocation;
}

- (NSString *)lastLocationCoordinatesAsString
{
    CLLocationCoordinate2D coordinates = [self lastLocationCoordinates].coordinate;
    return [NSString stringWithFormat:@"%f,%f", coordinates.latitude, coordinates.longitude];
}

- (NSString *)distanceFormatter:(CLLocationDistance)distance
{
    if (distance < 1000)
        return [NSString stringWithFormat:@"%0.2fm", distance];
    return [NSString stringWithFormat:@"%0.1fkm", distance / 1000.0f];
}

- (CLLocationDistance)distanceFromLocation:(CLLocationCoordinate2D)location
{
    if (![self lastLocationCoordinates]) return NSNotFound;
    
    CLLocation *tempLocation = [[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude];
    return [[self lastLocationCoordinates] distanceFromLocation:tempLocation];
}

- (BOOL)startLocationEvents
{
    if (![CLLocationManager locationServicesEnabled]) return NO;
    if (![self isLocationServiceAvailable])
    {
        return NO;
    }
    if (_locationManager) return YES;
    
    _locationManager = [[CLLocationManager alloc] init];
    _locationManager.delegate = self;
    _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
    if ([_locationManager respondsToSelector:@selector(pausesLocationUpdatesAutomatically)])
        _locationManager.pausesLocationUpdatesAutomatically = YES; // If you encounter background gps update problems, disable this !!
    [_locationManager startUpdatingLocation];
    
    return YES;
}

- (BOOL)startLocationEventsForDuration:(NSTimeInterval)time
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    BOOL isStarted = [self startLocationEvents];
    if (isStarted)
    {
        [self performSelector:@selector(stopLocationEvents) withObject:nil afterDelay: time];
    }
    
    return isStarted;
}

- (void)stopLocationEvents
{
    [NSObject cancelPreviousPerformRequestsWithTarget:self];
    [_locationManager stopUpdatingLocation];
    _locationManager = nil;
}

- (BOOL)isLocationServiceAvailable
{
#if SIMULATE_LOCATION
    return YES;
#endif
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined)
    {
        if (!_locationManager)
        {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
            if ([_locationManager respondsToSelector:@selector(pausesLocationUpdatesAutomatically)])
                _locationManager.pausesLocationUpdatesAutomatically = YES; // If you encounter background gps update problems, disable this !!
            [_locationManager startUpdatingLocation];
            
            [self.locationManager requestAlwaysAuthorization];
        }
    }
    
    CLAuthorizationStatus f = [CLLocationManager authorizationStatus];
    
    return [CLLocationManager locationServicesEnabled] && [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized;
}

- (void)addLocationDependency:(id)object
{
    if (!_locationDependencies)
        _locationDependencies = [NSMutableArray array];
    
    if (![_locationDependencies containsObject:object])
        [_locationDependencies addObject:object];
    
    [self startLocationEvents];
}

- (void)removeLocationDependency:(id)object
{
    [_locationDependencies removeObject:object];
    
    if (!_locationDependencies.count)
        [self stopLocationEvents];
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    _lastLocation = manager.location;
    NSDictionary *info = @{@"location" : _lastLocation};
    [Shared postNotification:LOCATION_CHANGED_EVENT userInfo:info forObject:nil];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    [Shared postNotification:LOCATION_LOGIC_STOPPED_EVENT];
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    NSLog(@"Location authoriztion status changed %d", status);
    NSDictionary *info = @{@"status" : @(status)};

    [Shared postNotification:LOCATION_AUTHORIZATION_STATUS_CHANGED userInfo:info forObject:nil];
}

/* Notifications */

- (void)appEnteredBackground
{
    [_locationManager stopUpdatingLocation];
}

- (void)appEnteredForeground
{
    [_locationManager startUpdatingLocation];
}

/* End */

@end
