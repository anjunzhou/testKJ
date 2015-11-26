//
//  WheelView.h
//  HaoBao
//  QQ:297184181
//  Created by haobao on 13-12-2.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SyWheelViewDelegate;

@interface SyWheelView : UIView <UIGestureRecognizerDelegate>{
    
    NSMutableArray *_views;                      //存放当前的view的顺序；
    NSMutableArray *_viewsAngles;                //这里存放view的倾斜角度；
    NSMutableArray *_originalPositionedViews;    //原始的view放在这个数组里边；方便后面做选择的时候找到对应的值；
    NSInteger viewsNum;                       //view的个数；
    
    BOOL toDescelerate;
    
    BOOL toRearrange;
    
    
    
}

@property (nonatomic ,assign) NSObject<SyWheelViewDelegate> *delegate;

@property (nonatomic ,assign) int idleDuration;

@property (nonatomic ,assign) int currentIndex;

@property (nonatomic ,assign) int currentNumber;

@property (nonatomic ,assign)float unknownParam1;

@property (nonatomic ,assign)float unknownParam2;



- (void)reloadData;
- (void)selectedRowInComponent:(NSInteger)component;

@end

@protocol SyWheelViewDelegate

@required

- (NSInteger)numberOfRowsOfWheelView:(SyWheelView *)wheelView;
- (UIView *)wheelView:(SyWheelView *)wheelView viewForRowAtIndex:(int)index;
- (float)rowWidthInWheelView:(SyWheelView *)wheelView;
- (float)rowHeightInWheelView:(SyWheelView *)wheelView;

@optional

- (void)wheelViewDidScroller:(SyWheelView *)wheelView;
- (void)wheelView:(SyWheelView *)wheelView didSelectedRowAtIndex:(NSInteger)index;

@end