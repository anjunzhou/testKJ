//
//  SyTopLabel.h
//  SyCore
//
//  Created by 愤怒熊 on 14-5-29.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} VerticalAlignment;


#import <UIKit/UIKit.h>

@interface SyTopLabel : UILabel

@property (nonatomic,assign) VerticalAlignment verticalAlignment;


@end
