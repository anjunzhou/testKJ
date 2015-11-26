//
//  SyBaseUploadProvider.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseUploadProvider.h"
#import "SyHttpHeaderMakerUtils.h"
#import "SyBaseUploadRequest.h"
#import "SyServerManager.h"


#define kFilename     @"filename"

@implementation SyBaseUploadProvider

- (void)cancel
{
    [_conn cancel];
}

- (void)request:(SyBaseRequest *)request
{
    [super request:request];
    if (!_conn) {
        _conn = [[SyFileUploadConnection alloc] initWithDelegate:self];
    }
    
    NSDictionary *parmDic = [request parametersDic];
    NSDictionary *fileDic = [((SyBaseUploadRequest *)request) files];
    NSString *url = [SyHttpHeaderMakerUtils getPostRequestSeverUrlByDic:parmDic];
    if(request.requestPath){
        url = [url replaceCharacter:[SyServerManager defaultManager].serverAddress withString:request.requestPath];
    }
    
    for (NSString *key in [fileDic allKeys]) {
        NSMutableDictionary *args = [NSMutableDictionary dictionaryWithDictionary:[parmDic objectForKey:kArguments]];
        [args setObject:key forKey:kFilename];
        NSLog(@"args   :   %@",args);
        NSObject *file = [fileDic objectForKey:key];
        if ([file isKindOfClass:[NSString class]] ) {
            [_conn addFile:[fileDic objectForKey:key] withUrl:url andParam:args andIdentifier:key];
        } else if([file isKindOfClass:[NSData class]] ){
            [_conn addData:[fileDic objectForKey:key] withUrl:url andParam:args andIdentifier:key];
        }
    }
    [_conn startRequest];
}

- (void)uploadConnectionStart:(SyFileUploadConnection *)connection{
    if (_delegate && [_delegate respondsToSelector:@selector(providerDidStartLoad:)]) {
        [_delegate providerDidStartLoad:self];
    }
}
- (void)uploadConnectionDidFinished:(SyFileUploadConnection *)connection {
    
    NSError *error = nil;
    NSString *responseClass = [NSStringFromClass([_request class]) replaceCharacter:@"Request" withString:@"Response"];
    _response = [[NSClassFromString(responseClass) alloc] init];
    NSLog(@"connection.responseString:%@",connection.responseString);
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
- (void)uploadConnection:(SyFileUploadConnection *)connection didFailWithError:(NSObject*)error {
    if (_delegate && [_delegate respondsToSelector:@selector(provider:didFailLoadWithError:)]) {
        [_delegate provider:self didFailLoadWithError:nil];
    }
}
- (void)uploadConnectionDidFinished:(SyFileUploadConnection *)connection forIdentifier:(NSString*)identifier andResponse:(NSData*)response {
    //暂不支持
}

- (void)uploadConnection:(SyFileUploadConnection *)connection uploadProgress:(CGFloat)progress {
    if (_delegate && [_delegate respondsToSelector:@selector(provider:progress:)]) {
        [_delegate provider:self progress:progress];
    }
}
@end
