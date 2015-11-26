//
//  MyPickerView.m
//  HaoBao
//  QQ:297184181
//  Created by haobao on 13-11-26.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import "SyPickerView.h"

@interface SyPickerView()

@property (nonatomic, retain)NSMutableArray *tables;


- (void)addContent;
- (void)removeContent;

//返回当前是第几组
- (NSInteger)componentFromWheelView:(SyWheelView*)wheelView;

@end

@implementation SyPickerView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor=[UIColor whiteColor];
        if(loop == nil){
            loop = [[SyMagnifierView alloc] initWithFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y, self.bounds.size.width, 20)];
            loop.viewToMagnify = self;
            loop.backgroundColor = [UIColor clearColor];
        }
        
        // Initialization code
    }
    return self;
}

- (void)addloop
{
    [loop magnifierLayer:_isMagnifierLayer];
    loop.hidden = YES;
    [self.superview addSubview:loop];
    
}

- (void)update{
    
    [self removeContent];
    [self addContent];
    
    [self performSelector:@selector(addloop) withObject:nil afterDelay:0];
    [self wheelViewDidScroller:nil];
}

#pragma mark - Content

- (void)addContent{
    
    const NSInteger components = [self numberOfComponents];
    
    _tables=[[NSMutableArray alloc] init];
    
    CGRect tableFrame = CGRectMake(0, 0, 0, self.bounds.size.height);
    for (NSInteger i = 0; i<components; ++i) {
        
        tableFrame.size.width = self.frame.size.width/components;
        
        SyWheelView *wheelview=[[SyWheelView alloc] initWithFrame: tableFrame];
        wheelview.delegate = self;
        if(_currentIndex > 0) wheelview.currentIndex = _currentIndex;
        if(_currentNumber > 0) wheelview.currentNumber = _currentNumber;
        if(_unknownParam1 > 0) wheelview.unknownParam1 = _unknownParam1;
        if(_unknownParam2 > 0) wheelview.unknownParam2 = _unknownParam2;
        [wheelview reloadData];
        wheelview.idleDuration = 0;
        [self addSubview:wheelview];
        [self.tables addObject:wheelview];
        
        tableFrame.origin.x += tableFrame.size.width;
    }
    
}

- (void)removeContent
{
    for (SyWheelView *table in self.tables) {
        [table removeFromSuperview];
    }
    self.tables = nil;
    
}

-(void) reloadData{
    
    for (SyWheelView *table in self.tables) {
        [table reloadData];
    }
}


- (void)selectedRowInComponent:(NSInteger)component{
    if(self.tables.count > 0){
        SyWheelView *wheel = [self.tables objectAtIndex:self.tables.count - 1];
        [wheel selectedRowInComponent:component];
    }
}

-(void) reloadDataInComponent:(NSInteger)component{
    
    [[self.tables objectAtIndex:component] reloadData];
}

#pragma mark WheelViewDelegate

- (NSInteger)numberOfRowsOfWheelView:(SyWheelView *)wheelView{
    NSInteger component = [self componentFromWheelView:wheelView];
    return [self numberOfRowsInComponent:component];
}

- (UIView *)wheelView:(SyWheelView *)wheelView viewForRowAtIndex:(int)index{
    NSInteger component = [self componentFromWheelView:wheelView];
    
    UILabel *label=[[UILabel alloc] initWithFrame:loop.bounds];
    label.text=[self setDataForRow:index inComponent:component];
    label.tag = index;
    label.font = _font != nil ? _font : [UIFont systemFontOfSize:13];
    
    label.backgroundColor=[UIColor clearColor];
    label.textAlignment=NSTextAlignmentCenter;
    return label;
}

- (float)rowWidthInWheelView:(SyWheelView *)wheelView{
    
    return self.bounds.size.width;
}

- (float)rowHeightInWheelView:(SyWheelView *)wheelView{
    
    return loop.frame.size.height;
}

- (void)wheelView:(SyWheelView *)wheelView didSelectedRowAtIndex:(NSInteger)index
{
    NSInteger component = [self componentFromWheelView:wheelView];
    if([self.delegate respondsToSelector:@selector(pickerView:didSelectRow:inComponent:)]){
        [self.delegate pickerView:self didSelectRow:index inComponent:component];
    }
}

#pragma mark 滚动，调用该方法
- (void)wheelViewDidScroller:(SyWheelView *)wheelView
{
    loop.touchPoint=CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    [loop setNeedsDisplay];
}


#pragma mark - get dataSourse;
//组数
- (NSInteger) numberOfComponents
{
    if ([self.dataSource respondsToSelector:@selector(numberOfComponentsInPickerView:)]) {
        return [self.dataSource numberOfComponentsInPickerView:self];
    }
    return 1;
}
//行数
- (NSInteger) numberOfRowsInComponent:(NSInteger)component
{
    if ([self.dataSource respondsToSelector:@selector(pickerView:numberOfRowsInComponent:)]) {
        return [self.dataSource pickerView:self numberOfRowsInComponent:component];
    }
    return 0;
}
//每行数据
- (NSString *)setDataForRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if ([self.delegate respondsToSelector:@selector(pickerView:titleForRow:forComponent:)]) {
        return [self.delegate pickerView:self titleForRow:row forComponent:component];
    }
    return @"";
}

#pragma mark - Other methods

//或得当前组数
- (NSInteger)componentFromWheelView:(SyWheelView *)wheelView
{
    return [self.tables indexOfObject:wheelView];
}


@end
