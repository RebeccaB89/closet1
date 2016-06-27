//
//  NSDate+Weather.h
//  base
//
//  Created by rebecca biaz on 11/27/15.
//  Copyright (c) 2015 rebecca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Weather)

- (NSInteger)monthOfDate;
- (NSInteger)hourOfDate;

- (BOOL)isSummer;
- (BOOL)isWinter;
- (BOOL)isSpring;
- (BOOL)isAutumn;
- (BOOL)isDay;
- (BOOL)isNight;

@end
