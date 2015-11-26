//
//  SyPictureDownloadRequest.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseDownloadRequest.h"

@interface SyPictureDownloadRequest : SyBaseDownloadRequest



- (id)initWithFileID:(NSString *)fileID communityID:(NSString *)communityID size:(NSInteger)type;


@end

/*
fileID - 图片ID，必需
communityID - 社区ID，必需
size - 图片尺寸，参看C_iPicSize_XXX，非必需，默认为1
*/