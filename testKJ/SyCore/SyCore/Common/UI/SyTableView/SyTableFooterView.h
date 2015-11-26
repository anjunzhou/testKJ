//
//  SyTableFooterView.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyTableFooterView : UIControl {
    NSInteger       _states;
    UILabel         *_label;
    UIActivityIndicatorView     *_activityView;
}

@property (nonatomic, assign) NSInteger     states;

- (void)setStates:(NSInteger)state;


@end
