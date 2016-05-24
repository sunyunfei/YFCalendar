//
//  NSObject+CalenderSet.m
//  日历相关
//
//  Created by 孙云 on 16/5/11.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "NSObject+CalenderSet.h"

@implementation NSObject (CalenderSet)
/**
 *  获取当前月的年份
 */
- (NSInteger)currentYear:(NSDate *)date{
    
    NSDateComponents *componentsYear = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [componentsYear year];
}
/**
 *  获取当前月的月份
 */
- (NSInteger)currentMonth:(NSDate *)date{
    
    NSDateComponents *componentsMonth = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [componentsMonth month];
}
/**
 *  获取当前是哪一天
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)currentDay:(NSDate *)date{
    
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}
/**
 *  本月有几天
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)currentMonthOfDay:(NSDate *)date{
    
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}
/**
 *  本月的上一个月是第几个月
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)preInMonth:(NSDate *)date{
    //获取这个月月份
    NSInteger currentMonth = [self currentMonth:date];
    NSInteger preMonth;
    //判断上一个月是哪个月份
    if (currentMonth == 1) {
        preMonth = 12;
    }else{
        
        preMonth = currentMonth - 1;
    }
    return preMonth;
}
/**
 *  本月的下一个月是第几个月
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)nextMonth:(NSDate *)date{
    
    //获取这个月月份
    NSInteger currentMonth = [self currentMonth:date];
    NSInteger preMonth;
    //判断下一个月是哪个月份
    if (currentMonth == 12) {
        preMonth = 1;
    }else{
        
        preMonth = currentMonth + 1;
    }
    return preMonth;
}
/**
 *  上一个月是有多少天数
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)preInMonthDay:(NSDate *)date{
    
    NSInteger currnetYear = [self currentYear:date];
    NSInteger preMonth = [self preInMonth:date];
    //判断年份是不是闰年
    if (preMonth == 1 || preMonth == 3 || preMonth == 5 || preMonth == 7 || preMonth == 8 || preMonth == 10 || preMonth == 12) {
        return 31;
    }else if(preMonth == 2){
        //如果是闰年并且这个月份正好是二月份
        if(((currnetYear % 4 == 0) && (currnetYear % 100 == 0)) || (currnetYear % 400 == 0)){
            
            return 29;
        }else{
            
            return 28;
        }
    }else{
        
        return 30;
    }
}
/**
 *  本月第一天是星期几
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSInteger)currentFirstDay:(NSDate *)date{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    //    [calendar setFirstWeekday:2];//1.mon
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}
/**
 *  获得对应月份的天数数组
 *
 *  @param date <#date description#>
 *
 *  @return <#return value description#>
 */
- (NSMutableArray *)currentMonthArray:(NSDate *)date{

    NSMutableArray *dayArray = [NSMutableArray array];
    //获取上一个月是第几个月
    NSInteger preMonth = [self preInMonth:date];
    //获取上一个月天数
    NSInteger preDay = [self preInMonthDay:date];
    //获取下一个月是第几个月
    NSInteger nextMonth = [self nextMonth:date];
    
    //当月月份
    NSInteger currentMonth = [self currentMonth:date];
    
    NSInteger day = [self currentFirstDay:date];
    for (NSInteger i = 0; i < day; i++){
        //存入字典
        NSDictionary *preDic = @{@"month":@(preMonth),@"day":@(preDay - day + i + 1),@"status":@"pre"};
        [dayArray addObject:preDic];
    }
    
    NSInteger days = [self currentMonthOfDay:date];
    
    for (NSInteger i = 1; i <= days; i++) {
        //存入字典
        NSDictionary *currentDic = @{@"month":@(currentMonth),@"day":@(i),@"status":@"current"};
        [dayArray addObject:currentDic];
    }
    //把剩下的空间置为空
    int lastCount = 1;
    for (NSInteger i = dayArray.count; i < 42; i ++) {
        //存入字典
        NSDictionary *nextDic = @{@"month":@(nextMonth),@"day":@(lastCount),@"status":@"next"};
        [dayArray addObject:nextDic];
        lastCount ++;
    }
    return dayArray;
}
/**
 *  获得对应的nsdate和显示的年份月份
 *
 */
- (void)changeCurrentMonth:(NSDate *)date andIndex:(int)index resultData:(void(^)(NSDate *nowDate,NSString *showMonth))block{

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = index;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    if (block) {
        block(newDate,[NSString stringWithFormat:@"%li年%li月",(long)[self currentYear:newDate],(long)[self currentMonth:newDate]]);
    }
    
}
/**
 *  获取对应的农历
 *
 *  @return <#return value description#>
 */
- (SSLunarDate *)lunarDaysString:(NSDate *)date int:(int)nowIndex{

    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    
    //设置天数
    [dateComponents setDay:nowIndex];
    
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    SSLunarDate *lunar = [[SSLunarDate alloc] initWithDate:newDate];
    return lunar;
}
@end
