//
//  UIImage+SyImage.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "UIImage+SyImage.h"
#import "SyConstant.h"
#import "SyFileManager.h"


@implementation UIImage (SyImage)


+ (UIImage *)combImageWithLeft:(NSString *)lImgStr middle:(NSString *)mImgStr right:(NSString *)rImgStr size:(CGSize)size
{
    UIImage *lImg = [UIImage imageNamed:lImgStr];
    UIImage *cImg = [UIImage imageNamed:mImgStr];
    UIImage *rImg = [UIImage imageNamed:rImgStr];
    CGFloat h = size.height;
    CGFloat w = size.width;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [lImg drawInRect:CGRectMake(0, 0, lImg.size.width, h)];
    [cImg drawInRect:CGRectMake(lImg.size.width, 0, w-lImg.size.width-rImg.size.width, h)];
    [rImg drawInRect:CGRectMake(w-rImg.size.width, 0, rImg.size.width, h)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}



+ (UIImage *)combImageWithTop:(NSString *)tImgStr middle:(NSString *)mImgStr bottom:(NSString *)bImgStr size:(CGSize)size
{
    UIImage *tImg = [UIImage imageNamed:tImgStr];
    UIImage *mImg = [UIImage imageNamed:mImgStr];
    UIImage *bImg = [UIImage imageNamed:bImgStr];
    CGFloat h = size.height;
    CGFloat w = size.width;
    UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
    [tImg drawInRect:CGRectMake(0, 0, w, tImg.size.height)];
    [mImg drawInRect:CGRectMake(0, tImg.size.height, w, h - tImg.size.height - bImg.size.height)];
    [bImg drawInRect:CGRectMake(0, h - bImg.size.height, w, bImg.size.height)];
    UIImage *resultImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resultImage;
}



+ (UIImage *)strechImageWithName:(NSString *)name
{    
    UIImage *image = [UIImage imageNamed:name];
    CGFloat top = image.size.height * 0.5f;
    CGFloat bottom = image.size.height * 0.5;
    CGFloat left = image.size.width * 0.5f;
    CGFloat right = image.size.width * 0.5f;
    UIEdgeInsets insets = UIEdgeInsetsMake(top, bottom, left, right);
    return [image resizableImageWithCapInsets:insets];
}


- (UIImage *)fixOrientation {
    
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.height,self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,self.size.width,self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)scaleImage:(UIImage *)image toScale:(float)scaleSize{
    UIGraphicsBeginImageContext(CGSizeMake(image.size.width * scaleSize, image.size.height * scaleSize));
    [image drawInRect:CGRectMake(0, 0, image.size.width * scaleSize, image.size.height * scaleSize)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();     
    return scaledImage;
                                
}


-(UIImage *)filetransImage{
    if (!self)
        return self;
    
    CGSize sourceSize = self.size;
    float limit_size = 960.0;
    
    if (sourceSize.width > limit_size || sourceSize.height > limit_size) {
        float scaleWidth = sourceSize.width / limit_size;
        float scaleHeight = sourceSize.height / limit_size;
        float scale = MAX(scaleHeight, MAX(scaleWidth, 1.0));
        return [UIImage scaleImage:self toScale:1.0/scale];
    }
    return self;
}

-(UIImage *)thumbnailWithImageWithoutScale:(CGSize )asize{
    UIImage *newimage;
    if (!self) {
        newimage = nil;
    }else{
        CGSize oldsize = self.size;
        CGRect rect;
        if (asize.width/asize.height > oldsize.width/oldsize.height) {
            rect.size.width = asize.height*oldsize.width/oldsize.height;
            rect.size.height = asize.height;
            rect.origin.x = (asize.width - rect.size.width)/2;
            rect.origin.y = 0;
        }else{
            rect.size.width = asize.width;
            rect.size.height = asize.width*oldsize.height/oldsize.width;
            rect.origin.x = 0;
            rect.origin.y = (asize.height - rect.size.height)/2;
        }
        UIGraphicsBeginImageContext(asize);
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextSetFillColorWithColor(context, [[UIColor clearColor] CGColor]);
        UIRectFill(CGRectMake(0, 0, asize.width, asize.height));//clear background
        [self drawInRect:rect];
        newimage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
    
    return newimage;
}

- (UIImage *)hundredRectImage:(CGSize )size{
    CGSize imageSize = self.size;
    
    if(imageSize.width < size.width){
        size.width = imageSize.width;
    }
    
    if(imageSize.height < size.height){
        size.height = imageSize.height;
    }
    
    CGImageRef sourceImageRef = [self CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, CGRectMake(imageSize.width / 2 - size.width / 2, imageSize.height / 2 - size.height / 2, size.width, size.height));
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}

- (UIImage *)imageByScalingToSize:(CGSize)targetSize
{
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (!CGSizeEqualToSize(imageSize, targetSize)) {
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}


@end
