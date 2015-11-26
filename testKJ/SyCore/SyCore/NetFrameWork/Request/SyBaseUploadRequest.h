//
//  SyBaseUploadRequest.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyBaseRequest.h"

//文件上传请求
@interface SyBaseUploadRequest : SyBaseRequest{
    NSMutableDictionary *_files;
}

@property(nonatomic,readonly)NSMutableDictionary *files;

//初始化
- (id)init;

//添加文件
- (void)addFile:(NSString*)filePath withName:(NSString*)fileName;

//添加文件数据
- (void)addData:(NSData*)fileData withName:(NSString*)fileName;

@end
