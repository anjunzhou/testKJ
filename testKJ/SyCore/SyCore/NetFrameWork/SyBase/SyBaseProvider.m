//
//  SyBaseProvider.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseProvider.h"
#import "SyBaseRequest.h"
#import "SyBaseResponse.h"
#import "SyConstant.h"


@implementation SyBaseProvider
@synthesize request = _request;
@synthesize response = _response;
@synthesize storeDic = _storeDic;

- (id)initWithDelegate:(id<SyProviderDelegate>)aDelegate
{
    self = [super init];
    if (self) {
        _delegate = aDelegate;
        _storeDic = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)request:(SyBaseRequest *)request
{
    self.request = request;
    
}

- (void)cancel
{
    // TODO SUB
}

- (void)start
{
    // TODO SUB
}

- (NSError*)handleError:(NSObject *)error
{
    NSLog(@"error to provider");
    NSError *se = nil;
    if ([error isKindOfClass:([NSError class])]) {
        se = (NSError*)error;
    }else if([error isKindOfClass:([NSData class])]){
        NSError *er = nil;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:(NSData*)error options:NSJSONReadingAllowFragments error:&er];
        if ([dic objectForKey:kServerErrorMessage]) {
            NSDictionary *uInfo = [NSMutableDictionary dictionaryWithObject:[dic objectForKey:kServerErrorMessage] forKey:NSLocalizedDescriptionKey];
            if ([dic objectForKey:kServerErrorStack]) {
                [uInfo setValue:[dic objectForKey:kServerErrorStack] forKey:kServerErrorStack];
            }
            if ([dic objectForKey:kServerExceptionID]) {
                [uInfo setValue:[dic objectForKey:kServerExceptionID] forKey:kServerExceptionID];
            }
            se = [NSError errorWithDomain:kDajiaErrorDomain code:[[dic objectForKey:kServerErrorCode] integerValue]  userInfo:uInfo];
        }
        else if([dic objectForKey:kAuthError]) {
            se = [NSError errorWithDomain:kDajiaAuthErrorDomain code:kAuthErrorInvalidGrant  userInfo:nil];
        }
    }
    return se;
}


@end
