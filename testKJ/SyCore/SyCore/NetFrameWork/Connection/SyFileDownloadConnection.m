//
//  SyFileDownloadConnection.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#define kDownloadRequestUserInfo_fileName        @"fileName"

#import "SyFileDownloadConnection.h"
#import "SyConstant.h"
//#import "SyError.h"

@implementation SyFileDownloadConnection

- (void)startRequest
{
    if (_networkQueue && _networkQueue.requestsCount > 0) {
        [_networkQueue go];
    }
}

- (void)cancel
{
    if (_networkQueue) {
        [_networkQueue cancelAllOperations];
    }
}

- (id)initWithDelegate:(id<SyFileDownloadConnectionDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _networkQueue = [[ASINetworkQueue alloc] init];
        [_networkQueue setShowAccurateProgress:YES];
        [_networkQueue setRequestDidStartSelector:@selector(requestDidStart:)];
        [_networkQueue setRequestDidFinishSelector:@selector(requestDidFinish:)];
        [_networkQueue setRequestDidFailSelector:@selector(requestDidFail:)];
        [_networkQueue setQueueDidFinishSelector:@selector(queueDidFinish:)];
        [_networkQueue setDelegate:self];
        _networkQueue.maxConcurrentOperationCount = 5;
    }
    return self;
}

- (void)addRequestWithUrl:(NSString *)url andFilePath:(NSString *)path
{
    NSLog(@"下载 url：%@, path：%@",url,path);
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:url]];
    [request setDownloadProgressDelegate:self];
    [request setDownloadDestinationPath:path];
    [request setShouldAttemptPersistentConnection:NO];
    [_networkQueue addOperation:request];
    
    
}

- (void)requestDidStart:(ASIHTTPRequest *)aASIHTTPRequest
{
    if (_delegate && [_delegate respondsToSelector:@selector(downloadConnectionStart:)]) {
        [_delegate downloadConnectionStart:self];
    }
}

- (void)requestDidFinish:(ASIHTTPRequest *)aASIHTTPRequest
{
    NSError *error = nil;
    NSString *filePath = aASIHTTPRequest.downloadDestinationPath;
    /*
        zhengxiaofeng 2013.12.19
        ASI 请求 400 的时候 内部并不认为位错误信息流
        同样返回 文件流
        这是 我们做相应解析
     */
    if (aASIHTTPRequest.responseStatusCode == 400 || aASIHTTPRequest.responseStatusCode == 200) {
        NSData *data = [NSData dataWithContentsOfFile:filePath];
        if (!data) {
            return;
        }
        
        id jsonObject = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (jsonObject != nil && error == nil){
//            SyError *error = [[SyError alloc] initWithDictionary:jsonObject];
            if (_delegate && [_delegate respondsToSelector:@selector(downloadConnection:didFailWithError:)]) {
                // 错误处理
                [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
//                [_delegate downloadConnection:self didFailWithError:[NSError errorWithDomain:kDajiaErrorDomain code:error.errorCode.integerValue  userInfo:jsonObject]];
            }
            return;
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(downloadConnection:filePath:)]) {
        [_delegate downloadConnection:self filePath:filePath];
    }
}

- (void)requestDidFail:(ASIHTTPRequest *)aASIHTTPRequest
{
    if (_delegate && [_delegate respondsToSelector:@selector(downloadConnection:didFailWithError:)]) {
        [_delegate downloadConnection:self didFailWithError:aASIHTTPRequest.error];
    }
}

- (void)queueDidFinish:(ASINetworkQueue *)aASINetworkQueue
{
    if (_delegate && [_delegate respondsToSelector:@selector(downloadConnectionDidFinished:)]) {
        [_delegate downloadConnectionDidFinished:self];
    }
}

#pragma mark-
- (void)setProgress:(float)newProgress
{
    if (_delegate && [_delegate respondsToSelector:@selector(downloadConnection:downloadProgress:)]) {
        [_delegate downloadConnection:self downloadProgress:newProgress];
    }
}

@end
