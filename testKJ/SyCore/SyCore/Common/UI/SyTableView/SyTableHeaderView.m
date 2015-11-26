//
//  SyTableHeaderView.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//


#define kWidth_ArrowImageView       16
#define kHeight_ArrowImageView      25
#define kLeftMargin_ArrowImageView  35
#define kWidth_ActivityView         20
#define kHeight_ActivityView        20


#import "SyTableHeaderView.h"
#import "SyConstant.h"
#import "UIView+SyView.h"
#import "SyDateUtil.h"

@interface SyTableHeaderView ()

- (void)setup;
- (void)setActivityView:(BOOL)isON;
@end



@implementation SyTableHeaderView
@synthesize state = _state;

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
    self.backgroundColor = UIColorFromRGB(0xE5E5E5);
    if (!_pullView) {
        _pullView = [[UIView alloc] init];
        _pullView.backgroundColor = [UIColor clearColor];
        [self addSubview:_pullView];
        
        if (!_pullLabel) {
            _pullLabel = [[UILabel alloc] init];
            _pullLabel.backgroundColor = [UIColor clearColor];
            _pullLabel.font = [UIFont boldSystemFontOfSize:16.0f];
            _pullLabel.textColor = UIColorFromRGB(0x666666);
            _pullLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
            _pullLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
            _pullLabel.textAlignment = UITextAlignmentCenter;
            [_pullView addSubview:_pullLabel];
        }
        
        if (!_timeLabel) {
            _timeLabel = [[UILabel alloc] init];
            _timeLabel.font = [UIFont systemFontOfSize:10];
            _timeLabel.textColor = UIColorFromRGB(0x9D9D9D);
            _timeLabel.shadowColor = [UIColor colorWithWhite:0.9f alpha:1.0f];
            _timeLabel.shadowOffset = CGSizeMake(0.0f, 1.0f);
            _timeLabel.backgroundColor = [UIColor clearColor];
            _timeLabel.textAlignment = UITextAlignmentCenter;
            [_pullView addSubview:_timeLabel];
        }
    }
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        _imageView.image = [UIImage imageNamed:@"sy_table_arrow@2x.png"];
        [self addSubview:_imageView];
    }
    
    if (!_activityView) {
        _activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
        _activityView.hidesWhenStopped = YES;
        [self addSubview:_activityView];
    }
}

- (void)flipImage:(BOOL)flip animated:(BOOL)animated
{
    BOOL previousFlip = !CGAffineTransformIsIdentity(_imageView.transform);
    if (flip == previousFlip) return;
	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration: 0.18];
	}
	if (!flip) {
		_imageView.transform = CGAffineTransformIdentity;
	}
	else {
		_imageView.transform = CGAffineTransformMakeRotation(M_PI);
	}
	if (animated) {
		[UIView commitAnimations];
	}
}

- (void)setActivityView:(BOOL)isON
{
	if (isON) {
		if (!_imageView.hidden) {
			[_activityView startAnimating];
			_imageView.hidden = YES;
		}
	}
	else {
		if (_imageView.hidden) {
			[_activityView stopAnimating];
			_imageView.hidden = NO;
		}
	}
}

- (void)setState:(NSInteger)state
{
    NSString *time = [[NSUserDefaults standardUserDefaults] objectForKey:kTableLastRefreshDate];
    if (!time) {
        _timeLabel.text = @"未更新";
    }
    else {
        _timeLabel.text = [NSString stringWithFormat:NSLocalizedString(@"最近更新: %@", @"label"),[SyDateUtil localDateByDay:time hasTime:YES]];
    }
    if (state == _state) {
        return;
    }
    if (state == kPullState_Pull) {
        _pullLabel.text = @"下拉刷新";
        [self flipImage:NO animated:YES];
        [self setActivityView:NO];
    }
    else if (state == kPullState_Release) {
        _pullLabel.text = @"松开刷新";
        [self flipImage:YES animated:YES];
        [self setActivityView: NO];
    }
    else if (state == kPullState_Loading) {
        [self flipImage:NO animated:YES];
        [self setActivityView: YES];
        _pullLabel.text = @"加载中...";
    }
    _state = state;
}


- (void)startReloading:(UITableView *)tableView animated:(BOOL)animated
{
    [self setState:kPullState_Loading];
	if (animated) {
		[UIView beginAnimations:nil context:NULL];
		[UIView setAnimationDuration:0.2];
	}
	tableView.contentInset = UIEdgeInsetsMake(60.0f, 0.0f, 0.0f, 0.0f);// CGFloat top, left, bottom, right; 
	if (animated) {
		[UIView commitAnimations];
	}
}

- (void)viewFinishAnimation
{
    [self setState:kPullState_Pull];
    NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
    NSDate *lastUpdatedDate = [NSDate date];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *time = [formatter stringFromDate:lastUpdatedDate];
    [[NSUserDefaults standardUserDefaults] setValue:time forKey:kTableLastRefreshDate];
    NSString *dateStr = [NSString stringWithFormat:NSLocalizedString(@"最近更新: %@", @"label"),[SyDateUtil localDateByDay:time hasTime:YES]];
    _timeLabel.text = dateStr;
}

- (void)finishReloading:(UITableView *)tableView animated:(BOOL)animated
{
	if (animated) {
		[UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDelegate: self];
		[UIView setAnimationDuration:0.3];
        [UIView setAnimationDidStopSelector:@selector(viewFinishAnimation)];
	}
	[tableView setContentInset:UIEdgeInsetsZero];
	if (animated) {
		[UIView commitAnimations];
	}
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    _pullView.frame = CGRectMake(0, self.height - kHeight_HeaderView, self.width, kHeight_HeaderView);
    _pullLabel.frame = CGRectMake(0, 10, self.width, 20);
    _timeLabel.frame = CGRectMake(0, 30, self.width, 20);
    _imageView.frame = CGRectMake(kLeftMargin_ArrowImageView, self.height - (kHeight_HeaderView - kHeight_ArrowImageView)/2.0 - kHeight_ArrowImageView, kWidth_ArrowImageView, kHeight_ArrowImageView);
    _activityView.frame = CGRectMake(kLeftMargin_ArrowImageView, self.height - (kHeight_HeaderView - kHeight_ActivityView)/2.0 - kHeight_ActivityView, kWidth_ActivityView, kHeight_ActivityView);
}



@end
