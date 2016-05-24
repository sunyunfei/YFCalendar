//
//  WeekCollectionView.m
//  日历最新Demo
//
//  Created by 孙云 on 16/5/23.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "WeekCollectionView.h"

@implementation WeekCollectionView
/**
 *  init
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder{

    self = [super initWithCoder:aDecoder];
    if (self) {
        self.weekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        self.backgroundColor = [UIColor whiteColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
        [self setLayOut];
    }
    return self;
}
/**
 *  set flowlayout
 */
- (void)setLayOut{
    
    UICollectionViewFlowLayout *layOut = [[UICollectionViewFlowLayout alloc]init];
    layOut.itemSize = CGSizeMake(self.frame.size.width / 7, self.frame.size.height);
    layOut.minimumLineSpacing = 0.0;
    layOut.minimumInteritemSpacing = 0.0;
    [self setCollectionViewLayout:layOut];
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
