//
//  SyAlertView.m
//  SyCore
//
//  Created by 愤怒熊 on 14-6-6.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyAlertView.h"
#import <UIKit/UIKit.h>

@implementation SyAlertView

+(void)alertMessage:(NSString *)title message:(NSString *)message{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:title.length == 0 ? @"系统提示" : title message:message delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}
@end
