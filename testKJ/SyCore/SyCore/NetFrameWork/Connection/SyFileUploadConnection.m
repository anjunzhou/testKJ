//
//  SyFileUploadConnection.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//


#import "SyFileUploadConnection.h"
#import "SyConstant.h"
#import <UIKit/UIKit.h>
#import "ASIFormDataRequest.h"
#define kUploadRequestParam_file        @"file"
#define kUploadRequestUserInfo_id       @"id"
#define kUploadRequestResp              @"resp"
#define kUploadRequestTimeOut           30
#define kUploadRequestConcurrentOperationCount           30

@implementation SyFileUploadConnection
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

- (id)initWithDelegate:(id<SyFileUploadConnectionDelegate>)delegate
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

- (void)addFile:(NSString *)filePath withUrl:(NSString *)url andParam:(NSMutableDictionary*)param andIdentifier:(NSString*)identifier{
    
    NSLog(@"post url : %@",url);
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [req setTimeOutSeconds:kUploadRequestTimeOut];
    [req addFile:filePath forKey:kUploadRequestParam_file];
    if (identifier) {
        [req setUserInfo:[NSDictionary dictionaryWithObject:identifier forKey:kUploadRequestUserInfo_id]];
    }
    if (param) {
        NSEnumerator * eKey = [param keyEnumerator];
        for (NSString *key in eKey) {
            NSLog(@"post key : %@  -----   value:%@",key,[param objectForKey:key]);
            [req addPostValue:[param objectForKey:key]  forKey:key];
        }
    }
    [_networkQueue addOperation:req];
}

- (void)addData:(NSData *)fileData withUrl:(NSString *)url andParam:(NSMutableDictionary*)param andIdentifier:(NSString*)identifier{
    
    NSLog(@"post url : %@",url);
    ASIFormDataRequest *req = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:url]];
    [req setTimeOutSeconds:kUploadRequestTimeOut];
    [req addData:fileData forKey:kUploadRequestParam_file];
    if (identifier) {
        [req setUserInfo:[NSDictionary dictionaryWithObject:identifier forKey:kUploadRequestUserInfo_id]];
    }
    if (param) {
        NSEnumerator * eKey = [param keyEnumerator];
        for (NSString *key in eKey) {
            NSLog(@"post key : %@  -----   value:%@",key,[param objectForKey:key]);
            [req addPostValue:[param objectForKey:key]  forKey:key];
        }
    }
    [_networkQueue addOperation:req];
}

- (void)requestDidStart:(ASIFormDataRequest *)aASIHTTPRequest
{
    if (_delegate && [_delegate respondsToSelector:@selector(uploadConnectionStart:)]) {
        [_delegate uploadConnectionStart:self];
    }
}

- (void)requestDidFinish:(ASIFormDataRequest *)aASIHTTPRequest
{
    int status = [aASIHTTPRequest responseStatusCode];
    _responseString = [aASIHTTPRequest responseString];
    NSLog(@"ret code: %d   ---  responseString:%@",status,_responseString);
    if (status != 201 && status != 200) {
        if (_delegate && [_delegate respondsToSelector:@selector(uploadConnection:didFailWithError:)]) {
            [_delegate uploadConnection:self didFailWithError:_response];
        }
        [_networkQueue cancelAllOperations];
    }else{
        NSString *key = nil;
        if ([aASIHTTPRequest userInfo]) {
            key = [[aASIHTTPRequest userInfo] objectForKey:kUploadRequestUserInfo_id];
            [_allResponses setObject:[aASIHTTPRequest responseData]  forKey: key];
        }
        
        if (_delegate && [_delegate respondsToSelector:@selector(uploadConnectionDidFinished:forIdentifier:andResponse:)]) {
            [_delegate uploadConnectionDidFinished:self forIdentifier:key andResponse:_response];
        }
    }
}


- (void)requestDidFail:(ASIFormDataRequest *)aASIHTTPRequest
{
    if (_delegate && [_delegate respondsToSelector:@selector(uploadConnection:didFailWithError:)]) {
        [_delegate uploadConnection:self didFailWithError:[aASIHTTPRequest error]];
        
    }
}


- (void)queueDidFinish:(ASINetworkQueue *)aASINetworkQueue
{
    if (_delegate && [_delegate respondsToSelector:@selector(uploadConnectionDidFinished:)]) {
        [_delegate uploadConnectionDidFinished:self];
    }
}

#pragma mark-
- (void)setProgress:(float)newProgress
{
    if (_delegate && [_delegate respondsToSelector:@selector(uploadConnection:uploadProgress:)]) {
        [_delegate uploadConnection:self uploadProgress:newProgress];
    }
}
@end
