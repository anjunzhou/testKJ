//
//  SyBaseProvider.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSString+SyString.h"
#import "SyBaseResponse.h"
#import "SyBaseRequest.h"

@protocol SyProviderDelegate;

//服务器接口基类，不可直接使用
@interface SyBaseProvider : NSObject {
@protected
    id<SyProviderDelegate>      _delegate;
    SyBaseRequest               *_request;
    SyBaseResponse              *_response;
}

//请求对象
@property (nonatomic, retain) SyBaseRequest     *request;

//返回对象
@property (nonatomic, readonly) SyBaseResponse    *response;

// 存储数据
@property (nonatomic, retain) NSMutableDictionary  *storeDic;


//初始化
- (id)initWithDelegate:(id<SyProviderDelegate>)aDelegate;

//发送请求
- (void)request:(SyBaseRequest *)request;

//取消请求
- (void)cancel;

//继续请求
- (void)start;

//包装异常
- (NSError*)handleError:(NSObject *)error;

@end

@protocol SyProviderDelegate <NSObject>

@optional
//请求成功，通过getResponse获取返回数据
- (void)providerDidFinishLoad:(SyBaseProvider *)provider;

//请求失败
- (void)provider:(SyBaseProvider *)provider didFailLoadWithError:(NSError *)error;

//请求开始发送
- (void)providerDidStartLoad:(SyBaseProvider *)provider;

//请求进度
- (void)provider:(SyBaseProvider *)provider progress:(float)progress;

@end