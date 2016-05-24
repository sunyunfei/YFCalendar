//
//  WeekCollectionView.h
//  日历最新Demo
//
//  Created by 孙云 on 16/5/23.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeekCollectionView : UICollectionView<UICollectionViewDelegate,UICollectionViewDataSource>
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *weekArray;
@end
