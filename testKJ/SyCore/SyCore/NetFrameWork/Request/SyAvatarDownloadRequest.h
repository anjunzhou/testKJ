//
//  SyAvatarDownloadRequest.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseRequest.h"
#import "SyBaseDownloadRequest.h"

@interface SyAvatarDownloadRequest : SyBaseDownloadRequest


- (id)initWithUserID:(NSString *)userID communityID:(NSString *)communityID size:(NSInteger)sizeType isGroup:(NSInteger)isGroup;


@end


// 1 is

/*

userID - 用户ID，必需
communityID - 社区ID，必需
size - 头像尺寸，参看C_iUserAvatarSize_XXX，非必需，默认为1

*/