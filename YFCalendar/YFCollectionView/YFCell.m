//
//  YFCell.m
//  日历最新Demo
//
//  Created by 孙云 on 16/5/23.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "YFCell.h"

@implementation YFCell
- (instancetype)initWithFrame:(CGRect)frame{

    self = [super initWithFrame:frame];
    if (self) {
        
       //init label
        [self initUI];
    }
    return self;
}
/**
 *   init label
 */
- (void)initUI{

    _bgView = [[UIView alloc]initWithFrame:CGRectMake(2, 2, self.frame.size.width - 2, self.frame.size.height - 2)];
//    _bgView.backgroundColor = [UIColor lightGrayColor];
    [self.contentView addSubview:_bgView];
    
    _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, _bgView.frame.size.width, _bgView.frame.size.height / 2 + 5)];
    _dateLabel.textAlignment = NSTextAlignmentCenter;
    _dateLabel.font = [UIFont systemFontOfSize:12];
//    _dateLabel.backgroundColor = [UIColor redColor];
    [_bgView addSubview:_dateLabel];
    
    _lunarLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _bgView.frame.size.height / 2 + 5, _bgView.frame.size.width, _bgView.frame.size.height / 2 - 5)];
    _lunarLabel.textAlignment = NSTextAlignmentCenter;
    _lunarLabel.font = [UIFont systemFontOfSize:11];
//    _lunarLabel.backgroundColor = [UIColor blueColor];
    [_bgView addSubview:_lunarLabel];
}
@end
