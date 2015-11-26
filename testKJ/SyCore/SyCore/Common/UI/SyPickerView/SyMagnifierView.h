//
//  MagnifierView.h
//  HaoBao
//  QQ:297184181
//  Created by haobao on 13-11-26.
//  Copyright (c) 2013年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SyMagnifierView : UIView{
    
}

@property (nonatomic, retain) UIView *viewToMagnify;

@property (nonatomic, assign) CGPoint touchPoint;

-(void)magnifierLayer:(BOOL )isLayer;

@end
