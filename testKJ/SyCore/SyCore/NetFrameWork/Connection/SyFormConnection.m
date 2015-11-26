//
//  SyFileUploadConnection.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//


#import "SyFormConnection.h"
#import "SyConstant.h"
#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#define kUploadRequestParam_file        @"file"
#define kUploadRequestUserInfo_id       @"id"
#define kUploadRequestResp              @"resp"
#define kUploadRequestTimeOut           30
#define kUploadRequestConcurrentOperationCount           30

@implementation SyFormConnection
@synthesize allResponses=_allResponses;
@synthesize response=_response;

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

- (id)initWithDelegate:(id<SyFormConnectionDelegate>)delegate
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _networkQueue = [[ASINetworkQueue alloc] init];
        [_networkQueue setRequestDidStartSelector:@selector(requestDidStart:)];
        [_networkQueue setRequestDidFinishSelector:@selector(requestDidFinish:)];
        [_networkQueue setRequestDidFailSelector:@selector(requestDidFail:)];
        [_networkQueue setQueueDidFinishSelector:@selector(queueDidFinish:)];
        [_networkQueue setUploadProgressDelegate:self];
        [_networkQueue setShowAccurateProgress:YES];
        [_networkQueue setDelegate:self];
        _networkQueue.maxConcurrentOperationCount = kUploadRequestConcurrentOperationCount;
        _allResponses = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addData:(NSString *)url andParam:(NSMutableDictionary*)param andIdentifier:(NSString*)identifier{
    NSLog(@"post url : %@",url);
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    req.delegate = self;
//    [req setAuthenticationScheme:@"https"];//设置验证方式
//    [req setValidatesSecureCertificate:YES];//设置验证证书
//    req.validatesSecureCertificate = YES;
    [req setValidatesSecureCertificate:NO];
    
    [req setTimeOutSeconds:kUploadRequestTimeOut];
    if (identifier) {
        [req setUserInfo:[NSDictionary dictionaryWithObject:identifier forKey:kUploadRequestUserInfo_id]];
    }
    if (param) {
        NSEnumerator * eKey = [param keyEnumerator];
        for (NSString *key in eKey) {
            NSLog(@"post key : %@  -----   value:%@",key,[param objectForKey:key]);
            [req setPostValue:[param objectForKey:key] forKey:key];
        }
    }
    [_networkQueue addOperation:req];
}

- (void)requestDidStart:(ASIFormDataRequest *)aASIHTTPRequest
{
    if (_delegate && [_delegate respondsToSelector:@selector(formConnectionStart:)]) {
        [_delegate formConnectionStart:self];
    }
}

- (void)requestDidFinish:(ASIFormDataRequest *)aASIHTTPRequest
{
    int status = [aASIHTTPRequest responseStatusCode];
    NSLog(@"ret code: %d",status);
    _response = [aASIHTTPRequest responseData];
    _responseString = [aASIHTTPRequest responseString];
    NSLog(@"responseString: %@",_responseString);
    if (status != 201 && status != 200) {
        if (_delegate && [_delegate respondsToSelector:@selector(formConnection:didFailWithError:)]) {
            [_delegate formConnection:self didFailWithError:_response];
        }
        [_networkQueue cancelAllOperations];
    }else{
        NSString *key = nil;
        if ([aASIHTTPRequest userInfo]) {
            key = [[aASIHTTPRequest userInfo] objectForKey:kUploadRequestUserInfo_id];
            [_allResponses setObject:[aASIHTTPRequest responseData]  forKey: key];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(formConnectionDidFinished:forIdentifier:andResponse:)]) {
            [_delegate formConnectionDidFinished:self forIdentifier:key andResponse:_response];
        }
    }
}


- (void)requestDidFail:(ASIFormDataRequest *)aASIHTTPRequest
{
    if (_delegate && [_delegate respondsToSelector:@selector(formConnection:didFailWithError:)]) {
        [_delegate formConnection:self didFailWithError:[aASIHTTPRequest error]];
        
    }
}

- (void)queueDidFinish:(ASINetworkQueue *)aASINetworkQueue
{
    if (_delegate && [_delegate respondsToSelector:@selector(formConnectionDidFinished:)]) {
        [_delegate formConnectionDidFinished:self];
    }
}

#pragma mark-
- (void)setProgress:(float)newProgress
{
    if (_delegate && [_delegate respondsToSelector:@selector(formConnection:uploadProgress:)]) {
        [_delegate formConnection:self uploadProgress:newProgress];
    }
}
@end
