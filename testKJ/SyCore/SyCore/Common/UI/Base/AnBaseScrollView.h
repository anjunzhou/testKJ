//
//  AnBaseScrollView.h
//  SyCore
//
//  Created by joinmore on 15/8/31.
//  Copyright (c) 2015年 menghua.wu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+SyView.h"
#import "SyConstant.h"
#import "UIViewAdditions.h"
#import "UIImage+SyImage.h"
#import "NSString+SyString.h"
#import "SyCacheManager.h"
@interface AnBaseScrollView : UIScrollView

@property (nonatomic, readonly) CGRect mainFrame;

- (void)setup;
- (void)customLayoutSubviews;
- (CGFloat)viewHeight;
-(UIColor*)changeColor:(NSString*)colorString;
@end
