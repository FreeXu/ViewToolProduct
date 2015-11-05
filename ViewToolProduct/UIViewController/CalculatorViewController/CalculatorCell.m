//
//  CalculatorCell.m
//  ViewToolProduct
//
//  Created by 一卡易 on 15/11/5.
//  Copyright © 2015年 1card1. All rights reserved.
//

#import "CalculatorCell.h"

@implementation CalculatorCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //初始化数据
        view_height = CGRectGetHeight(frame);
        view_width  = CGRectGetWidth(frame);
        
        //按钮初始化
        _contentButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _contentButton.frame = CGRectMake(0, 0, view_width, view_height);
        _contentButton.backgroundColor = [UIColor whiteColor];
        [_contentButton setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
        _contentButton.titleLabel.font = [UIFont systemFontOfSize:18.0];
        _contentButton.titleLabel.numberOfLines = 0;
        [self.contentView addSubview:_contentButton];
        [_contentButton addTarget:self action:@selector(btnAction_click:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return self;
}

//点击按钮操作
- (void)btnAction_click:(UIButton *)btn {
    if (self.delegate && [self.delegate respondsToSelector:@selector(sendButtonContent:buttonType:)]) {
        if ([btn.currentTitle isEqualToString:@"清空"]) {
            [self.delegate sendButtonContent:[btn currentTitle] buttonType:ClearType];
        }
        else if ([btn.currentTitle isEqualToString:@"删除"]) {
            [self.delegate sendButtonContent:[btn currentTitle] buttonType:DeleteType];
        }
        else if ([btn.currentTitle isEqualToString:@"＋"]) {
            btn.tag = AddType;
            btn.backgroundColor = [UIColor lightGrayColor];
            [self.delegate sendButtonContent:[btn currentTitle] buttonType:AddType];
        }
        else if ([btn.currentTitle isEqualToString:@"－"]) {
            btn.tag = MinusType;
            btn.backgroundColor = [UIColor lightGrayColor];
            [self.delegate sendButtonContent:[btn currentTitle] buttonType:MinusType];
        }
        else if ([btn.currentTitle isEqualToString:@"×"]) {
            btn.tag = MultipyType;
            btn.backgroundColor = [UIColor lightGrayColor];
            [self.delegate sendButtonContent:[btn currentTitle] buttonType:MultipyType];
        }
        else if ([btn.currentTitle isEqualToString:@"÷"]) {
            btn.tag = DivideType;
            btn.backgroundColor = [UIColor lightGrayColor];
            [self.delegate sendButtonContent:[btn currentTitle] buttonType:DivideType];
        }
        else if ([btn.currentTitle isEqualToString:@"收"]) {
            [self.delegate sendButtonContent:[btn currentTitle] buttonType:SureType];
        }
        else if ([btn.currentTitle isEqualToString:@"款"]) {
            [self.delegate sendButtonContent:[btn currentTitle] buttonType:SureType];
        }
        else {
            [self.delegate sendButtonContent:[btn currentTitle] buttonType:OtherType];
        }
    }
}

@end
