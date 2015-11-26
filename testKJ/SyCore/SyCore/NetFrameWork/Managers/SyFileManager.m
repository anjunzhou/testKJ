//
//  SyFileManager.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyFileManager.h"
#import "SyConstant.h"

@implementation SyFileManager

+ (SyFileManager *)defaultManager
{
    static SyFileManager *fileManagerInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        fileManagerInstance = [[self alloc] init];
    });
    return fileManagerInstance;
}



+ (NSString *)createFullPath:(NSString *)aPath{
    
    NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:aPath];
    BOOL isDirectory = NO;
    BOOL exists = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    if (exists && !isDirectory) {
        [NSException raise:@"FileExistsAtDownloadTempPath" format:@"Cannot create a directory for the downloadFileTempPath at '%@', because a file already exists",path];
    }else if (!exists) {
        [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
        if (![[NSFileManager defaultManager] fileExistsAtPath:path]) {
            [NSException raise:@"FailedToCreateCacheDirectory" format:@"Failed to create a directory for the downloadFileTempPath at '%@'",path];
        }
    }
    return path;
}

// 录音临时文件
+ (NSString *)recordFilePathWithFileName:(NSString *)fileName cleanFlag:(BOOL)flag{
    
    NSString *str = [SyFileManager createFullPath:kFileTempPath];
    
    str = [str stringByAppendingPathComponent:fileName];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:str] && flag) {
        
        [[NSFileManager defaultManager] removeItemAtPath:str error:nil];
    }
    return str;
}

+(void)copyFile:(NSString *)filePath toFilePath:(NSString *)toFilePath{
    if ([[NSFileManager defaultManager] fileExistsAtPath:toFilePath]) {
        NSLog(@"文件已经存在了");
    }else {
        NSError *error;
        if([[NSFileManager defaultManager] copyItemAtPath:filePath toPath:toFilePath error:&error]){
            NSLog(@"copy xxx.txt success");
        }else{
            NSLog(@"%@",error);
        }
    }
    
}

+(void)removeFile:(NSString *)filePath{
    [[NSFileManager defaultManager] removeItemAtPath:filePath error:NULL];
}
@end
