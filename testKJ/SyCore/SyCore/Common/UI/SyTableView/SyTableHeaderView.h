//
//  SyTableHeaderView.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyTableHeaderView : UIView {
    UILabel         *_pullLabel;
    UILabel         *_timeLabel;
    UIView          *_pullView;
    NSInteger       _state;
    
    UIImageView     *_imageView;
    UIActivityIndicatorView     *_activityView;
}
@property (nonatomic, assign) NSInteger     state;


- (void)setState:(NSInteger)state;
- (void)startReloading:(UITableView *)tableView animated:(BOOL)animated;
- (void)finishReloading:(UITableView *)tableView animated:(BOOL)animated;

@end
