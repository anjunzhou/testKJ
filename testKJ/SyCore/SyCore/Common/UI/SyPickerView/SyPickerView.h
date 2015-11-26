//
//  MyPickerView.h
//  HaoBao
//  QQ:297184181
//  Created by haobao on 13-11-26.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "SyWheelView.h"           //滚轮
#import "SyMagnifierView.h"       //放大
@protocol SyPickerViewDataSource;
@protocol SyPickerViewDelegate;

@interface SyPickerView : UIView<SyWheelViewDelegate> {
    
    CGFloat centralRowOffset;
    
    SyMagnifierView *loop;
    
    
}

@property (nonatomic, assign) id<SyPickerViewDelegate> delegate;
@property (nonatomic, assign) id<SyPickerViewDataSource> dataSource;

@property (nonatomic, retain)UIColor *fontColor;

- (void)update;

- (void)reloadData;

- (void)reloadDataInComponent:(NSInteger)component;

- (void)selectedRowInComponent:(NSInteger)component;

@property(nonatomic ,assign)NSInteger currentIndex;

@property(nonatomic ,assign)NSInteger currentNumber;

@property(nonatomic ,retain)UIFont *font;

@property(nonatomic ,assign)BOOL isMagnifierLayer;

@property (nonatomic ,assign)float unknownParam1;

@property (nonatomic ,assign)float unknownParam2;

@end

@protocol SyPickerViewDataSource <NSObject>
@required

- (NSInteger)numberOfComponentsInPickerView:(SyPickerView *)pickerView;

- (NSInteger)pickerView:(SyPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;

@end

@protocol SyPickerViewDelegate <NSObject>

@optional

- (CGFloat)pickerView:(SyPickerView *)pickerView widthForComponent:(NSInteger)component;
//- (CGFloat)pickerView:(MyPickerView *)pickerView rowHeightForComponent:(NSInteger)component;

- (NSString *)pickerView:(SyPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;

//- (UIView *)pickerView:(MyPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view;

- (void)pickerView:(SyPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;


@end


