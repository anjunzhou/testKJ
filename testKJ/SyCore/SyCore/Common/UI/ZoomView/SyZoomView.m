//
//  SyZoomView.m
//  DaJiaCore
//
//  Created by zhengxiaofeng on 13-7-14.
//  Copyright (c) 2013年 zhengxiaofeng. All rights reserved.
//

#import "SyZoomView.h"

@interface SyZoomView ()

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center;

@end


@implementation SyZoomView
@synthesize scrollView = _scrollView;
@synthesize imageView = _imageView;


- (void)setup
{
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        _scrollView.showsVerticalScrollIndicator = NO;
        CGFloat minimumScale = 1;
        [_scrollView setMinimumZoomScale:minimumScale];
        [_scrollView setMaximumZoomScale:3];
        [_scrollView setZoomScale:minimumScale];
        [self addSubview:_scrollView];
    }
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.userInteractionEnabled = YES;
        
        UITapGestureRecognizer *singleFingerOne = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
        singleFingerOne.numberOfTouchesRequired = 1; //手指数
        singleFingerOne.numberOfTapsRequired = 1; //tap次数
        [_imageView addGestureRecognizer:singleFingerOne];
        
        UITapGestureRecognizer *doubleTapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        [doubleTapGesture setNumberOfTapsRequired:2];
        [_imageView addGestureRecognizer:doubleTapGesture];
        
        // 加这一句 当单指双击时，会先调用单指单击中的处理，再调用单指双击中的处理
        [singleFingerOne requireGestureRecognizerToFail:doubleTapGesture];
        [_scrollView addSubview:_imageView];
    }
    
    
}

- (void)handleSingleTap:(UIGestureRecognizer *)gesture
{
    [[NSNotificationCenter defaultCenter] postNotificationName:kZoomViewSingleTap object:nil userInfo:nil];
}

// 双击 放大
- (void)handleDoubleTap:(UIGestureRecognizer *)gesture
{
    float newScale = _scrollView.zoomScale * 1.5;
    CGRect zoomRect = [self zoomRectForScale:newScale withCenter:[gesture locationInView:gesture.view]];
    [_scrollView zoomToRect:zoomRect animated:YES];
}

- (CGRect)zoomRectForScale:(float)scale withCenter:(CGPoint)center
{
    CGRect zoomRect;
    zoomRect.size.height = self.frame.size.height / scale;
    zoomRect.size.width  = self.frame.size.width  / scale;
    zoomRect.origin.x = center.x - (zoomRect.size.width  / 2.0);
    zoomRect.origin.y = center.y - (zoomRect.size.height / 2.0);
    return zoomRect;
}

- (void)customLayoutSubviews
{
    [super customLayoutSubviews];
    [_scrollView setZoomScale:1.0 animated:NO];
    
    
    CGFloat imgW = _imageView.image.size.width;
    CGFloat imgH = _imageView.image.size.height;
    
    
    if (imgW > self.width || imgH > self.height) {
        CGFloat rateX = self.width/imgW;
        CGFloat rateY = self.height/imgH;
        CGFloat rate = MIN(rateX, rateY);
        _imageView.frame = CGRectMake((self.width - imgW * rate)/2.0, (self.height - imgH * rate)/2.0, imgW *rate, imgH *rate);
    }
    else {
        _imageView.frame = CGRectMake((self.width - imgW)/2.0, (self.height - imgH)/2.0, imgW, imgH);
    
    }
    
    [_scrollView setContentSize:CGSizeMake(self.width, self.height)];
    _scrollView.frame = CGRectMake(0, 0, self.width, self.height);
    
}

#pragma mark- UIScrollViewDelegate
- (void)scrollViewDidZoom:(UIScrollView *)scrollView
{
    CGFloat offsetX = (scrollView.bounds.size.width > scrollView.contentSize.width)?
    (scrollView.bounds.size.width - scrollView.contentSize.width) * 0.5 : 0.0;
    CGFloat offsetY = (scrollView.bounds.size.height > scrollView.contentSize.height)?
    (scrollView.bounds.size.height - scrollView.contentSize.height) * 0.5 : 0.0;
    _imageView.center = CGPointMake(scrollView.contentSize.width * 0.5 + offsetX,
                                    scrollView.contentSize.height * 0.5 + offsetY);
}

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    //NSLog(@"...");
    return _imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale
{
    NSLog(@"%f",scale);
    //[scrollView setZoomScale:scale animated:NO];
}

@end
