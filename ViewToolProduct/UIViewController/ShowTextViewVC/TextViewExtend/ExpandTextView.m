//
//  ExpandTextView.m
//  FisrtProduct
//
//  Created by xuls on 16/5/3.
//  Copyright © 2016年 genvict. All rights reserved.
//

#import "ExpandTextView.h"

@interface ExpandTextView ()<UITextViewDelegate>
{
    CGFloat viewHeight;
    CGFloat viewWidth;
}
@property (nonatomic, strong) UILabel *placeholderLabel;
@property (nonatomic, strong) UILabel *limitLabel;

@end

@implementation ExpandTextView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        viewHeight = CGRectGetHeight(frame);
        viewWidth  = CGRectGetWidth(frame);
        
        self.textContainerInset = UIEdgeInsetsMake(5, 0, 5, 0);
        self.layoutManager.allowsNonContiguousLayout = NO;
        self.delegate = self;
    }
    return self;
}

#pragma mark - get method
- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        CGFloat height = [self heightOfString:_placeholderString
                                     withFont:self.font
                                withViewWidth:viewWidth - 8];
        _placeholderLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, 5, viewWidth - 8, height)];
        _placeholderLabel.backgroundColor = [UIColor clearColor];
        _placeholderLabel.textColor = [UIColor lightGrayColor];
        _placeholderLabel.font = self.font;
        _placeholderLabel.numberOfLines = 0;
        [self addSubview:_placeholderLabel];
    }
    return _placeholderLabel;
}

- (CGFloat)heightOfString:(NSString *)str
                 withFont:(UIFont *)font
            withViewWidth:(CGFloat)tempWidth {
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:font,NSFontAttributeName,nil];
    CGRect rect = [str boundingRectWithSize:CGSizeMake(tempWidth, 0)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:attributes
                                    context:nil];
    
    return rect.size.height;
}

- (UILabel *)limitLabel {
    if (!_limitLabel) {
        _limitLabel = [[UILabel alloc] initWithFrame:CGRectMake(4, viewHeight - 20, viewWidth - 8, 20)];
        _limitLabel.backgroundColor = [UIColor clearColor];
        _limitLabel.textAlignment = NSTextAlignmentRight;
        _limitLabel.font = [UIFont systemFontOfSize:13.0];
        _limitLabel.textColor = [UIColor darkGrayColor];
        [self addSubview:_limitLabel];
    }
    return _limitLabel;
}

#pragma mark - set method
- (void)setLimitCount:(NSInteger)limitCount {
    _limitCount = limitCount;
    self.limitLabel.text = [NSString stringWithFormat:@"0/%ld",_limitCount];
}

- (void)setPlaceholderString:(NSString *)placeholderString {
    _placeholderString = placeholderString;
    self.placeholderLabel.text = _placeholderString;
}

//重写
- (void)setText:(NSString *)text {
    if (text.length == 0) {
        if (_placeholderLabel) {
            _placeholderLabel.hidden = NO;
        }
    }
    else {
        if (_placeholderLabel) {
            _placeholderLabel.hidden = YES;
        }
        
        if (_limitLabel) {
            _limitLabel.text = [NSString stringWithFormat:@"%ld/%ld",text.length,_limitCount - text.length];
        }
    }
    super.text = text;
    [self scrollRangeToVisible:NSMakeRange(self.text.length - 1, 1)];
    
    CGFloat tempHeight = [self heightOfString:self.text
                                     withFont:self.font
                                withViewWidth:viewWidth - 8];
    if (viewHeight - 20 < tempHeight) {
        _limitLabel.frame = CGRectMake(CGRectGetMinX(_limitLabel.frame), tempHeight - 12, CGRectGetWidth(_limitLabel.frame), CGRectGetHeight(_limitLabel.frame));
    }
}

#pragma mark - 监听机制
- (void)addObserver {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(didChangeWhenTextView:)
                                                 name:UITextViewTextDidChangeNotification
                                               object:nil];
}

- (void)didChangeWhenTextView:(NSNotification *)notification {
    if (_placeholderLabel) {
        if (self.text.length != 0) {  //有内容时，隐藏占位符
            _placeholderLabel.hidden = YES;
        }
        else {   //显示占位符
            _placeholderLabel.hidden = NO;
        }
    }
    
    if (_limitLabel) { //限制字数
        if (self.text.length > _limitCount) { //由于键盘联想问题，导致内容过多
            self.text = [self.text substringToIndex:_limitCount];
        }
        
        CGFloat tempHeight = [self heightOfString:self.text
                                         withFont:self.font
                                    withViewWidth:viewWidth - 8];
        if (viewHeight - 20 < tempHeight) {
            _limitLabel.frame = CGRectMake(CGRectGetMinX(_limitLabel.frame), tempHeight - 12, CGRectGetWidth(_limitLabel.frame), CGRectGetHeight(_limitLabel.frame));
        }
        else {
            _limitLabel.frame = CGRectMake(CGRectGetMinX(_limitLabel.frame), viewHeight - 20, CGRectGetWidth(_limitLabel.frame), CGRectGetHeight(_limitLabel.frame));
        }
        _limitLabel.text = [NSString stringWithFormat:@"%lu/%lu", self.text.length, _limitCount - self.text.length];
    }
}

//取消监听
- (void)removeobserver {
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextViewTextDidEndEditingNotification
                                                  object:nil];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidBeginEditing:(UITextView *)textView {
    [self addObserver];
}

- (void)textViewDidEndEditing:(UITextView *)textView {
    [self removeobserver];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    if ([text isEqualToString:@""]) { //删除时
        return YES;
    }
    
    if (_limitLabel) {
        if ((textView.text.length + text.length - range.length) > _limitCount) { //解决输入表情时出现的问题
            return NO;
        }
    }
    
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
