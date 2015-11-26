//
//  SyCenterNavigationView.m
//  Hi
//
//  Created by 愤怒熊 on 14-5-29.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SyView.h"
#import "SyConstant.h"
#import "UIViewAdditions.h"
#import "UIImage+SyImage.h"
#import "NSString+SyString.h"
#import "SyCacheManager.h"
@interface SyBaseView : UIView


 
@property (nonatomic, readonly) CGRect mainFrame;

- (void)setup;
- (void)customLayoutSubviews;
- (CGFloat)viewHeight;
-(UIColor*)changeColor:(NSString*)colorString;
@end
