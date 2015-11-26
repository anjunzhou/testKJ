//
//  SyURLConnection.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol SyURLConnectionDelegate;

//Http连接类（用于普通业务请求），仅用于保证底层网络框架实现与应用层业务逻辑解耦，不允许加入任何业务逻辑
//采用NSURLConnection实现http网络连接
@interface SyURLConnection : NSObject<NSURLConnectionDelegate,
NSURLConnectionDataDelegate>
{
@protected
    id<SyURLConnectionDelegate>     _delegate;  
    NSUInteger              _requestType;       
    NSData                  *_postRequestData; 
    NSURLConnection         *_connection;
    NSMutableData           *_responseData; 
    BOOL                    _cokiesFlag;
    NSInteger               _statusCode;
    BOOL                    _isResponse;
}

//http请求类型，1：get 2：post
@property (nonatomic, assign) NSUInteger        requestType;
//request body数据（post）
@property (nonatomic, strong) NSData            *postRequestData;
//是否保存cookie
@property (nonatomic, assign) BOOL              cokiesFlag;
//返回数据
@property (nonatomic, strong) NSMutableData     *responseData;
//
@property (nonatomic, strong) NSString      *authorizationStr;

//初始化连接，每次向服务端发请求需要创建新对象
- (id)initWithDelegate:(id)aDelegate;

//发送请求，如post请求先调用setPostRequestData传参
- (void)startRequestWithUrl:(NSString *)serverUrl;

//取消请求
- (void)cancel;
@end

@protocol SyURLConnectionDelegate <NSObject>
@optional
//请求结束，返回响应数据
- (void)urlConnectionDidFinished:(SyURLConnection *)connection;
//请求失败，返回错误信息
- (void)urlConnectionDidFailWithError:(SyURLConnection *)connection error:(NSObject*)error;
//请求开始
- (void)urlConnectionStart:(SyURLConnection *)connection;
@end