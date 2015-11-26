//
//  UILabel+SyLabel.h
//  SyCore
//
//  Created by 愤怒熊 on 14-5-30.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (SyLabel)

/**
 *  计算宽度
 */
-(CGSize)sizeWidth;
-(CGSize)sizeWidthFont:(UIFont *)font;

/**
 *  计算高度
 */
-(CGSize)sizeHeight;
-(CGSize)sizeHeightFont:(UIFont *)font;

/**
 *  计算最后一个字符的位置
 */
-(void)lastCharacter;
-(void)lastCharacter:(UIFont *)font;


@end
