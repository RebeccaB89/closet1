//
//  LocationLogic.h
//  base
//
//  Created by rebecca biaz on 10/19/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#define LOCATION_LOGIC_STARTED_EVENT            @"LOCATION_LOGIC_STARTED_EVENT"
#define LOCATION_LOGIC_STOPPED_EVENT            @"LOCATION_LOGIC_STOPPED_EVENT"
#define LOCATION_CHANGED_EVENT                  @"LOCATION_CHANGED_EVENT"
#define LOCATION_AUTHORIZATION_STATUS_CHANGED   @"LOCATION_AUTHORIZATION_STATUS_CHANGED"

@interface LocationLogic : NSObject <CLLocationManagerDelegate>
{
    CLLocation *_lastLocation;
    NSMutableArray *_locationDependencies;
}

+ (LocationLogic *)sharedInstance;

- (NSString *)lastLocationCoordinatesAsString;
- (BOOL)isLocationServiceAvailable;

- (BOOL)startLocationEvents;
- (BOOL)startLocationEventsForDuration:(NSTimeInterval)time;
- (void)stopLocationEvents;

// use this to start and stop the location manager.
// if there are no more dependencies the location manager will automatically stop
- (void)addLocationDependency:(id)object;
- (void)removeLocationDependency:(id)object;

- (CLLocation *)lastLocationCoordinates;

@property (nonatomic, strong, readonly) CLLocationManager *locationManager;

@end
