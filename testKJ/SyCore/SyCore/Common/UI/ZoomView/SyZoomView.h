//
//  SyZoomView.h
//  DaJiaCore
//
//  Created by zhengxiaofeng on 13-7-14.
//  Copyright (c) 2013年 zhengxiaofeng. All rights reserved.
//

#import "SyBaseView.h"

@interface SyZoomView : SyBaseView <UIScrollViewDelegate>
{
    UIScrollView        *_scrollView;
    UIImageView         *_imageView;
}

@property (nonatomic, retain) UIScrollView      *scrollView;
@property (nonatomic, retain) UIImageView       *imageView;

@end
