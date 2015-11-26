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
@protocol SyFormConnectionDelegate;

//Http连接类（用于表单提交），支持队列，仅用于保证底层网络框架实现与应用层业务逻辑解耦，不允许加入任何业务逻辑
//基于ASINetworkQueue实现
@interface SyFormConnection : NSObject <ASIHTTPRequestDelegate,ASIProgressDelegate>{
@protected
    id<SyFormConnectionDelegate>            _delegate;
    ASINetworkQueue                         *_networkQueue;
    NSMutableDictionary                     *_allResponses;
    NSData                                  *_response;
    NSString                                *_responseString;
}

//所有文件的返回数据
@property (nonatomic,readonly) NSMutableDictionary      *allResponses;

//最后上传文件的返回数据
@property (nonatomic,readonly) NSData                   *response;
@property (nonatomic,readonly) NSString                 *responseString;

//初始化
- (id)initWithDelegate:(id<SyFormConnectionDelegate>)delegate;

//开始上传
- (void)startRequest;

//在上传队列中添加数据
- (void)addData:(NSString *)url andParam:(NSMutableDictionary*)param andIdentifier:(NSString*)identifier;
- (void)addDataGet:(NSString *)url andParam:(NSMutableDictionary*)param andIdentifier:(NSString *)identifier;

//取消上传队列中的全部请求
- (void)cancel;
@end

@protocol SyFormConnectionDelegate <NSObject>
@optional
//开始请求
- (void)formConnectionStart:(SyFormConnection *)connection;

//请求成功
- (void)formConnectionDidFinished:(SyFormConnection *)connection;

//请求失败
- (void)formConnection:(SyFormConnection *)connection didFailWithError:(NSObject*)error;

//目前禁用
- (void)formConnectionDidFinished:(SyFormConnection *)connection forIdentifier:(NSString*)identifier andResponse:(NSData*)response;

//反馈上传进度
- (void)formConnection:(SyFormConnection *)connection uploadProgress:(CGFloat)progress;
@end