//
//  SyTableFooterView.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#define kLeftMargin_ArrowImageView  35

#import "SyTableFooterView.h"
#import "SyConstant.h"
#import "UIView+SyView.h"

@interface SyTableFooterView ()

- (void)setup;

@end


@implementation SyTableFooterView
@synthesize states = _states;

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
    if (!_label) {
        _label = [[UILabel alloc] init];
        _label.font = [UIFont boldSystemFontOfSize:16.0f];
        _label.textColor = UIColorFromRGB(0x666666);
        _label.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
        _label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        _label.backgroundColor = [UIColor clearColor];
        _label.textAlignment = UITextAlignmentCenter;
        _label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        [self addSubview:_label];
    }
    
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
        _activityView.hidesWhenStopped = YES;
        [self addSubview:_activityView];
    }
}


- (void)setStates:(NSInteger)state
{
    if (state == kPullState_Pull) {
        _label.text = @"加载更多";
        [_activityView stopAnimating];
        
    }
    else if (state == kPullState_Loading) {
        _label.text = @"加载中...";
        [_activityView startAnimating];
    }
    else if (state == kPullState_NoDataLoad) {
        _label.text = @"已经到最后了";
        [_activityView stopAnimating];
    }
    _states = state;
}


- (void)layoutSubviews
{
    [super layoutSubviews];
    _label.frame = CGRectMake(0, 20, self.width, 20);
    _activityView.frame = CGRectMake(kLeftMargin_ArrowImageView, 20, 20.0f, 20.0f);
}



@end
