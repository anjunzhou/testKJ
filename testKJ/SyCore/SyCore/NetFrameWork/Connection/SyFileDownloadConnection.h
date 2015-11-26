//
//  SyFileDownloadConnection.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
@protocol SyFileDownloadConnectionDelegate;

//Http连接类（用于文件下载），支持队列，仅用于保证底层网络框架实现与应用层业务逻辑解耦，不允许加入任何业务逻辑
//基于ASINetworkQueue实现
@interface SyFileDownloadConnection : NSObject <ASIHTTPRequestDelegate,ASIProgressDelegate>{

@protected
    id<SyFileDownloadConnectionDelegate>    _delegate;
    ASINetworkQueue                         *_networkQueue;
}

//初始化
- (id)initWithDelegate:(id<SyFileDownloadConnectionDelegate>)delegate;

//添加下载请求地址及保存路径
- (void)addRequestWithUrl:(NSString *)url andFilePath:(NSString*)path;

//开始下载
- (void)startRequest;

//取消所有下载请求
- (void)cancel;

@end

@protocol SyFileDownloadConnectionDelegate <NSObject>

@optional
//下载请求开始
- (void)downloadConnectionStart:(SyFileDownloadConnection *)connection;
//下载队列结束
- (void)downloadConnectionDidFinished:(SyFileDownloadConnection *)connection;
//下载请求结束
- (void)downloadConnection:(SyFileDownloadConnection *)connection filePath:(NSString*)filePath;
//请求失败
- (void)downloadConnection:(SyFileDownloadConnection *)connection didFailWithError:(NSError*)error;
//下载进度反馈
- (void)downloadConnection:(SyFileDownloadConnection *)connection downloadProgress:(CGFloat)progress;

@end