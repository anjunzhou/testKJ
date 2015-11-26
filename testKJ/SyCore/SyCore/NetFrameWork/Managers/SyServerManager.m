//
//  SyServerManager.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//


//--------------------------------------------------------------------------------------
#pragma mark- 测试 地址
//#define kOnLine_ServerAddress       @"http://182.92.79.79:8080/hi"


//--------------------------------------------------------------------------------------------------
#pragma mark-           正式
//--------------------------------------------------------------------------------------------------

//#define kOnLine_ServerAddress      @"http://182.92.79.79:8080/hi"
//#define kOnLine_ServerAddress      @"http://www.icarm.cn"
//#define kOnLine_ServerAddress        @"http://192.168.0.239:7006/JMCC"
#define kOnLine_ServerAddress        @"http://192.168.0.239:7009/JMCC"



//--------------------------------------------------------------------------------------------------
#pragma mark-           测试
//--------------------------------------------------------------------------------------------------

//#define KOnLine_FtpName             @"hi"
//#define KOnLine_FtpPassWord         @"hi"
//#define KOnLine_FtpAddress          @"ftp://192.168.2.6:21"



#import "SyServerManager.h"
#import "SyCacheManager.h"



@implementation SyServerManager
@synthesize serverAddress = _serverAddress;
@synthesize ftpAddress;
@synthesize ftpName;
@synthesize ftpPassword;



/* ---------- 单例模式标准代码 ---------- */
static SyServerManager *instance = nil;

+ (SyServerManager *)defaultManager
{
    if (!instance) {
        instance = [[super allocWithZone:NULL] init];
        [SyServerManager reSet];
    }
    
    if ([[NSUserDefaults standardUserDefaults] objectForKey:kExperienceFlag]) {
        // 体验
        instance.serverAddress = kOnLine_ServerAddress;
    }else {
        // 正式
        instance.serverAddress = kOnLine_ServerAddress;
        
    }
    
    return instance;
}


+ (BOOL)reSet
{
    instance.serverAddress = nil;
    return YES;
}


@end
