//
//  SyFileUploadRequest.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyFileUploadRequest.h"

@implementation SyFileUploadRequest

- (id)initWithFileFrom:(NSInteger)from communityID:(NSString*)communityID{
    self = [super init];
    if (self) {
        self.requestType = kRequestType_post;
        self.managerName = @"file";
        self.methodName = @"upload";
        
        [self setValue:[NSString stringWithFormat:@"%d",from] forKey:@"from"];
        [self setValue:communityID forKey:@"communityID"];
    }
    return self;
}

@end
