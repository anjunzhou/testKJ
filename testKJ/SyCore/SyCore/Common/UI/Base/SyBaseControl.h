//
//  SyCenterNavigationView.m
//  Hi
//
//  Created by 愤怒熊 on 14-5-29.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SyConstant.h"
#import "UIViewAdditions.h"
#import "UIView+SyView.h"

@interface SyBaseControl : UIControl

/**
 *  该方法内创建控件
 */
- (void)setup;
/**
 *  该方法内设置控件坐标
 */
- (void)customLayoutSubviews;


- (CGFloat)viewHeight;


@end
