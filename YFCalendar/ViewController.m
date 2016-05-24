//
//  ViewController.m
//  YFCalendar
//
//  Created by 孙云 on 16/5/24.
//  Copyright © 2016年 haidai. All rights reserved.
//

#import "ViewController.h"
#import "ShowView.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ShowView *showView = [ShowView createView];
    [self.view addSubview:showView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
