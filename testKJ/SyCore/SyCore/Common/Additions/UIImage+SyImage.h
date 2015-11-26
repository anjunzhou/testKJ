//
//  UIImage+SyImage.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (SyImage)

+ (UIImage *)combImageWithLeft:(NSString *)lImgStr middle:(NSString *)mImgStr right:(NSString *)rImgStr size:(CGSize)size;
+ (UIImage *)combImageWithTop:(NSString *)tImgStr middle:(NSString *)mImgStr bottom:(NSString *)bImgStr size:(CGSize)size;

//截取image，原来大小的一半
+ (UIImage *)strechImageWithName:(NSString *)name;

//截取image，在0，0的位置截取image的大小
+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize;

// 图片矫正
- (UIImage *)fixOrientation;

//原图
- (UIImage *)filetransImage;

- (UIImage *)imageByScalingToSize:(CGSize)targetSize;


/**
 *  获取 压缩图
 *
 */
- (UIImage *)thumbnailWithImageWithoutScale:(CGSize )size;

/**
 *  获取 剪切图
 *
 */
- (UIImage *)hundredRectImage:(CGSize )size;


@end


