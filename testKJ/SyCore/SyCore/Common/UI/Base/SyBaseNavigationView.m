//
//  SyCenterNavigationView.m
//  Hi
//
//  Created by 愤怒熊 on 14-5-29.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//




#import "SyBaseNavigationView.h"


@implementation SyBaseNavigationView

- (CGRect)navigationBarFrame{
    return CGRectMake(kLeftMargin_NavigationBar, kTopMargin_NavigationBar, App_Main_Screen_Width, [self navigationBarHeight]);
}

- (CGFloat)navigationBarHeight
{
    return (IOS7 ? kHeight_NavigationBarIOS7 : kHeight_NavigationBar);
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        if (!_navigationBar) {
            _navigationBar = [[SyNavigationBar alloc]  init];
            if(IOS7){
                _navigationBar.backgroundImageView.image = SY_IMAGE(@"bannerBar");
            }else{
                _navigationBar.backgroundImageView.image = SY_IMAGE(@"bannerBar_ios6");
            }
            _navigationBar.frame = [self navigationBarFrame];
            [self addSubview:_navigationBar];
            [self installNavigationBarButtons];
        }
    }
    return self;
}

- (void)installNavigationBarButtons
{
    //  TODO SUBCLASS
}


- (void)customLayoutSubviews
{
    [super customLayoutSubviews];
    
}



@end
