//
//  ShowView.m
//  日历最新Demo
//
//  Created by 孙云 on 16/5/23.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "ShowView.h"
#import "YFCollectionView.h"
#import "NSObject+CalenderSet.h"
@interface ShowView()
@property(nonatomic,strong)NSDate *date;
@property(nonatomic,strong)YFCollectionView *leftCollectionView;//左侧
@property(nonatomic,strong)YFCollectionView *centerCollectionView;//中间
@property(nonatomic,strong)YFCollectionView *rightCollectionView;//右侧
@end
@implementation ShowView
/**
 *  init
 *
 *  @return <#return value description#>
 */
+ (instancetype)createView{

    return [[[NSBundle mainBundle]loadNibNamed:@"ShowView" owner:nil options:nil] lastObject];
}
/**
 *  set view
 */
- (void)awakeFromNib{

    _date = [[NSDate alloc]init];
    //显示的日期
    [_centerBtn setTitle:[NSString stringWithFormat:@"%li年 %li月 %li日",[self currentYear:_date],[self currentMonth:_date],[self currentDay:_date]] forState:UIControlStateNormal];
    
    _scrollView.pagingEnabled = YES;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake(3 * _scrollView.frame.size.width, 0);
    // add collectionview
    for (int i = 0; i < 3; i ++) {
        YFCollectionView *collectionView = [[YFCollectionView alloc]initWithFrame:CGRectMake(i * _scrollView.frame.size.width, 0, _scrollView.frame.size.width, _scrollView.frame.size.height) collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
        collectionView.tag = i + 1001;
        [self.scrollView addSubview:collectionView];
    }
    self.leftCollectionView = (YFCollectionView *)[self viewWithTag:1001];
    self.centerCollectionView = (YFCollectionView *)[self viewWithTag:1002];
    self.rightCollectionView = (YFCollectionView *)[self viewWithTag:1003];
    //数据
    self.centerCollectionView.date = _date;
    self.centerCollectionView.allDayArray = [self currentMonthArray:_date];
    
    //左侧
    [self changeCurrentMonth:_date andIndex:-1 resultData:^(NSDate *nowDate, NSString *showMonth) {
        self.leftCollectionView.date = nowDate;
        self.leftCollectionView.allDayArray = [self currentMonthArray:nowDate];
    }];
    
    //右侧
    [self changeCurrentMonth:_date andIndex:1 resultData:^(NSDate *nowDate, NSString *showMonth) {
        self.rightCollectionView.date = nowDate;
        self.rightCollectionView.allDayArray = [self currentMonthArray:nowDate];
    }];
    
    
    self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
    
}
/**
 * click pre btn
 *
 *  @param sender <#sender description#>
 */
- (IBAction)clickPreBtn:(UIButton *)sender {
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x - self.scrollView.frame.size.width, 0) animated:YES];
}
/**
 *  clicknext btn
 *
 *  @param sender <#sender description#>
 */
- (IBAction)clickNextBtn:(UIButton *)sender {
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentOffset.x + self.scrollView.frame.size.width, 0) animated:YES];
}
/**
 *  click center btn
 *
 *  @param sender <#sender description#>
 */
- (IBAction)clickCenterBtn:(UIButton *)sender {
}
/**
 *  scrollview delegate
 *
 */
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{

    //判断
    if (self.scrollView.contentOffset.x <= 0) {
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
        //数据重新赋予
        //中间数据
        __weak typeof(self)weakSelf = self;
        [self changeCurrentMonth:_date andIndex:-1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            self.centerCollectionView.date = nowDate;
            self.centerCollectionView.allDayArray = [self currentMonthArray:nowDate];
            
            [weakSelf.centerBtn setTitle:showMonth forState:UIControlStateNormal];
            weakSelf.date = nowDate;
            
        }];
        
        
        //左侧
        [self changeCurrentMonth:_date andIndex:-1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            self.leftCollectionView.date = nowDate;
            self.leftCollectionView.allDayArray = [self currentMonthArray:nowDate];
        }];
        
        //右侧
        [self changeCurrentMonth:_date andIndex:1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            self.rightCollectionView.date = nowDate;
            self.rightCollectionView.allDayArray = [self currentMonthArray:nowDate];
        }];
    }else if (self.scrollView.contentOffset.x >= self.scrollView.frame.size.width * 2.0){
    
        self.scrollView.contentOffset = CGPointMake(self.scrollView.frame.size.width, 0);
        //数据重新赋予
        //中间数据
        __weak typeof(self)weakSelf = self;
        [self changeCurrentMonth:_date andIndex:1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            self.centerCollectionView.date = nowDate;
            self.centerCollectionView.allDayArray = [self currentMonthArray:nowDate];
            [weakSelf.centerBtn setTitle:showMonth forState:UIControlStateNormal];
            
            weakSelf.date = nowDate;
        }];
        
        
        //左侧
        [self changeCurrentMonth:_date andIndex:-1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            self.leftCollectionView.date = nowDate;
            self.leftCollectionView.allDayArray = [self currentMonthArray:nowDate];
        }];
        
        //右侧
        [self changeCurrentMonth:_date andIndex:1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            self.rightCollectionView.date = nowDate;
            self.rightCollectionView.allDayArray = [self currentMonthArray:nowDate];
        }];
    }
}
@end
