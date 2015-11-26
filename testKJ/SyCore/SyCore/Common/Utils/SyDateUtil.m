//
//  SyDateUtil.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyDateUtil.h"
#import "SyCacheManager.h"
#import "SyLanguageUtil.h"

@implementation SyDateUtil


+ (CFGregorianDate)preMonth:(CFGregorianDate)date
{
	if ( date.month == 1 ){
		date.year--;
		date.month = 12;
	}
	else
		date.month--;
	
	if ( date.day > [SyDateUtil getDayCountOfaMonth:date] )
		date.day = [SyDateUtil getDayCountOfaMonth:date];
	
	return date;
}

+ (int)getDayCountOfaMonth:(CFGregorianDate)date
{
	switch ( date.month ) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
			
		case 2:
			if ( date.year%4 == 0 ) {
				if ( date.year % 100 != 0 )
					return 29;
				else {
					if ( date.year % 400 == 0 )
						return 29;
					else
						return 28;
				}
			}
			else
				return 28;
		case 4:
		case 6:
		case 9:
		case 11:
			return 30;
		default:
			return 31;
	}
}

+ (CFGregorianDate)preDay:(CFGregorianDate)date
{
	if ( date.day == 1 ) {
		date = [SyDateUtil preMonth:date];
		date.day = [SyDateUtil getDayCountOfaMonth:date];
	}
	else
		date.day--;
	
	return date;
}


+ (CFGregorianDate)stringToCFGregorianDate2:(NSString*)aStr
{
 	CFGregorianDate date;
	if (aStr.length == 0) {
        CFTimeZoneRef zf = CFTimeZoneCopySystem();
        date = CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), zf);
        CFRelease(zf);
		return date;
	}
	NSMutableString* tempStr = [[NSMutableString alloc] initWithFormat:@"%@", aStr];
	NSMutableString* valueStr = [[NSMutableString alloc] initWithFormat:@"%@", aStr];
	NSRange range;
	
	range = [tempStr rangeOfString:@"-"];
	[valueStr setString:[tempStr substringWithRange:NSMakeRange(0, range.location)]];
	date.year = [valueStr intValue];
	[tempStr deleteCharactersInRange:NSMakeRange(0, range.location + 1)];
	
	range = [tempStr rangeOfString:@"-"];
	[valueStr setString:[tempStr substringWithRange:NSMakeRange(0, range.location)]];
	date.month = [valueStr intValue];
	[tempStr deleteCharactersInRange:NSMakeRange(0, range.location + 1)];
	
	[valueStr setString:tempStr];
	date.day = [valueStr intValue];
	
	date.hour = 0;
	date.minute = 0;
	date.second = 0;
	
	return date;
}

+ (CFGregorianDate)nextMonth:(CFGregorianDate)date
{
	if ( date.month == 12 ){
		date.year++;
		date.month = 1;
	}
	else
		date.month++;
	
	if ( date.day > [SyDateUtil getDayCountOfaMonth:date] )
		date.day = [SyDateUtil getDayCountOfaMonth:date];
	
	return date;
}

+ (CFGregorianDate)nextDay:(CFGregorianDate)date
{
	int daysCount = [SyDateUtil getDayCountOfaMonth:date];
	if ( date.day == daysCount ) {
		date = [SyDateUtil nextMonth:date];
		date.day = 1;
	}
	else
		date.day++;
	
	return date;
}


+ (NSInteger)dateCompareByDay:(CFGregorianDate)aDate1 Date2:(CFGregorianDate)aDate2
{
	if ( aDate1.year > aDate2.year )
		return 1;
	else if ( aDate1.year < aDate2.year )
		return -1;
	
	if ( aDate1.month > aDate2.month )
		return 1;
	else if ( aDate1.month < aDate2.month )
		return -1;
	
	if ( aDate1.day > aDate2.day )
		return 1;
	else if ( aDate1.day < aDate2.day )
		return -1;
	
	return 0;
}


+ (NSString *)localDateByDay:(NSString *)dateStr hasTime:(BOOL)hasTime
{
    if(dateStr.length < 10 || (dateStr.length < 16 && hasTime)) return dateStr;
    CFTimeZoneRef zf = CFTimeZoneCopySystem();
    CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), zf);
    CFRelease(zf);
    CFGregorianDate refDate = [SyDateUtil stringToCFGregorianDate2:dateStr];
    
    CFGregorianDate yesterday = [SyDateUtil preDay:currentDate];
    //    CFGregorianDate beforeyesterday = [DateHelpMethods preDay:yesterday];
    CFGregorianDate tomorrow = [SyDateUtil nextDay:currentDate];
    CFGregorianDate afTomorrow = [SyDateUtil nextDay:tomorrow];
    
    NSString *result = @"";
    if ([SyDateUtil dateCompareByDay:refDate Date2:yesterday] == 0) {
        result = NSLocalizedString(@"昨天", @"昨天");
    }
    //    else if ([DateHelpMethods dateCompareByDay:refDate Date2:beforeyesterday] == 0) {
    //        result = NSLocalizedString(@"before of yesterday", @"前天");
    //    }
    else if ([SyDateUtil dateCompareByDay:refDate Date2:currentDate] == 0) {
        result = NSLocalizedString(@"今天", /*@"今天"*/nil);
    }
    else if ([SyDateUtil dateCompareByDay:refDate Date2:tomorrow] == 0) {
        result = NSLocalizedString(@"明天", @"明天");
    }
    else if ([SyDateUtil dateCompareByDay:refDate Date2:afTomorrow] == 0) {
        result = NSLocalizedString(@"后天", @"后天");
    }
    else if (currentDate.year == refDate.year) {
        //        result = [dateStr substringWithRange:NSMakeRange(5, 5)];
        result = [NSString stringWithFormat:@"%d-%d",refDate.month,refDate.day];
    }
    else {
        //        result = [dateStr substringToIndex:10];
        result = [NSString stringWithFormat:@"%ld-%d-%d",refDate.year,refDate.month,refDate.day];
        
    }
    
    if (hasTime) {
        //        return [NSString stringWithFormat:@"%@ %@", result, [dateStr substringWithRange:NSMakeRange(11, 5)]];
        NSString *timeStr = [NSString stringWithFormat:@"%d:%@",[[dateStr substringWithRange:NSMakeRange(11, 2)] integerValue],[dateStr substringWithRange:NSMakeRange(14, 2)]];
        return [NSString stringWithFormat:@"%@ %@", result,timeStr];
    }
    return result;
}


+ (NSString *)timeIntervalSinceDate:(NSDate *)startDate endDate:(NSDate *)endDate{
    NSTimeInterval aTimer = [endDate timeIntervalSinceDate:startDate];
    
    int days=((int)aTimer) / (3600 * 24);
    int hour = (int)(aTimer / 3600);
    int minute = (int)(aTimer - hour * 3600) / 60;
    int second = aTimer - hour * 3600 - minute * 60;
    NSString *str=@"";
    if(days > 0){
        if(days == 1){
            str = [NSString stringWithFormat:@"24%@",NSLocalizedString(@"hours", @"")];
        }else{
            str = [NSString stringWithFormat:@"%d%@",days,NSLocalizedString(@"day", @"")];
        }
        return str;
    }else if(hour > 0){
        str = [NSString stringWithFormat:@"%d%@",hour,NSLocalizedString(@"hours", @"")];
        return str;
    }else if(minute > 0){
        str = [NSString stringWithFormat:@"%d%@",minute,NSLocalizedString(@"minutes", @"")];
        return str;
    }else if(second > 0){
        str = [NSString stringWithFormat:@"%d%@",second,NSLocalizedString(@"seconds", @"")];
        return str;
    }
    return @"";
}

+ (NSString *)strFromDate:(NSDate *)aDate formatter:(NSString *)aFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:aFormat];
    NSString *dateStr = [dateFormatter stringFromDate:aDate];
    return dateStr;
}
+ (NSDate *)dateFromStr:(NSString *)aStr dateFormat:(NSString *)aFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:aFormat];
    NSDate *date = [dateFormatter dateFromString:aStr];
    return date;
}

+ (NSTimeInterval)currentMilliSecondSinceReferenceDate
{
    return [NSDate timeIntervalSinceReferenceDate] * 1000;
}

+ (BOOL)checkTokenValid
{
    
    if (![SyCacheManager sharedSyCacheManager].expires_in) {
        return NO;
    }
    else if (([SyCacheManager sharedSyCacheManager].expires_in - 10 * 24 * 60 * 60) <= [SyDateUtil currentMilliSecondSinceReferenceDate]) {
        return NO;
    }
    else {
        return YES;
    }
}


@end
