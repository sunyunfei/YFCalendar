//
//  NSObject+CalenderSet.h
//  日历相关
//
//  Created by 孙云 on 16/5/11.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SSLunarDate.h"
@interface NSObject (CalenderSet)
- (NSInteger)currentYear:(NSDate *)date;//获得当前的年份
- (NSInteger)currentMonth:(NSDate *)date;//获得当前的月份
- (NSInteger)currentDay:(NSDate *)date;//获得当前是哪一天
- (NSInteger)currentMonthOfDay:(NSDate *)date;//获得本月有多少天
- (NSInteger)preInMonth:(NSDate *)date;//获得上个月月份
- (NSInteger)nextMonth:(NSDate *)date;//获得下个月月份
- (NSInteger)preInMonthDay:(NSDate *)date;//获得上个月有多少天
- (NSInteger)currentFirstDay:(NSDate *)date;//获得这个月份第一天是在星期几
- (NSMutableArray *)currentMonthArray:(NSDate *)date;//获得这个月排布数组
- (void)changeCurrentMonth:(NSDate *)date andIndex:(int)index resultData:(void(^)(NSDate *nowDate,NSString *showMonth))block;//获得上个月或者下个月的对应的nsdate和字符串
- (SSLunarDate *)lunarDaysString:(NSDate *)date int:(int)nowIndex;//获取对应的农历
@end
