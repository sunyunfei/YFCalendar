//
//  YFCollectionView.m
//  日历最新Demo
//
//  Created by 孙云 on 16/5/23.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "YFCollectionView.h"
#import "YFCell.h"
#import "NSObject+CalenderSet.h"
#import "SSLunarDate.h"
@interface YFCollectionView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation YFCollectionView
/**
 *  init
 *
 */
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout{

    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        _allDayArray = [NSMutableArray array];
        self.delegate = self;
        self.dataSource = self;
        self.backgroundColor = [UIColor whiteColor];
        //set layout
        [self setLayOut];
        // register
        [self registerClass:[YFCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return self;
}
- (void)setAllDayArray:(NSMutableArray *)allDayArray{

    _allDayArray = allDayArray;
    [self reloadData];
}
/**
 *  set lauOut
 */
- (void)setLayOut{

    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.itemSize = CGSizeMake(self.frame.size.width / 7, self.frame.size.height / 7);
    layOut.minimumLineSpacing = 0.0;
    layOut.minimumInteritemSpacing = 0.0;
    [self setCollectionViewLayout:layOut];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return 35;

}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    YFCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    NSDictionary *dic = self.allDayArray[indexPath.row];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@",dic[@"day"]];
    //农历，需要判断月份，年份
    __weak typeof(self)weakSelf = self;
   __block NSString *lunarStr;
    if ([dic[@"status"] isEqualToString:@"pre"]) {//上一个月
        [self changeCurrentMonth:_date andIndex:-1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            
            SSLunarDate *sdate = [weakSelf lunarDaysString:nowDate int:[dic[@"day"] intValue]];
            lunarStr = [NSString stringWithFormat:@"%@",[sdate dayString]];
        }];
    }else if ([dic[@"status"] isEqualToString:@"next"]){//下一个月
    
        [self changeCurrentMonth:_date andIndex:1 resultData:^(NSDate *nowDate, NSString *showMonth) {
            
            SSLunarDate *sdate = [weakSelf lunarDaysString:nowDate int:[dic[@"day"] intValue]];
            lunarStr = [NSString stringWithFormat:@"%@",[sdate dayString]];
        }];
    }else{
    
        SSLunarDate *sdate = [self lunarDaysString:_date int:[dic[@"day"] intValue]];
        lunarStr = [NSString stringWithFormat:@"%@",[sdate dayString]];
    }
    cell.lunarLabel.text = lunarStr;
    return cell;
}
/**
 *  选择单元格
 *
 *  @param collectionView <#collectionView description#>
 *  @param indexPath      <#indexPath description#>
 */
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dic = self.allDayArray[indexPath.row];
    NSLog(@"%li年 %i月 %i日 ",(long)[self currentYear:_date],[dic[@"month"] intValue],[dic[@"day"] intValue]);
}
@end

/*
#pragma mark  ---------------------------------YFHeaderView
@interface YFHeaderView()<UICollectionViewDelegate,UICollectionViewDataSource>

@end
@implementation YFHeaderView
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        self.weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        [self initCollectionView];
    }
    return self;
}
- (void)initCollectionView{

    _collectionView = [[UICollectionView alloc]initWithFrame:self.frame collectionViewLayout:[[UICollectionViewFlowLayout alloc]init]];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    [self addSubview:_collectionView];
    [self setLayOut];
}

- (void)setLayOut{

    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.itemSize = CGSizeMake(self.frame.size.width / 7, self.frame.size.height);
    layOut.minimumLineSpacing = 0.0;
    layOut.minimumInteritemSpacing = 0.0;
    [_collectionView setCollectionViewLayout:layOut];
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{

    return self.weekArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    //add label show
    UILabel *label = [[UILabel alloc]initWithFrame:cell.contentView.frame];
    label.textAlignment = NSTextAlignmentCenter;
    label.font = [UIFont systemFontOfSize:14.0f];
    label.textColor = [UIColor colorWithRed:1.0 green:0.4075 blue:0.3979 alpha:1.0];
    [cell.contentView addSubview:label];
    label.text = self.weekArray[indexPath.row];

    return cell;
}

@end
*/
