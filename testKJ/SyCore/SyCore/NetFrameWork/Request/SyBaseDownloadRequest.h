//
//  SyBaseDownloadRequest.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseRequest.h"

@interface SyBaseDownloadRequest : SyBaseRequest

@property (nonatomic, copy) NSString    *imagePath;
@property (nonatomic, assign) id    downloadProgressDelegate;

@end
