//
//  ExpandTextView.h
//  FisrtProduct
//
//  Created by xuls on 16/5/3.
//  Copyright © 2016年 genvict. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExpandTextView : UITextView

@property (nonatomic, assign) NSInteger limitCount;//限制个数
@property (nonatomic, copy) NSString *placeholderString;

@end
