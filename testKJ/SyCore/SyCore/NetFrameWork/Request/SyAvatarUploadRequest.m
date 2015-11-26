//
//  SyAvatarUploadRequest.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyAvatarUploadRequest.h"

@implementation SyAvatarUploadRequest

- (id)init{
    self = [super init];
    if (self) {
        self.requestType = kRequestType_post;
        self.managerName = @"avatar";
        self.methodName = @"upload";
    }
    return self;
}

@end
