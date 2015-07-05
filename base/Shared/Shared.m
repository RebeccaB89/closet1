//
//  NLShared.m
//  CasinoForPP
//
//  Created by Rebecca Biaz on 10/19/14.
//  Copyright (c) 2014 Viaden Media. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shared.h"
#include <netinet/in.h>
#import <SystemConfiguration/SCNetworkReachability.h>
#import "NSObject-Utility.h"
#import <MobileCoreServices/MobileCoreServices.h>

#import <objc/runtime.h>

@implementation Shared

+ (id <UIApplicationDelegate>)appDelegate
{
    return [[UIApplication sharedApplication] delegate];
}

+ (void)postNotification:(NSString *)name
{
    [Shared postNotification:name userInfo:nil forObject:nil];
}

+ (void)postNotification:(NSString *)name userInfo:(NSDictionary *)userInfo forObject:(id)forObject
{
    // always post on main thread
    [[NSNotificationCenter defaultCenter] performSelectorOnMainThreadWithArguments:@selector(postNotificationName:object:userInfo:), name, forObject, userInfo, nil]; 
}

+ (BOOL)isiPad
{
    return (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad);
}

+ (id)readValue:(NSString *)key default:(id)defaultValue
{
    id r = [[NSUserDefaults standardUserDefaults] objectForKey:key];
    if (r == nil)
        return defaultValue;
    return r;
}

+ (CGFloat)readFloat:(NSString *)key default:(CGFloat)defaultValue
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:key] == nil)
        return defaultValue;
    CGFloat r = [[NSUserDefaults standardUserDefaults] floatForKey:key];
    return r;
}

+ (NSInteger)readInteger:(NSString *)key default:(NSInteger)defaultValue
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:key] == nil)
        return defaultValue;
    NSInteger r = [[NSUserDefaults standardUserDefaults] integerForKey:key];
    return r;
}

+ (BOOL)readBool:(NSString *)key default:(BOOL)defaultValue
{
    if ([[NSUserDefaults standardUserDefaults] stringForKey:key] == nil)
        return defaultValue;
    BOOL r = [[NSUserDefaults standardUserDefaults] boolForKey:key];
    return r;
}

+ (void)writeBool:(BOOL)value key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)writeValue:(id)value key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)writeInteger:(NSInteger)value key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (void)writeFloat:(CGFloat)value key:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setFloat:value forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];    
}  

+ (void)deleteKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
}

+ (BOOL)featureFlagFor:(NSString *)feature
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"NLFeatureFlags" ofType:@"plist"];
    NSDictionary* plist = [NSDictionary dictionaryWithContentsOfFile:path];
    BOOL enabled = [[plist objectForKey:feature] boolValue];
    return enabled;
}

+ (BOOL)connectedToNetwork:(BOOL)includeDataNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network wifi reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    
    return ((isReachable && !needsConnection) || (includeDataNetwork && nonWiFi)) ? YES : NO;
}

+ (BOOL)connectedTo3GNetwork
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network wifi reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = flags & kSCNetworkFlagsReachable;
    BOOL needsConnection = flags & kSCNetworkFlagsConnectionRequired;
    BOOL nonWiFi = flags & kSCNetworkReachabilityFlagsTransientConnection;
    
    return (isReachable && !needsConnection && nonWiFi);
}

+ (BOOL)deviceConnectedToInternet
{
    if (![self connectedToNetwork:NO] && ![self connectedTo3GNetwork]) return NO;
    
    return YES;
}

@end