//
//  CalculatorCell.h
//  ViewToolProduct
//
//  Created by 一卡易 on 15/11/5.
//  Copyright © 2015年 1card1. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    ClearType = 100, //清空按钮
    DeleteType, //删除按钮
    AddType, //加号按钮
    MinusType, //减号
    MultipyType, //乘号
    DivideType,  //除号
    SureType, //确定按钮
    OtherType //其他
    
} ButtonType;

@protocol CalculatorCellDelegate <NSObject>

@optional

//传递按钮的值
- (void)sendButtonContent:(NSString *)content buttonType:(ButtonType)type;

@end

@interface CalculatorCell : UICollectionViewCell
{
    CGFloat view_width; //cell的宽度
    CGFloat view_height;//cell的高度
}
@property (nonatomic, weak) id<CalculatorCellDelegate> delegate;
@property (nonatomic, strong) UIButton *contentButton;

@end
