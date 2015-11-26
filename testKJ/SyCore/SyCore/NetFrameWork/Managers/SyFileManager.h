//
//  SyFileManager.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyFileManager : NSObject

+ (SyFileManager *)defaultManager;

+ (NSString *)createFullPath:(NSString *)aPath;


+ (NSString *)recordFilePathWithFileName:(NSString *)fileName cleanFlag:(BOOL)flag;

+(void)copyFile:(NSString *)filePath toFilePath:(NSString *)toFilePath;

+(void)removeFile:(NSString *)filePath;
@end
