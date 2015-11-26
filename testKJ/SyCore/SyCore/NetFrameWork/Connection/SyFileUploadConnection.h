//
//  SyFileUploadConnection.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASINetworkQueue.h"
@protocol SyFileUploadConnectionDelegate;

//Http连接类（用于文件上传），支持队列，仅用于保证底层网络框架实现与应用层业务逻辑解耦，不允许加入任何业务逻辑
//基于ASINetworkQueue实现
@interface SyFileUploadConnection : NSObject <ASIHTTPRequestDelegate,ASIProgressDelegate>{
@protected
    id<SyFileUploadConnectionDelegate>      _delegate;
    ASINetworkQueue                         *_networkQueue;
    NSMutableDictionary                     *_allResponses;
    NSData                                  *_response;
    NSString                                *_responseString;
}

//所有文件的返回数据
@property(nonatomic,readonly)NSMutableDictionary        *allResponses;
@property (nonatomic,readonly) NSString                 *responseString;

//最后上传文件的返回数据
@property(nonatomic,readonly)NSData *response;

//初始化
- (id)initWithDelegate:(id<SyFileUploadConnectionDelegate>)delegate;

//开始上传
- (void)startRequest;

//在上传队列中添加文件
- (void)addFile:(NSString *)filePath withUrl:(NSString *)url andParam:(NSMutableDictionary*)param andIdentifier:(NSString*)identifier;

//在上传队列中添加数据
- (void)addData:(NSData *)fileData withUrl:(NSString *)url andParam:(NSMutableDictionary*)param andIdentifier:(NSString*)identifier;

//取消上传队列中的全部请求
- (void)cancel;
@end

@protocol SyFileUploadConnectionDelegate <NSObject>
@optional
//开始上传
- (void)uploadConnectionStart:(SyFileUploadConnection *)connection;

//全部文件上传成功
- (void)uploadConnectionDidFinished:(SyFileUploadConnection *)connection;

//上传失败，单个请求失败会导致后续请求都被取消
- (void)uploadConnection:(SyFileUploadConnection *)connection didFailWithError:(NSObject*)error;

//文件上传成功，队列中的每个请求发送成功后均会调用此方法
- (void)uploadConnectionDidFinished:(SyFileUploadConnection *)connection forIdentifier:(NSString*)identifier andResponse:(NSData*)response;

//反馈上传进度
- (void)uploadConnection:(SyFileUploadConnection *)connection uploadProgress:(CGFloat)progress;
@end