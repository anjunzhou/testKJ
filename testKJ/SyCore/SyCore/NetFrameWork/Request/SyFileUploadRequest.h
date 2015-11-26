//
//  SyFileUploadRequest.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseUploadRequest.h"

@interface SyFileUploadRequest : SyBaseUploadRequest

//初始化
- (id)initWithFileFrom:(NSInteger)from communityID:(NSString*)communityID;

@end
