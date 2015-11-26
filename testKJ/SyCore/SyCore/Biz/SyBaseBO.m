//
//  SyBaseBO.m
//  DaJiaCore
//
//  Created by zhengxiaofeng on 13-6-25.
//  Copyright (c) 2013年 zhengxiaofeng. All rights reserved.
//

#import "SyBaseBO.h"

@implementation SyBaseBO
@synthesize delegate = _delegate;

- (void)providerDidStartLoad:(SyBaseProvider *)provider
{
    if (_delegate && [_delegate respondsToSelector:@selector(providerDidStartLoad:)]) {
        [_delegate providerDidStartLoad:provider];
    }
}

- (void)providerDidFinishLoad:(SyBaseProvider *)provider
{
    if (_delegate && [_delegate respondsToSelector:@selector(providerDidFinishLoad:)]) {
        [_delegate providerDidFinishLoad:provider];
    }
}

- (void)provider:(SyBaseProvider *)provider didFailLoadWithError:(NSError *)error
{
    if (_delegate && [_delegate respondsToSelector:@selector(provider:didFailLoadWithError:)]) {
        [_delegate provider:provider didFailLoadWithError:error];
    }
}

- (void)providerRequestWithNetInvalid:(SyBaseProvider *)provider
{
    if (_delegate && [_delegate respondsToSelector:@selector(providerRequestWithNetInvalid:)]) {
        //[_delegate providerRequestWithNetInvalid:provider];
    }
}

@end
