//
//  SyServerManager.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyServerManager : NSObject {
    NSString        *_serverAddress;
    NSString        *_versionAddress;
}


@property (nonatomic, copy) NSString    *serverAddress;
@property (nonatomic, copy) NSString    *ftpName;
@property (nonatomic, copy) NSString    *ftpPassword;
@property (nonatomic, copy) NSString    *ftpAddress;






//需要抛弃
@property (nonatomic, copy) NSString    *oauthAddress;
@property (nonatomic, copy) NSString    *versionAddress;
@property (nonatomic, copy) NSString    *inviteAddress;
@property (nonatomic, copy) NSString    *registerAddress;
@property (nonatomic, copy) NSString    *forgetAddress;
@property (nonatomic, copy) NSString    *modifyPassword;
@property (nonatomic, copy) NSString    *dajiaProtocol;
@property (nonatomic, copy) NSString    *trialVersion;  // 免登陆试用
@property (nonatomic, copy) NSString    *goToExpLuckyDraw;


//---------微信分享
@property (nonatomic, copy) NSString    *shareFeedURL;
@property (nonatomic, copy) NSString    *shareBlogURL;
@property (nonatomic, copy) NSString    *shareCompanyQRURL;





+ (SyServerManager *)defaultManager;
+ (BOOL)reSet;





@end
