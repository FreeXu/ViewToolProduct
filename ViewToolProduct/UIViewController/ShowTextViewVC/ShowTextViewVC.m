//
//  ShowTextViewVC.m
//  ViewToolProduct
//
//  Created by xuls on 16/6/18.
//  Copyright © 2016年 1card1. All rights reserved.
//

#import "ShowTextViewVC.h"
#import "ExpandTextView.h"

@interface ShowTextViewVC ()

@end

@implementation ShowTextViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    ExpandTextView *expandTextView  = [[ExpandTextView alloc] initWithFrame:CGRectMake(50, 80, 100, 180)];
    expandTextView.font = [UIFont systemFontOfSize:14.0];
    expandTextView.limitCount = 100;
    expandTextView.placeholderString = @"请输入";
    [self.view addSubview:expandTextView];
    expandTextView.text = @"ddd电话是多少大世界的大声说出输出是出口市场爱打架的话";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
