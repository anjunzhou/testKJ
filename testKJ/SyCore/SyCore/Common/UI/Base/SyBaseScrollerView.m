//
//  SyBaseScrollerView.m
//  SyCore
//
//  Created by 愤怒熊 on 14-6-17.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseScrollerView.h"

@implementation SyBaseScrollerView

- (void)setup{
    [super setup];
    
    if(!_scrollView){
        _scrollView = [[UIScrollView alloc]init];
        _scrollView.backgroundColor = [UIColor clearColor];
        _scrollView.pagingEnabled = NO;
        _scrollView.delegate = self;
        _scrollView.showsVerticalScrollIndicator = NO;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:_scrollView];
        
        UIPanGestureRecognizer *recognizer = [[UIPanGestureRecognizer alloc]initWithTarget:self
                                                                                    action:@selector(paningGestureReceive:)];
        recognizer.delegate = self;
        [recognizer delaysTouchesBegan];
        [self addGestureRecognizer:recognizer];
        
    }
    
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    UIView *view = touch.view;
//    if([view isKindOfClass:_scrollView.class]){
//        return NO;
//    }
    return YES;
}

- (void)customLayoutSubviews{
    [super customLayoutSubviews];
    _scrollView.frame = CGRectMake(0, (IOS7 ? -20 : 0), APP_IOS_Frame_Width, APP_IOS_Frame_Height - (IOS7 ? 78 : 98));
}

-(void)popViewControllerAnimated{

}

- (void)paningGestureReceive:(UIPanGestureRecognizer *)recoginzer{
    
    CGPoint touchPoint = [recoginzer translationInView:_scrollView];
    NSLog(@"touchPoint:%f",touchPoint.x);
    
    UIGestureRecognizerState state = [recoginzer state];
    if(state == UIGestureRecognizerStateEnded){
        if(touchPoint.x > 50){
            if(self.scrollerDelegate)
                [self popViewControllerAnimated];
        }
    }
}
@end
