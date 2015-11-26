//
//  NSString+SyString.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "NSString+SyString.h"

@implementation NSString (SyString)

- (NSString *) replaceCharacter:(NSString *)oStr withString:(NSString *)nStr{
    if (oStr && nStr) {
        NSMutableString *_str = [NSMutableString stringWithString:self];
        [_str replaceOccurrencesOfString:oStr withString:nStr options:NSCaseInsensitiveSearch range:NSMakeRange(0, _str.length)];
        return _str;
    }
    else
        return oStr;
}

+ (NSString *)verifySeverStr:(NSString *)str
{
    if (str == nil ||
        [str isEqualToString:@""]) {
        return nil;
    }
    else {
        // 去掉空格
        NSString *resoultStr = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([resoultStr isEqualToString:@""]) {
            return nil;
        }
        else {
            return resoultStr;
        }
    }
}



-(CGSize)sizeWidth{
    return [self sizeWidthFont:FONTSYS(17) size:CGSizeMake(0, APP_IOS_Frame_Height)];
}
-(CGSize)sizeWidthFont:(UIFont *)font size:(CGSize )size{
    
    if(IOS7){
        NSDictionary *attribute = @{NSFontAttributeName:font};
        size = [self boundingRectWithSize:CGSizeMake(0, size.height) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
    }else{
        size = [self sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, size.height)];
    }
    return size;
}




-(CGSize)sizeHeight{
    return [self sizeHeightFont:FONTSYS(17) size:CGSizeMake(APP_IOS_Frame_Width, 0)];
}
-(CGSize)sizeHeightFont:(UIFont *)font size:(CGSize )size{
    
    if(IOS7){
        NSDictionary *attribute = @{NSFontAttributeName:font};
        size = [self boundingRectWithSize:CGSizeMake(size.width, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
    }else{
        size = [self sizeWithFont:font constrainedToSize:CGSizeMake(size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    }
    return size;
}

+(NSString *)getFileSizeString:(int )fileSize{
    NSString *fileSizeStr;
    if(fileSize < 1024){
        fileSizeStr = [NSString stringWithFormat:@"%d B",fileSize];
    }else if (fileSize < 1024 * 1024) {
        fileSizeStr = [NSString stringWithFormat:@"%.2f K",fileSize / 1024.0];
    }else if (fileSize < 1024 * 1024 * 1024) {
        fileSizeStr = [NSString stringWithFormat:@"%.2f M",fileSize / 1024.0 / 1024.0];
    }
    
    return fileSizeStr;
}


- (CGSize)calculateSize:(CGSize)size font:(UIFont *)font {
    CGSize expectedLabelSize = CGSizeZero;
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7) {
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
        NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
        
        expectedLabelSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    }
    else {
        expectedLabelSize = [self sizeWithFont:font
                             constrainedToSize:size
                                 lineBreakMode:NSLineBreakByWordWrapping];
    }
    
    return CGSizeMake(ceil(expectedLabelSize.width), ceil(expectedLabelSize.height));
}


+ (NSString *)positiveFormat:(NSString *)text{
    
    if(!text || [text floatValue] == 0){
        return @"0.00";
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@"###,##0.00;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
    }
    return @"";
}

+ (NSString *)positiveFormatThress:(NSString *)text{
    
    if(!text || [text floatValue] == 0){
        return @"0.000";
    }else{
        NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
        [numberFormatter setPositiveFormat:@"###,##0.000;"];
        return [numberFormatter stringFromNumber:[NSNumber numberWithDouble:[text doubleValue]]];
    }
    return @"";
}

@end
