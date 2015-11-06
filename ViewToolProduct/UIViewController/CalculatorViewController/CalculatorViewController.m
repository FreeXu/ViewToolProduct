//
//  CalculatorViewController.m
//  ViewToolProduct
//
//  Created by 一卡易 on 15/11/5.
//  Copyright © 2015年 1card1. All rights reserved.
//

#import "CalculatorViewController.h"
#import "CalculatorCell.h"

@interface CalculatorViewController ()<UICollectionViewDataSource,UICollectionViewDelegate,CalculatorCellDelegate>
{
    UICollectionView *cv_calculator;
    UILabel *label_showResult;//展示输入结果
    
    NSArray *array_num;//计算器数组
    CGFloat view_width; //屏幕的宽度
    CGFloat view_height;//屏幕的高度
    CGFloat height_button;//计算器按钮的高度
    CGFloat width_button;//计算器按钮的宽度
    
    NSMutableString *string_firstNum; //第一次输入的数
    NSMutableString *string_secondNum; //第二次输入的数
    NSInteger type_saved; //保存点击过得算法
}
@end

@implementation CalculatorViewController

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"计算器";
    self.view.backgroundColor = [UIColor grayColor];
    
    //数据初始化
    view_height = CGRectGetHeight(self.view.frame);
    view_width  = CGRectGetWidth(self.view.frame);
    height_button = 80.0;
    width_button  = (view_width - 2.0) / 4.0;
    array_num = @[@"清空", @"＋", @"－", @"删除", @"7", @"8", @"9", @"×", @"4", @"5", @"6", @"÷", @"1", @"2", @"3", @"收", @"0", @".", @"款"];
    string_firstNum  = [NSMutableString stringWithFormat:@"0"];
    string_secondNum = [NSMutableString stringWithFormat:@"0"];
    type_saved = OtherType;
    
    //显示结果控件
    label_showResult = [[UILabel alloc] initWithFrame:CGRectMake(10, view_height - 5 * height_button - 20 - 80, view_width - 20, 80)];
    label_showResult.backgroundColor = [UIColor clearColor];
    label_showResult.textAlignment = NSTextAlignmentRight;
    label_showResult.textColor = [UIColor whiteColor];
    label_showResult.font = [UIFont systemFontOfSize:30.0];
    label_showResult.numberOfLines = 0;
    [self.view addSubview:label_showResult];
    label_showResult.text = @"0";
    
    //界面初始化
    [self initCurrentView];
}


#pragma mark - 方法一
#pragma mark 计算器界面初始化
- (void)initCurrentView {
    //UICollectionView初始化
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [flowLayout setMinimumInteritemSpacing:0.5]; //各元素x之间的距离
    [flowLayout setMinimumLineSpacing:1.0]; //各元素y之间的距离
    
    cv_calculator = [[UICollectionView alloc] initWithFrame:CGRectMake(0, view_height - 5 * height_button, view_width, 5 * height_button) collectionViewLayout:flowLayout];
    cv_calculator.dataSource = self;
    cv_calculator.delegate = self;
    cv_calculator.backgroundColor = [UIColor clearColor];
    cv_calculator.allowsMultipleSelection = NO; //是否可以多选
    cv_calculator.scrollEnabled = NO;
    [cv_calculator registerClass:[CalculatorCell class] forCellWithReuseIdentifier:@"UICollectionViewCellOne"];
    [self.view addSubview:cv_calculator];
}

#pragma mark - UICollectionViewDataSource
//定义展示的Section的个数
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

//定义展示的UICollectionViewCell的个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return array_num.count;
}

//每个UICollectionView展示的内容
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    static NSString * CellIdentifier = @"UICollectionViewCellOne";
    CalculatorCell * cell = (CalculatorCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    cell.delegate = self;
    
    NSString *title = [array_num objectAtIndex:indexPath.row];
    [cell.contentButton setTitle:title forState:UIControlStateNormal];
    cell.contentButton.frame = CGRectMake(0, 0, width_button, height_button);
    cell.contentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    cell.contentButton.backgroundColor = [UIColor whiteColor];
    if (indexPath.row == 15) {
        cell.contentButton.frame = CGRectMake(0, 0, width_button, height_button + 1);
        cell.contentButton.titleEdgeInsets = UIEdgeInsetsMake(height_button / 2, 0, 0, 0);
    }
    else if (indexPath.row == 16) {
        cell.contentButton.frame = CGRectMake(0, 0, 2 * width_button + 0.5, height_button);
    }
    else if (indexPath.row == 18) {
        cell.contentButton.frame = CGRectMake(0, -1, width_button, height_button + 1);
        cell.contentButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, height_button / 2, 0);
    }
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 16) {
        return CGSizeMake(2 * width_button + 1.0, height_button);
    }
    
    return CGSizeMake(width_button, height_button);
}

//定义每个UICollectionView 的 margin
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

#pragma mark - UICollectionViewDelegate
//UICollectionView被选中时调用的方法
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Section:%ld Index:%ld",indexPath.section,indexPath.row);
}

//返回这个UICollectionView是否可以被选择
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

#pragma mark 处理被选中，取消选中
- (void)cancelSelectingSatae:(NSInteger)btnType {
    NSInteger index = 1000;
    switch (btnType) {
        case AddType:
            index = 1;
            break;
        case MinusType:
            index = 2;
            break;
        case MultipyType:
            index = 7;
            break;
        case DivideType:
            index = 11;
            break;
            
        default:
            break;
    }
    if (index != 1000) {
        CalculatorCell *cell = (CalculatorCell *)[cv_calculator cellForItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0]];
        cell.contentButton.backgroundColor = [UIColor whiteColor];
    }
}

#pragma mark - CalculatorCellDelegate  处理选中情况
- (void)sendButtonContent:(NSString *)content buttonType:(ButtonType)type {
    //NSLog(@"%@",content);
    NSString *showStr = label_showResult.text;
    switch (type) {
        case ClearType:
            [cv_calculator reloadData];
            type_saved = OtherType;
            string_firstNum = [NSMutableString stringWithFormat:@"0"];
            string_secondNum = [NSMutableString stringWithFormat:@"0"];
            showStr = string_firstNum;
            
            break;
        case DeleteType:
            if (type_saved == OtherType) {
                string_firstNum = [self whenDeletingDealOriginString:string_firstNum];
                showStr = string_firstNum;
            }
            else {
                string_secondNum = [self whenDeletingDealOriginString:string_secondNum];
                showStr = string_secondNum;
            }
            
            break;
        case AddType:
            [self cancelSelectingSatae:type_saved];
            type_saved = AddType;
            break;
        case MinusType:
            [self cancelSelectingSatae:type_saved];
            type_saved = MinusType;
            break;
        case MultipyType:
            [self cancelSelectingSatae:type_saved];
            type_saved = MultipyType;
            break;
        case DivideType:
            [self cancelSelectingSatae:type_saved];
            type_saved = DivideType;
            break;
        case SureType:
            [cv_calculator reloadData];
            if (type_saved != OtherType) {
                showStr = [self whenSureShowResult];
                type_saved = OtherType;
                string_firstNum = [NSMutableString stringWithFormat:@"%@",showStr];
                string_secondNum = [NSMutableString stringWithFormat:@"0"];
            }
            
            break;
        case OtherType:
            if (type_saved == OtherType) {
                string_firstNum = [self whenEnteringDealStringData:content originString:string_firstNum];
                showStr = string_firstNum;
            }
            else {
                string_secondNum = [self whenEnteringDealStringData:content originString:string_secondNum];
                showStr = string_secondNum;
            }
            
            break;
            
        default:
            break;
    }
    label_showResult.text = showStr;
}

#pragma mark 确定时，输出结果
- (NSString *)whenSureShowResult {
    CGFloat firstNum  = [string_firstNum floatValue];
    CGFloat secondNum = [string_secondNum floatValue];
    
    CGFloat result = 0;
    switch (type_saved) {
        case AddType:
            result = firstNum + secondNum;
            break;
        case MinusType:
            result = firstNum - secondNum;
            break;
        case MultipyType:
            result = firstNum * secondNum;
            break;
        case DivideType:
            if (secondNum != 0) {
                result = firstNum / secondNum;
            }
            break;
            
        default:
            break;
    }
    NSString *backString = [NSString stringWithFormat:@"%f",result];
    return backString;
}

#pragma mark 删除时，怎么处理显示的数字
- (NSMutableString *)whenDeletingDealOriginString:(NSMutableString *)backStr {
    if (backStr.length > 1) {
        backStr = [NSMutableString stringWithFormat:@"%@",[backStr substringToIndex:backStr.length - 1]];
    }
    else {
        backStr = [NSMutableString stringWithFormat:@"0"];
    }
    
    return backStr;
}

#pragma mark 输入时，怎么处理显示的数字
/**
 * @content  输入的数字
 * @backStr  保存数字的容器
 */
- (NSMutableString *)whenEnteringDealStringData:(NSString *)content originString:(NSMutableString *)backStr {
    if (backStr.length >= 10) { //限制输入个数
        return backStr;
    }
    
    if ([content isEqualToString:@"."]) {
        if (![backStr localizedCaseInsensitiveContainsString:@"."]) {
            [backStr appendFormat:@"%@",content];
        }
    }
    else {
        if ([backStr isEqualToString:@"0"]) {
            backStr = [NSMutableString stringWithFormat:@"%@",content];
        }
        else {
            [backStr appendFormat:@"%@",content];
        }
    }
    
    return backStr;
}

@end
