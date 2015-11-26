//
//  UIView+SyView.m
//  DaJiaCore
//
//  Created by zhengxiaofeng on 13-6-26.
//  Copyright (c) 2013年 zhengxiaofeng. All rights reserved.
//

#import "UIView+SyView.h"

@implementation UIView (SyView)




- (CGFloat)originX {
    return self.frame.origin.x;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (CGFloat)height {
    return self.frame.size.height;
}

@end
