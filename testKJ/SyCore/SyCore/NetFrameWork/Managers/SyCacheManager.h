//
//  SyCacheManager.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyConstant.h"


@interface SyCacheManager : NSObject

+ (SyCacheManager*)sharedSyCacheManager;
//判断是否可申请请款
- (void)setIsApplying:(NSString *)isApplying;
- (NSString *)isApplying;
//系统登录用户 UserName
- (void)setUserName:(NSString *)username;
- (NSString *)username;
- (void)removeUsername;

//系统登录用户 Password
- (void)setPassword:(NSString *)password;
- (NSString *)password;
- (void)removePassword;

//系统登录用户 PersonID
- (void)setPersonID:(NSString *)personID;
- (NSString *)personID;

//系统登录用户 PersonName
- (void)setPersonName:(NSString *)personName;
- (NSString *)personName;

//系统登录用户 AccessToken
- (void)setAccessToken:(NSString *)token;
- (NSString *)accessToken;
- (void)removeAccessToken;

//系统登录用户 RefreshToken
- (void)setRefreshToken:(NSString *)refreshToken;
- (NSString *)refreshToken;
- (void)removeRefreshToken;

//系统用户登录到期时间
- (void)setExpires_in:(long long)expires_in;
- (long long)expires_in;

//系统设备 DeviceToken
- (void)setDeviceToken:(NSString *)token;
- (NSString *)deviceToken;
- (void)removeDeviceToken;

//本地数据库版本号 DBVersion
- (void)setDBVersion:(NSString *)version;
- (NSString *)dBVersion;

//系统是否属于体验模式
- (void)setkExperienceFlag:(NSString *)experience;
- (NSString *)experienceFlag;

//系统唯一标示keychain
- (void)setKeyChain:(NSString*)keyChain;
- (NSString*)keyChain;
- (void)removeKeyChain;

//Session Id
- (void)setSessionID:(NSString*)sessoinID;
- (NSString*)sessionID;
- (void)removeSessionID;


//发送邮件URl
- (void)setEmailUrl:(NSString*)emailUrl;
- (NSString*)emailUrl;
- (void)removeEmailUrl;

//获得待处理作业条数
- (void)setNumberOfWork:(NSString*)numberOfWork;
- (NSString*)numberOfWork;

//缓存商品分类列表
- (void)setProductCategery:(NSString*)responseStr;
- (NSString*)productCategery;

//获得携程未处理订单的条数
-(void)setNumberOfXcOrder:(NSString *)numberOfWork;
- (NSString *)numberOfXcOrder;
//获取资金流预警个数
-(void)setNumberOfFund:(NSString *)numberOfWork;
- (NSString *)numberOfFund;
@end

