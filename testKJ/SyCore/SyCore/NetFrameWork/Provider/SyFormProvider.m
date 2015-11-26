//
//  SyBaseUploadProvider.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyFormProvider.h"
#import "SyBaseRequest.h"
#import "SyHttpHeaderMakerUtils.h"
#import "NSString+SyString.h"
#import "SyServerManager.h"

#define K_RequestTimeOutNotification @"requestTimeOutNotification"

@implementation SyFormProvider

- (void)cancel
{
    [_conn cancel];
}

- (void)request:(SyBaseRequest *)request
{
    [super request:request];
    if (!_conn) {
        _conn = [[SyFormConnection alloc] initWithDelegate:self];
    }
    NSDictionary *parmDic = [request parametersDic];
    NSString *url = [SyHttpHeaderMakerUtils getPostRequestSeverUrlByDic:parmDic];
    if(request.requestPath){
        url = [url replaceCharacter:[SyServerManager defaultManager].serverAddress withString:request.requestPath];
    }
    [_conn addData:url andParam:[parmDic objectForKey:kArguments] andIdentifier:[parmDic objectForKey:kMethodName]];
    [_conn startRequest];
}

- (void)formConnectionStart:(SyFormConnection *)connection{
    if (_delegate && [_delegate respondsToSelector:@selector(providerDidStartLoad:)]) {
        [_delegate providerDidStartLoad:self];
    }
}
- (void)formConnectionDidFinished:(SyFormConnection *)connection {
    NSError *error = nil;
    if([connection.responseString isEqualToString:@"req-timeout"]){
        
        NSDictionary *dictionary = [NSDictionary dictionaryWithObjectsAndKeys:@"req-timeout",@"reqtimeout", nil];
        [[NSNotificationCenter defaultCenter] postNotificationName:K_RequestTimeOutNotification object:dictionary];
        return;
    }
    
    NSString *responseClass = [NSStringFromClass([_request class]) replaceCharacter:@"Request" withString:@"Response"];
    if(connection.responseString.length > 0){
        id jsonObject = [connection.responseString JSONValue];
        if (jsonObject != nil && error == nil){
            _response = [[NSClassFromString(responseClass) alloc] init];
            [_response initWithDictionary:jsonObject];
        }
        for (NSString *key in [[connection allResponses] allKeys]) {
            if ([_response respondsToSelector:@selector(addResult:withKey:)]) {
                [_response performSelector:@selector(addResult:withKey:) withObject:[[connection allResponses] objectForKey:key] withObject:key];
            }
        }
    }
    
    if (_delegate && [_delegate respondsToSelector:@selector(providerDidFinishLoad:)]) {
        [_delegate providerDidFinishLoad:self];
    }
    
}
- (void)formConnection:(SyFormConnection *)connection didFailWithError:(NSObject*)error {
    if (_delegate && [_delegate respondsToSelector:@selector(provider:didFailLoadWithError:)]) {
        [_delegate provider:self didFailLoadWithError:nil];
    }
}
- (void)formConnectionDidFinished:(SyFormConnection *)connection forIdentifier:(NSString*)identifier andResponse:(NSData*)response {
    //暂不支持
}

- (void)formConnection:(SyFormConnection *)connection uploadProgress:(CGFloat)progress {
    if (_delegate && [_delegate respondsToSelector:@selector(provider:progress:)]) {
        [_delegate provider:self progress:progress];
    }
}
@end
