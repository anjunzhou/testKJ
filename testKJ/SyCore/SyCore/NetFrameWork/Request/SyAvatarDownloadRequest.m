//
//  SyAvatarDownloadRequest.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyAvatarDownloadRequest.h"

@implementation SyAvatarDownloadRequest

- (id)initWithUserID:(NSString *)userID communityID:(NSString *)communityID size:(NSInteger)sizeType isGroup:(NSInteger)isGroup
{
    self = [super init];
    if (self) {
        self.requestType = kRequestType_get;
        self.managerName = @"avatar";
        self.methodName = @"download";
        
        [self setValue:userID forKey:@"userID"];
        [self setValue:communityID forKey:@"communityID"];
        [self setIntegerValue:sizeType forKey:@"size"];
        [self setIntegerValue:isGroup forKey:@"isGroup"];
        
    }
    return self;
}

@end
