//
//  SyBaseRequest.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#define kManagerName    @"managerName"
#define kMethodName     @"managerMethod"
#define kArguments      @"arguments"

#define kRequestType_get       1                       //get请求
#define kRequestType_post      2                       //post请求
#define kRequestType_oauth_get  3
#define kRequestType_version_get  4

#import <Foundation/Foundation.h>
#import "SyConstant.h"
#import "JSON.h"


@interface SyBaseRequest : NSObject {
    NSString        *_requestPath;          // 请求地址
    NSString        *_managerName;          // 模块名称
    NSString        *_methodName;           // 方法名
    NSUInteger      _requestType;           // 请求类型
    NSMutableDictionary  *_parametersDic;   // 参数字典     json
}

@property (nonatomic, copy) NSString        *requestPath;
@property (nonatomic, copy) NSString        *managerName;
@property (nonatomic, copy) NSString        *methodName;
@property (nonatomic, assign) NSUInteger    requestType;


- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key;
- (void)setLongLongValue:(long long)value forKey:(NSString *)key;
- (void)setBOOLValue:(BOOL)value forKey:(NSString *)key;
- (void)setValue:(id)value forKey:(NSString *)key;

- (NSDictionary *)parametersDic;

@end
