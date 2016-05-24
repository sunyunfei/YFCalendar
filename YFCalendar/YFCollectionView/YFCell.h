//
//  YFCell.h
//  日历最新Demo
//
//  Created by 孙云 on 16/5/23.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFCell : UICollectionViewCell
@property(nonatomic,strong)UILabel *dateLabel;//solar calendar
@property(nonatomic,strong)UILabel *lunarLabel;//lunar calendar
@property(nonatomic,strong)UIView *bgView;//background view
@end
