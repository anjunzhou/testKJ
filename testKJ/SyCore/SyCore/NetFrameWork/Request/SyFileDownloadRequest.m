//
//  SyFileDownloadRequest.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyFileDownloadRequest.h"

@implementation SyFileDownloadRequest


- (id)initWithFileId:(NSString *)fileID communityID:(NSString *)communityID
{
    self = [super init];
    if (self) {
        self.requestType = kRequestType_get;
        self.managerName = @"file";
        self.methodName = @"download";
        
        [self setValue:fileID forKey:@"fileID"];
        [self setValue:communityID forKey:@"communityID"];
        
    }
    return self;
}



@end
