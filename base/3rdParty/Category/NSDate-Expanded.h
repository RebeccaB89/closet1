//
//  NSDate-Expanded.h
//  YES
//
//  Created by action item on 1/14/10.
//  Copyright 2010 RosTelecom. All rights reserved.
//

#import <Foundation/Foundation.h>

#define D_MINUTE 60
#define D_HOUR 3600
#define D_DAY 86400
#define D_WEEK 604800
#define D_MONTH 2629743
#define D_YEAR 31556926

#define SERVER_TIME_DIFF mainLogic().versionItem.serverTimeDiff
#define SERVER_PRECISE_TIME_DIFF mainLogic().versionItem.serverPreciseTimeDiff

@interface NSDate (Expanded)

+ (NSInteger)dayOfWeekOfDate:(NSDate *)date;
+ (NSDate *)dateWithStringFormat:(NSString *)format dateAsString:(NSString *)dateAsString;
+ (NSDate *)addMinutesToDate:(NSDate *)date minutes:(NSInteger)minutes;
+ (NSDate *)addSecondsToDate:(NSDate *)date seconds:(NSInteger)seconds;
+ (NSDate *)addHoursToDate:(NSDate *)date hours:(NSInteger)hours;
+ (NSDate *)addDaysToDate:(NSDate *)date days:(NSInteger)days;
+ (NSDate *)subtractDaysFromDate:(NSDate *)date days:(NSInteger)days;
+ (NSDate *)date:(NSDate *)date withHour:(int)hour withMinute:(int)minute withSecond:(int)second;

- (BOOL)isDateBetween:(NSDate *)firstDate secondDate:(NSDate *)secondDate;
- (NSString *)getDateAsPhpString;
- (BOOL)isSameDay:(NSDate*)other;
- (NSString *)getDateAsStringWithFormat:(NSString *)format;
- (NSString *)getDateAsString;
- (NSString *)getTimeAsStringWithSeconds;
- (NSString *)getTimeAsString;
- (NSString *)stringWithFormat:(NSString *)format;
- (NSInteger)dayOfWeek;
- (NSInteger)dayOfMonth;
- (NSDate *)dateAtStartOfDay;
- (NSDate *)dateAtEndOfDay;
- (NSString *)asUTCString:(NSString *)format;

- (NSDate *)getFirstDayOfWeek;
- (BOOL)is7DaysFromNow;
- (BOOL)isYesterday;
- (BOOL)isTomorrow;
- (int)totalYearsFromTime;
- (int)totalMonthsFromTime;
- (int)totalDaysFromTime;
- (int)totalHoursFromTime;
- (int)totalMinutesFromTime;
- (int)totalSecondsFromTime;
- (BOOL)isAfter:(NSDate*)other; 
- (BOOL)isBefore:(NSDate*)other; 
- (int)daysFromDate:(NSDate *)date;
- (int)daysFrom1970;

- (NSTimeInterval)secondsBeforeDate:(NSDate *)aDate;
- (NSTimeInterval)secondsAfterDate:(NSDate *)aDate;
- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)minutesAfterDate:(NSDate *)aDate;
- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)hoursAfterDate:(NSDate *)aDate;
- (NSInteger)daysBeforeDate:(NSDate *)aDate;
- (NSInteger)daysAfterDate:(NSDate *)aDate;
- (NSInteger)weeksAfterDate:(NSDate *)aDate;
- (NSInteger)monthsAfterDate:(NSDate *)aDate;

+ (NSDate *)getFirstDayOfCurrentMonth;
+ (NSUInteger)getCurrentDay;
+ (NSString*)getCurrentMonthName;
+ (NSString*)getDayOfWeekName:(NSInteger) dayFromMonthStart;

+ (NSString *)getDayOfWeekNameByDate:(NSDate *)currentDate;
+ (NSString *)getMonthNameByDate:(NSDate *)currentDate;

+ (NSDate *)getDateOfDayInCurrentMonth:(int)day;

+ (NSTimeInterval)getPreciseDiffByServerTime:(NSDate *)serverTime;
+ (NSTimeInterval)getDiffByServerTime:(NSDate *)serverTime;

+ (NSDate *)currentZeroDate;
+ (NSDate *)combineDateAndTime:(NSDate *)date time:(NSDate *)time;

+ (int)getDateHour:(NSDate *)date;
+ (int)getDateMinute:(NSDate *)date;

@end
