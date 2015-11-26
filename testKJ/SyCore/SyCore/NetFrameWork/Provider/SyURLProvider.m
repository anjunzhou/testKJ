//
//  SyURLProvider.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//
#define K_RequestTimeOutNotification @"requestTimeOutNotification"

#import "SyURLProvider.h"
#import "SyBaseRequest.h"
#import "SyHttpHeaderMakerUtils.h"
#import "SySecurityUtil.h"
#import "NSString+SyString.h"
#import "SyServerManager.h"


@implementation SyURLProvider


- (void)cancel
{
    [_urlConnection cancel];
}

- (void)request:(SyBaseRequest *)request
{
    [super request:request];
    
    if (_urlConnection) {
        [_urlConnection cancel];
    }
    _urlConnection =  [[SyURLConnection alloc] initWithDelegate:self];
    _urlConnection.requestType = request.requestType;
    
    NSString *_requestPath = @"";
    if (request.requestType == kRequestType_get) {
        _requestPath = [SyHttpHeaderMakerUtils getGetRequestParmetersStrByDic:[request parametersDic] type:kRequestType_get];
    }
    else if (request.requestType == kRequestType_post) {
        _urlConnection.postRequestData = [SyHttpHeaderMakerUtils getPostRequestDataByDic:request.parametersDic];
        _requestPath = [SyHttpHeaderMakerUtils getPostRequestSeverUrlByDic:request.parametersDic];
    }
    else if (request.requestType == kRequestType_oauth_get) {
        _urlConnection.authorizationStr = [SySecurityUtil encodeBase64String:@"esnMobileClient:esnMobile"];
        _requestPath = [SyHttpHeaderMakerUtils getGetRequestParmetersStrByDic:[request parametersDic] type:kRequestType_oauth_get];
    }
    else if (request.requestType == kRequestType_version_get) {
        _urlConnection.requestType = kRequestType_get;
        _requestPath = [SyHttpHeaderMakerUtils getGetRequestParmetersStrByDic:[request parametersDic] type:kRequestType_version_get];
    }
    if(request.requestPath){
        _requestPath = [_requestPath replaceCharacter:[SyServerManager defaultManager].serverAddress withString:request.requestPath];
    }
    [_urlConnection startRequestWithUrl:_requestPath];
}

#pragma mark- SyURLConnectionDelegate
- (void)urlConnectionDidFailWithError:(SyURLConnection *)connection error:(NSObject *)error
{
    if (_delegate && [_delegate respondsToSelector:@selector(provider:didFailLoadWithError:)]) {
        [_delegate provider:self didFailLoadWithError:[super handleError:error]];
    }
}

- (void)urlConnectionDidFinished:(SyURLConnection *)connection
{
    
    NSError *error = nil;
    NSString* aStr= [[NSString alloc] initWithData:connection.responseData encoding:NSUTF8StringEncoding];
    
    if([aStr isEqualToString:@"req-timeout"]){
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"req-timeout",@"reqtimeout", nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:K_RequestTimeOutNotification object:dictionary];
        
        return;
    }
    id jsonObject = [aStr JSONValue];
    if(connection.requestType == kRequestType_get){
    
        if (jsonObject != nil && error == nil){
            NSString *responseClass = [NSStringFromClass([_request class]) replaceCharacter:@"Request" withString:@"Response"];
            _response = [[NSClassFromString(responseClass) alloc] init];
            [_response initWithObject:jsonObject];
        }
    }else if(connection.requestType == kRequestType_post){
    
        if (jsonObject != nil && error == nil){
            NSString *responseClass = [NSStringFromClass([_request class]) replaceCharacter:@"Request" withString:@"Response"];
            _response = [[NSClassFromString(responseClass) alloc] init];
            [_response initWithDictionary:jsonObject];
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(providerDidFinishLoad:)]) {
        
        [_delegate providerDidFinishLoad:self];
    }
}

- (void)urlConnectionStart:(SyURLConnection *)connection
{
    if (_delegate && [_delegate respondsToSelector:@selector(providerDidStartLoad:)]) {
        [_delegate providerDidStartLoad:self];
    }
}


@end
