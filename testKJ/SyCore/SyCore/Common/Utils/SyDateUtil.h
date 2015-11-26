//
//  SyDateUtil.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyDateUtil : NSObject

/*
 *  hasTime: 是否有时间
 */
+ (NSString *)localDateByDay:(NSString *)dateStr hasTime:(BOOL)hasTime;
// 某个月 的天数
+ (int)getDayCountOfaMonth:(CFGregorianDate)date;
// 某日期的 前个月
+ (CFGregorianDate)preMonth:(CFGregorianDate)date;
+ (CFGregorianDate)nextMonth:(CFGregorianDate)date;

+ (CFGregorianDate)nextDay:(CFGregorianDate)date;
+ (CFGregorianDate)preDay:(CFGregorianDate)date;
// 
+ (NSString *)strFromDate:(NSDate *)aDate formatter:(NSString *)aFormat;
+ (NSDate *)dateFromStr:(NSString *)aStr dateFormat:(NSString *)aFormat;

//String 转换 CFGregorianDate
+ (CFGregorianDate)stringToCFGregorianDate2:(NSString*)aStr;

//时间对比
+ (NSString *)timeIntervalSinceDate:(NSDate *)startDate endDate:(NSDate *)endDate;

#pragma mark- 当前时间的毫秒值
+ (NSTimeInterval)currentMilliSecondSinceReferenceDate;
+ (BOOL)checkTokenValid;



@end
