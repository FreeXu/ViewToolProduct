//
//  HomeViewController.m
//  ViewToolProduct
//
//  Created by 一卡易 on 15/11/5.
//  Copyright © 2015年 1card1. All rights reserved.
//

#import "HomeViewController.h"
#import "CalculatorViewController.h"
#import "ShowTextViewVC.h"

@interface HomeViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    CGFloat view_width;
    CGFloat view_height;
    NSArray *array_list;
}
@end

@implementation HomeViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"主页";
    self.view.backgroundColor = [UIColor whiteColor];
    
    //数据初始化
    view_width  = CGRectGetWidth(self.view.frame);
    view_height = CGRectGetHeight(self.view.frame);
    array_list = [NSArray arrayWithObjects:@"计算器", @"textView扩展", nil];
    
    //界面布局
    UITableView *tableView_list = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, view_width, view_height)];
    tableView_list.dataSource = self;
    tableView_list.delegate = self;
    tableView_list.backgroundColor = [UIColor whiteColor];
    //tableView_list.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:tableView_list];
}

#pragma mark - UITableView datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return array_list.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identify = @"CellIdentify";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identify];
    }
    cell.textLabel.text = array_list[indexPath.row];
    
    return cell;
}

#pragma mark - UITableView Delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0) {
        CalculatorViewController *calculatorVC = [[CalculatorViewController alloc] init];
        [self.navigationController pushViewController:calculatorVC animated:YES];
    }
    else if (indexPath.row == 1) {
        ShowTextViewVC *showTVVC = [[ShowTextViewVC alloc] init];
        [self.navigationController pushViewController:showTVVC animated:YES];
    }
}

@end
