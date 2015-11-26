//
//  SyBaseScrollerView.h
//  SyCore
//
//  Created by 愤怒熊 on 14-6-17.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseView.h"

@interface SyBaseScrollerView : SyBaseView<UIGestureRecognizerDelegate,UIScrollViewDelegate>{
    
    //整体滑动视图
    UIScrollView        *_scrollView;
    
    
    
}

@property (nonatomic,retain) UIScrollView                *scrollView;

-(void)popViewControllerAnimated;

@property (nonatomic, assign) UIViewController<NSObject> *scrollerDelegate;

@end
