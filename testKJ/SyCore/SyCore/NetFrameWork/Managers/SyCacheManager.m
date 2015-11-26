//
//  SyCacheManager.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyCacheManager.h"

@implementation SyCacheManager


static SyCacheManager *instance = nil;

+ (SyCacheManager*)sharedSyCacheManager
{
    if (instance == nil) {
        instance = [[super allocWithZone:NULL] init];
    }
    return instance;
}
+ (id)allocWithZone:(NSZone *)zone
{
    return [self sharedSyCacheManager];
}
- (id)copyWithZone:(NSZone *)zone{
    return self;
}

/**
 * 请款中 点击申请按钮 判断是否可申请
 *
 *  @param isApplying <#isApplying description#>
 */
- (void)setIsApplying:(NSString *)isApplying{
    [[NSUserDefaults standardUserDefaults] setObject:isApplying forKey:kIsApplying];
}

- (NSString *)isApplying {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kIsApplying];
}
- (void)setUserName:(NSString *)username{
    [[NSUserDefaults standardUserDefaults] setObject:username forKey:kUserName];
}

- (NSString *)username {
    return [[NSUserDefaults standardUserDefaults] objectForKey:kUserName];
}

- (void)setPassword:(NSString *)password {
    [[NSUserDefaults standardUserDefaults] setObject:password forKey:kPassWord];
}

- (NSString *)password{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPassWord];
}

- (void)setPersonID:(NSString *)personID{
    [[NSUserDefaults standardUserDefaults] setObject:personID forKey:kPersonID];
}

- (NSString *)personID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPersonID];
}

- (void)setPersonName:(NSString *)personName{
    [[NSUserDefaults standardUserDefaults] setObject:personName forKey:kPersonName];
}

- (NSString *)personName{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kPersonName];
}


- (void)setAccessToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kAccess_token];
}
- (NSString *)accessToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kAccess_token];
}

- (void)setRefreshToken:(NSString *)refreshToken{
    [[NSUserDefaults standardUserDefaults] setObject:refreshToken forKey:kRefresh_token];
}

- (NSString *)refreshToken
{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kRefresh_token];
}

- (void)setExpires_in:(long long)expires_in{
    [[NSUserDefaults standardUserDefaults] setObject:[NSNumber numberWithLongLong:expires_in] forKey:kExpires_in];
}

- (long long)expires_in{
    return [(NSNumber *)[[NSUserDefaults standardUserDefaults] objectForKey:kExpires_in] longLongValue];
}

- (void)setDeviceToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setObject:token forKey:kDeviceToken];
}

- (NSString *)deviceToken{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kDeviceToken];
}

- (void)setDBVersion:(NSString *)version{
    [[NSUserDefaults standardUserDefaults] setObject:version forKey:kVersionDB];
}
- (NSString *)dBVersion{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kVersionDB];
}

- (void)setkExperienceFlag:(NSString *)experience{
    [[NSUserDefaults standardUserDefaults] setObject:experience forKey:kExperienceFlag];
}

- (NSString *)experienceFlag{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kExperienceFlag];
}

- (void)removeDeviceToken{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kDeviceToken];
}
- (void)removeAccessToken{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kAccess_token];
}
- (void)removeRefreshToken{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kRefresh_token];
}
- (void)removeUsername {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kUserName];
}

- (void)removePassword {
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kPassWord];
}

- (void)setKeyChain:(NSString*)keyChain{
    [[NSUserDefaults standardUserDefaults] setObject:keyChain forKey:kKeyChain];
}
- (NSString*)keyChain{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kKeyChain];
}
- (void)removeKeyChain{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kKeyChain];
}


- (void)setSessionID:(NSString*)sessoinID{
    [[NSUserDefaults standardUserDefaults] setObject:sessoinID forKey:kSessionID];
}
- (NSString*)sessionID{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kSessionID];
}
- (void)removeSessionID{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSessionID];
}

//发送邮件URl

- (void)setEmailUrl:(NSString*)emailUrl{
    [[NSUserDefaults standardUserDefaults] setObject:emailUrl forKey:kEmailUrl];
}
- (NSString*)emailUrl{
    return [[NSUserDefaults standardUserDefaults] objectForKey:kEmailUrl];
}
- (void)removeEmailUrl{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:kEmailUrl];
}


//缓存商品分类列表
- (void)setProductCategery:(NSString*)responseStr{
 [[NSUserDefaults standardUserDefaults] setObject:responseStr forKey:pCategery];

}
- (NSString*)productCategery{
    return [[NSUserDefaults standardUserDefaults] objectForKey:pCategery];
}


@end
