//
//  SyCenterNavigationView.m
//  Hi
//
//  Created by 愤怒熊 on 14-5-29.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseButton.h"

@implementation SyBaseButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    // SUBCLASS TODO
//    [UIDevice currentDevice].systemVersion;
    
}


- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if(self.width > 0){
        [self customLayoutSubviews];
    }
    
}

- (CGFloat)viewHeight
{
    return 0;
}

- (void)customLayoutSubviews
{
    //  SUBCLASS TODO
}


@end
