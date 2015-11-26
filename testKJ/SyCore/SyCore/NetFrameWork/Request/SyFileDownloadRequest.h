//
//  SyFileDownloadRequest.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyBaseDownloadRequest.h"

@interface SyFileDownloadRequest : SyBaseDownloadRequest


- (id)initWithFileId:(NSString*)fileID communityID:(NSString*)communityID;


/*
 fileID - 文件ID，必需
 communityID - 社区ID，必需
*/


@end
