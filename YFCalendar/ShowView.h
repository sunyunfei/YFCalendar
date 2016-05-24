//
//  ShowView.h
//  日历最新Demo
//
//  Created by 孙云 on 16/5/23.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ShowView : UIView<UIScrollViewDelegate>
- (IBAction)clickPreBtn:(UIButton *)sender;//点击前一个按钮
- (IBAction)clickNextBtn:(UIButton *)sender;//点击后一个按钮
@property (weak, nonatomic) IBOutlet UIButton *centerBtn;//中间按钮
- (IBAction)clickCenterBtn:(UIButton *)sender;//点击中间按钮
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView; //滑块
+ (instancetype)createView; //创建
@end
