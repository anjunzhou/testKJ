//
//  SyBaseNavigationView.h
//  Hi
//
//  Created by wumenghua on 13-6-27.
//  Copyright (c) 2013年 wumenghua. All rights reserved.
//

#define kLeftMargin_NavigationBar 0
#define kTopMargin_NavigationBar 0
#define kHeight_NavigationBarIOS7 64
#define kHeight_NavigationBar 44


#import "SyBaseView.h"
#import "SyNavigationBar.h"

@class SyNavigationBar;
@interface SyBaseNavigationView : SyBaseView {
    SyNavigationBar *_navigationBar;
    
}
/**
 *  创建导航条内控件
 */
- (void)installNavigationBarButtons;
/**
 *  返回导航条高度
 *
 *  @return 导航条高度值
 */
- (CGFloat)navigationBarHeight;
/**
 *  返回导航条的Frame
 *
 *  @return <#return value description#>
 */
- (CGRect)navigationBarFrame;

@end
