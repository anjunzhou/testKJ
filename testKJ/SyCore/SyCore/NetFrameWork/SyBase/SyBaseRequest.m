//
//  SyBaseRequest.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//



#import "SyBaseRequest.h"
#import "JSON.h"
#import "SyServerManager.h"
#import "SyCacheManager.h"


@implementation SyBaseRequest
@synthesize managerName = _managerName;
@synthesize methodName = _methodName;
@synthesize requestType = _requestType;

- (id)init
{
    self = [super init];
    if (self) {
        if (!_parametersDic) {
            _parametersDic = [[NSMutableDictionary alloc] init];
        }
    }
    return self;
}

- (void)setIntegerValue:(NSInteger)value forKey:(NSString *)key
{
    [_parametersDic setValue:[NSNumber numberWithInteger:value] forKey:key];
}

- (void)setLongLongValue:(long long)value forKey:(NSString *)key
{
    
    [_parametersDic setValue:[NSNumber numberWithLongLong:value] forKey:key];
}

- (void)setBOOLValue:(BOOL)value forKey:(NSString *)key
{
    [_parametersDic setValue:[NSNumber numberWithBool:value] forKey:key];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    if (!value) {
        value = [NSNull null];
    }
    [_parametersDic setValue:value forKey:key];
}


- (NSDictionary *)parametersDic
{
    if (_requestType == kRequestType_get ||
        _requestType == kRequestType_post) {
        if ([SyCacheManager sharedSyCacheManager].accessToken) {
            [_parametersDic setObject:[SyCacheManager sharedSyCacheManager].accessToken forKey:@"access_token"];
        }
    
    }
    NSDictionary *result = [NSDictionary dictionaryWithObjectsAndKeys:\
                            _managerName, kManagerName,\
                            _methodName, kMethodName,\
                            _parametersDic, kArguments, nil];
    return result;
}


@end
