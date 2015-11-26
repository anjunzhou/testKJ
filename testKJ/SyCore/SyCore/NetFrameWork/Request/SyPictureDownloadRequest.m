//
//  SyPictureDownloadRequest.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyPictureDownloadRequest.h"

@implementation SyPictureDownloadRequest


- (id)initWithFileID:(NSString *)fileID communityID:(NSString *)communityID size:(NSInteger)size
{
    self = [super init];
    if (self) {
        self.requestType = kRequestType_get;
        self.managerName = @"picture";
        self.methodName = @"download";
    
        
        [self setValue:fileID forKey:@"fileID"];
        [self setValue:communityID forKey:@"communityID"];
        [self setIntegerValue:size forKey:@"size"];
        
    }
    return self;
}

@end
