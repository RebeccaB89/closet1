//
//  NSDate-Expanded.m
//  YES
//
//  Created by action item on 1/14/10.
//  Copyright 2010 RosTelecom. All rights reserved.
//

#import "NSDate-Expanded.h"

#define DATE_COMPONENTS (NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit | NSWeekdayOrdinalCalendarUnit)
#define CURRENT_CALENDAR [NSCalendar currentCalendar]
#define NUMBER_OF_SECONDS_IN_A_DAY 86400

@implementation NSDate (Expanded)

static NSDateFormatter *gDateFormatter = NULL;

+ (NSDate *)currentZeroDate
{
    NSDate *currentZeroDate = [NSDate combineDateAndTime:[NSDate date] time:[NSDate dateWithStringFormat:@"HH:mm" dateAsString:@"00:00"]];
	return currentZeroDate;
}

+ (NSDate *)combineDateAndTime:(NSDate *)date time:(NSDate *)time
{
	//NSAssert(date != nil,@"Date can't be nil");
	if (date == nil)
	{
		return nil;
	}
	NSDate *zeroDate = [date dateAtStartOfDay];
	NSUInteger seconds = [time totalSecondsFromTime];
	return [NSDate addSecondsToDate:zeroDate seconds:seconds];
	
	NSString *dateStr = [date getDateAsString];
	NSString *timeStr = [time getTimeAsStringWithSeconds];
	
	return [NSDate dateWithStringFormat:@"dd-MM-yyyy HH:mm:ss" dateAsString:[dateStr stringByAppendingFormat:@" %@", timeStr]];
}

+ (NSInteger)dayOfWeekOfDate:(NSDate *)date
{
	// get current day number
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];	
	NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
	NSInteger weekday = [weekdayComponents weekday];
	// weekday 1 = Sunday for Gregorian calendar
	return weekday;
}

+ (NSDate *)dateWithStringFormat:(NSString *)format dateAsString:(NSString *)dateAsString
{
	if (!dateAsString) return nil;
	
	@synchronized(gDateFormatter)
	{
		if (!gDateFormatter)
		{
			gDateFormatter = [[NSDateFormatter alloc] init];		
			[gDateFormatter setDateFormat:format];
		}
		else
			if (![gDateFormatter.dateFormat isEqual:format])
			{
				[gDateFormatter setDateFormat:format];
			}
		
		// format can be @"yyyy-MM-dd 'at' HH:mm"
		NSDate *date = [[gDateFormatter dateFromString:dateAsString] copy];
		return date;
	}
}

- (BOOL)isBefore:(NSDate*)other 
{
	BOOL retVal = [self timeIntervalSinceDate:other] < 0;
	return retVal;
}

- (BOOL)isAfter:(NSDate*)other 
{
	return [self timeIntervalSinceDate:other] > 0;
}

- (BOOL)isSameDay:(NSDate*)other 
{
    if (other == nil) return NO; // or it will crash
    
    NSCalendar* calendar = [NSCalendar currentCalendar];
	
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:self];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:other];
	
    return [comp1 day] == [comp2 day] &&
	[comp1 month] == [comp2 month] &&
	[comp1 year]  == [comp2 year];
}

- (int)daysFrom1970
{
	NSTimeInterval since = [self timeIntervalSince1970];
	return since/(60*60*24);
}

- (int)daysFromDate:(NSDate *)date
{
	NSTimeInterval since = [self timeIntervalSinceDate:date];
	return since/(60*60*24);
}

- (BOOL)is7DaysFromNow
{
	NSDate *seven = [[NSDate date] dateByAddingTimeInterval:86400*7];
	return [seven isSameDay:self];
}

- (BOOL)isTomorrow
{
	NSDate *tomorrow = [[NSDate date] dateByAddingTimeInterval:86400];
	return [tomorrow isSameDay:self];
}

- (BOOL)isYesterday
{
    NSDate *yesterday = [[NSDate date] dateByAddingTimeInterval:-86400];
	return [yesterday isSameDay:self];
}

+ (NSDate *)addMinutesToDate:(NSDate *)date minutes:(NSInteger)minutes
{
	// set up date components
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setMinute:minutes];
	// create a calendar
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *newDate = [gregorian dateByAddingComponents:components toDate:date options:0];
	
	return newDate;
}

+ (NSDate *)addSecondsToDate:(NSDate *)date seconds:(NSInteger)seconds
{
	// set up date components
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setSecond:seconds];
	// create a calendar
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *newDate = [gregorian dateByAddingComponents:components toDate:date options:0];
	
	return newDate;
}

+ (NSDate *)addHoursToDate:(NSDate *)date hours:(NSInteger)hours
{
	// set up date components
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setHour:hours];
	// create a calendar
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *newDate = [gregorian dateByAddingComponents:components toDate:date options:0];
	
	return newDate;
}

+ (NSDate *)addDaysToDate:(NSDate *)date days:(NSInteger)days
{
	// set up date components
	NSDateComponents *components = [[NSDateComponents alloc] init];
	[components setDay:days];
	// create a calendar
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSDate *newDate = [gregorian dateByAddingComponents:components toDate:date options:0];
	
	return newDate;
}

+ (NSDate *)subtractDaysFromDate:(NSDate *)date days:(NSInteger)days
{
    NSDate *newDate = [date dateByAddingTimeInterval: -(days * NUMBER_OF_SECONDS_IN_A_DAY)];
    return newDate;
}

+ (NSDate *)date:(NSDate *)date withHour:(int)hour withMinute:(int)minute withSecond:(int)second
{
    NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:date];
    [components setHour:hour];
    [components setMinute:minute];
    [components setSecond:second];
    return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateAtStartOfDay
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	[components setHour:0];
	[components setMinute:0];
	[components setSecond:0];
	return [CURRENT_CALENDAR dateFromComponents:components];
}

- (NSDate *)dateAtEndOfDay
{
	NSDateComponents *components = [CURRENT_CALENDAR components:DATE_COMPONENTS fromDate:self];
	[components setHour:23];
	[components setMinute:59];
	[components setSecond:59];
	return [CURRENT_CALENDAR dateFromComponents:components];
}

- (BOOL)isDateBetween:(NSDate *)firstDate secondDate:(NSDate *)secondDate
{
	if ([self compare:firstDate] >= NSOrderedSame && [self compare:secondDate] < NSOrderedSame)
		return YES;
	return NO;
}

- (NSString *)stringWithFormat:(NSString *)format
{
	if (![format length]) return nil;
	
    static NSDateFormatter *inputFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        inputFormatter = [[NSDateFormatter alloc] init];
        
    });
	[inputFormatter setDateFormat:format];
	NSString *dateString = [inputFormatter stringFromDate:self];
	return dateString;
}

- (NSString *)getTimeAsString
{
	return [self stringWithFormat:@"HH:mm"];
}

- (NSString *)getTimeAsStringWithSeconds
{
	return [self stringWithFormat:@"HH:mm:ss"];
}

- (NSString *)getDateAsString
{
	return [self getDateAsStringWithFormat:@"dd-MM-yyyy HH:mm:ss"];
}

- (NSString *)getDateAsStringWithFormat:(NSString *)format
{
	return [self stringWithFormat:format];
}

- (NSString *)getDateAsPhpString
{
	return [self stringWithFormat:@"yyyy-MM-dd"];
}

- (NSString *)asUTCString:(NSString *)format
{
    // Purpose: Return a string of the specified date-time in UTC (Zulu) time zone in ISO 8601 format.
    // Example: 2013-10-25T06:59:43.431Z
    static NSDateFormatter *dateFormatter = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        dateFormatter = [[NSDateFormatter alloc] init];
        
    });
    
    [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [dateFormatter setDateFormat:format];
    NSString* dateTimeInIsoFormatForZuluTimeZone = [dateFormatter stringFromDate:self];
    return dateTimeInIsoFormatForZuluTimeZone;
}

- (int)totalYearsFromTime
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
    
	return [dateComponents year];
}

- (int)totalMonthsFromTime
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSCalendarUnit unitFlags = NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
	return [dateComponents month];
}

- (int)totalDaysFromTime
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSCalendarUnit unitFlags = NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
	return [dateComponents day];
}

- (int)totalHoursFromTime
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSCalendarUnit unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
	return [dateComponents hour];
}

- (int)totalMinutesFromTime
{
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSCalendarUnit unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
	return ([dateComponents hour] * 60) + ([dateComponents minute]);
}

- (int)totalSecondsFromTime
{
	NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
	NSCalendarUnit unitFlags = NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
	NSDateComponents *dateComponents = [calendar components:unitFlags fromDate:self];
	return ([dateComponents hour] * 60 * 60) + ([dateComponents minute] * 60) + ([dateComponents second]);
}

- (NSDate *)getFirstDayOfWeek
{
	NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];	
	NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:self];
	NSInteger weekday = [weekdayComponents weekday];
	// weekday 1 = Sunday for Gregorian calendar
	
	return [NSDate addDaysToDate:self days:1-weekday];
}

+ (NSDate *)getFirstDayOfCurrentMonth
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *monthComp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
    [monthComp setDay:1];

    NSDate *firstDayOfMonthDate = [gregorian dateFromComponents:monthComp];
    
    return firstDayOfMonthDate;
}

+ (NSDate *)getDateOfDayInCurrentMonth:(int)day
{
    NSDate *today = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *monthComp = [gregorian components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit) fromDate:today];
    [monthComp setDay:day];
    
    NSDate *date = [gregorian dateFromComponents:monthComp];
    
    return date;
}

- (NSInteger)dayOfWeek
{
	return [NSDate dayOfWeekOfDate:self];
}

- (NSInteger)dayOfMonth
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:self];
    NSInteger day = [components day];    
    
    return day;
}

#pragma mark Retrieving Intervals

- (NSTimeInterval)secondsAfterDate:(NSDate *)aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (ti);
}

- (NSTimeInterval)secondsBeforeDate:(NSDate *)aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (ti);
}

- (NSInteger)minutesAfterDate:(NSDate *)aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)minutesBeforeDate:(NSDate *)aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_MINUTE);
}

- (NSInteger)hoursAfterDate:(NSDate *)aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)hoursBeforeDate:(NSDate *)aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_HOUR);
}

- (NSInteger)daysAfterDate:(NSDate *)aDate
{
	NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger)daysBeforeDate:(NSDate *)aDate
{
	NSTimeInterval ti = [aDate timeIntervalSinceDate:self];
	return (NSInteger) (ti / D_DAY);
}

- (NSInteger)weeksAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_WEEK);    
}

- (NSInteger)monthsAfterDate:(NSDate *)aDate
{
    NSTimeInterval ti = [self timeIntervalSinceDate:aDate];
	return (NSInteger) (ti / D_MONTH);    
}

+(NSUInteger) getCurrentDay
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    NSInteger day = [components day]; 
    
    return day;
}

+ (NSString*)getCurrentMonthName
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
    
    NSInteger monthNumber = [components month];
    
    NSString * dateString = [NSString stringWithFormat: @"%d", monthNumber];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    NSDate* myDate = [dateFormatter dateFromString:dateString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    [formatter setLocale:usLocale];
    NSString *stringFromDate = [formatter stringFromDate:myDate];
    
    return stringFromDate;
}

+ (NSString*)getMonthNameByDate:(NSDate *)currentDate
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:currentDate];
    
    NSInteger monthNumber = [components month];
    
    NSString * dateString = [NSString stringWithFormat: @"%d", monthNumber];
    
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    NSDate* myDate = [dateFormatter dateFromString:dateString];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMMM"];
    [formatter setLocale:usLocale];
    NSString *stringFromDate = [[formatter stringFromDate:myDate] copy];
    
    return stringFromDate;
}

+ (NSString*)getDayOfWeekName:(NSInteger) dayFromMonthStart
{
    NSDateFormatter* theDateFormatter = [[NSDateFormatter alloc] init];
    [theDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    [theDateFormatter setDateFormat:@"EEEE"];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [theDateFormatter setLocale:usLocale];
    NSInteger dayOffset = [NSDate getCurrentDay] - dayFromMonthStart;
    NSDate *dateForCalculations = [[NSDate date] dateByAddingTimeInterval: -86400.0*dayOffset];
    
    NSString *weekDay =  [theDateFormatter stringFromDate:dateForCalculations];
    
    return weekDay;
}

+ (NSString *)getDayOfWeekNameByDate:(NSDate *)currentDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];  
    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
    NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormatter setLocale:usLocale];
    [dateFormatter setDateFormat:@"EEEE"];
    return [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:currentDate]];
}

//+ (NSString *)getMonthNameByDate:(NSDate *)currentDate
//{    
//    NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];    
//    [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
//    [dateFormatter setDateFormat:@"MMM"];
//    return [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:currentDate]];
//}

+ (NSTimeInterval)getPreciseDiffByServerTime:(NSDate *)serverTime
{
    NSDate *localDate = [NSDate date];
    NSTimeInterval diff = [serverTime timeIntervalSinceDate:localDate];   
    return diff;
}

+ (NSTimeInterval)getDiffByServerTime:(NSDate *)serverTime
{
    NSDate *localDate = [NSDate date];
    NSTimeInterval seconds = [serverTime secondsAfterDate:localDate];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:seconds];
    NSTimeInterval ti = [date timeIntervalSinceDate:[NSDate dateWithTimeIntervalSince1970:0]];
//	int hours = (NSInteger) ceil(ti / D_HOUR);
    int hours =  round(ti / D_HOUR); // if still doesn't work, do floor()
    
    //int hours = [date hoursAfterDate:[NSDate dateWithTimeIntervalSince1970:0]];
    return hours * D_HOUR; // round diff to hours

    NSTimeInterval diff = [serverTime timeIntervalSinceDate:localDate];   
    return diff;
}

+ (int)getDateHour:(NSDate *)date
{
    NSCalendar *Calendar =[ [NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [Calendar components:NSHourCalendarUnit fromDate:date];
    
    return [components hour];
}

+ (int)getDateMinute:(NSDate *)date
{
    NSCalendar *Calendar =[ [NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *components = [Calendar components:NSMinuteCalendarUnit fromDate:date];
    
    return [components minute];
}

@end
