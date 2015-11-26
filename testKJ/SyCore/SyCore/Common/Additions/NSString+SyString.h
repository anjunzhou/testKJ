//
//  NSString+SyString.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "SyConstant.h"

@interface NSString (SyString)

// 替换字符串
- (NSString *) replaceCharacter:(NSString *)oStr withString:(NSString *)nStr;

// 校验 服务端字符串
+ (NSString *) verifySeverStr:(NSString *)str;


/**
 *  计算文字宽度
 */
-(CGSize)sizeWidth;
-(CGSize)sizeWidthFont:(UIFont *)font size:(CGSize )size;

/**
 *  计算文字高度
 */
-(CGSize)sizeHeight;
-(CGSize)sizeHeightFont:(UIFont *)font size:(CGSize )size;

/**
 *  文件大小数字装换
 *
 *  @param fileSize 入参大小:1024
 *
 *  @return 出参大小:1M
 */
+(NSString *)getFileSizeString:(int )fileSize;

- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font;

+ (NSString *)positiveFormat:(NSString *)text;
+ (NSString *)positiveFormatThress:(NSString *)text;

@end
