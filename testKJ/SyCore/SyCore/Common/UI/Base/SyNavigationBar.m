//
//  SyCenterNavigationView.m
//  Hi
//
//  Created by 愤怒熊 on 14-5-29.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyNavigationBar.h"

@implementation SyNavigationBar
@synthesize backgroundImageView = _backgroundImageView;

- (void)setup
{
    if (!_backgroundImageView) {
        _backgroundImageView = [[UIImageView alloc] init];
        if(IOS7){
            _backgroundImageView.image = SY_IMAGE(@"bannerBar");
        }else{
            _backgroundImageView.image = SY_IMAGE(@"bannerBar_ios6");
        }
        [self addSubview:_backgroundImageView];
        
    }
}

- (void)customLayoutSubviews
{
    [super customLayoutSubviews];
    _backgroundImageView.frame = CGRectMake(0, 0, self.width, self.height);
}


@end
