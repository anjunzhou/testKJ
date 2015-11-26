//
//  SyBaseDownloadProvider.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseDownloadProvider.h"
#import "SyBaseRequest.h"
#import "SyHttpHeaderMakerUtils.h"
#import "SyBaseDownloadRequest.h"
#import "NSString+SyString.h"
#import "SyServerManager.h"

@implementation SyBaseDownloadProvider

- (void)cancel
{
    [_downloadConnection cancel];
}

- (void)start
{
    [_downloadConnection startRequest];
}

- (void)request:(SyBaseRequest *)request
{
    [super request:request];
    if (!_downloadConnection) {
        _downloadConnection = [[SyFileDownloadConnection alloc] initWithDelegate:self];
    }
    NSDictionary *parmDic = [request parametersDic];
    NSString *url = [SyHttpHeaderMakerUtils getGetRequestParmetersStrByDic:parmDic type:request.requestType];
    if(request.requestPath){
        url = [url replaceCharacter:[SyServerManager defaultManager].serverAddress withString:request.requestPath];
    }
    [_downloadConnection addRequestWithUrl:url andFilePath:[(SyBaseDownloadRequest *)request imagePath]];
    [_downloadConnection startRequest];
}


- (void)downloadConnectionDidFinished:(SyFileDownloadConnection *)connection
{
    
}

- (void)downloadConnection:(SyFileDownloadConnection *)connection filePath:(NSString *)filePath
{
    
    if (filePath) {
        NSString *responseClass = [NSStringFromClass([_request class]) replaceCharacter:@"Request" withString:@"Response"];
        _response = [[NSClassFromString(responseClass) alloc] init];
        if ([_response respondsToSelector:@selector(setImagePath:)]) {
            [_response performSelector:@selector(setImagePath:) withObject:filePath];
        }
    }
    if (_delegate && [_delegate respondsToSelector:@selector(providerDidFinishLoad:)]) {
        [_delegate providerDidFinishLoad:self];
    }
}

- (void)downloadConnectionStart:(SyFileDownloadConnection *)connection
{
    if (_delegate && [_delegate respondsToSelector:@selector(providerDidStartLoad:)]) {
        [_delegate providerDidStartLoad:self];
    }
}

- (void)downloadConnection:(SyFileDownloadConnection *)connection didFailWithError:(NSError *)error
{
    
    if (_delegate && [_delegate respondsToSelector:@selector(provider:didFailLoadWithError:)]) {
        //[_delegate provider:self didFailLoadWithError:nil];
        [_delegate provider:self didFailLoadWithError:[super handleError:error]];
    }
}

- (void)downloadConnection:(SyFileDownloadConnection *)connection downloadProgress:(CGFloat)progress
{
    if (_delegate && [_delegate respondsToSelector:@selector(provider:progress:)]) {
        [_delegate provider:self progress:progress];
    }
}


@end
