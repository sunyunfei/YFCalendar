//
//  YFCollectionView.h
//  日历最新Demo
//
//  Created by 孙云 on 16/5/23.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCollectionView : UICollectionView
@property(nonatomic,strong)NSDate *date;
//本月的总天数
@property(nonatomic,strong) NSMutableArray *allDayArray;
@end


/*
@interface YFHeaderView : UICollectionReusableView
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *weekArray;
@end
*/