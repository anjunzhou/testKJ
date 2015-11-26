//
//  AnBaseScrollView.m
//  SyCore
//
//  Created by joinmore on 15/8/31.
//  Copyright (c) 2015年 menghua.wu. All rights reserved.
//

#import "AnBaseScrollView.h"

@implementation AnBaseScrollView
@synthesize mainFrame = _mainFrame;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setup];
    }
    return self;
}

- (CGRect)mainFrame
{
    return CGRectMake(0, 0, self.width, self.height);
}

- (void)setup
{
    //  SUBCLASS TODO
}

- (CGFloat)viewHeight
{
    return 0;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    if(self.width > 0){
        [self customLayoutSubviews];
    }
    
}

- (void)customLayoutSubviews{
    //  SUBCLASS TODO
}

#pragma mark 改变颜色16进制转UIColor
-(UIColor*)changeColor:(NSString*)colorString{
    CGFloat alpha,red,green,blue;
    alpha=[self colorComponentFrom:colorString start:0 length:2];
    red=[self colorComponentFrom:colorString start:2 length:2];
    green=[self colorComponentFrom:colorString start:4 length:2];
    blue=[self colorComponentFrom:colorString start:6 length:2];
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}
- (CGFloat) colorComponentFrom:(NSString*)string start:(NSUInteger)start length:(NSUInteger)length
{
    NSString *substring = [string substringWithRange: NSMakeRange(start, length)];
    NSString *fullHex = length == 2 ? substring : [NSString stringWithFormat: @"%@%@", substring, substring];
    unsigned hexComponent;
    [[NSScanner scannerWithString: fullHex] scanHexInt: &hexComponent];
    return hexComponent / 255.0;
}
#pragma mark 改变颜色16进制转UIColor ---END
@end
