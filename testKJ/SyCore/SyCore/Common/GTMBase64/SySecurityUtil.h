//
//  SySecurityUtil.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//
//

#import <Foundation/Foundation.h>

@interface SySecurityUtil : NSObject

//编码
+ (NSString*)encodeBase64String:(NSString *)input;

//解析
+ (NSString*)decodeBase64String:(NSString *)input;

//编码
+ (NSString*)encodeBase64Data:(NSData *)data;

//解码
+ (NSString*)decodeBase64Data:(NSData *)data;

@end
