//
//  SyURLConnection.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyURLConnection.h"
#import "JSON.h"
#import "SyBaseRequest.h"
#import "SyHttpHeaderMakerUtils.h"
#define kTimeOut 30
#define kTimeOutPost 30

@implementation SyURLConnection
@synthesize requestType = _requestType;
@synthesize postRequestData = _postRequestData;
@synthesize cokiesFlag = _cokiesFlag;
@synthesize responseData = _responseData;
@synthesize authorizationStr = _authorizationStr;


- (void)cancel
{
    if (_connection) {
        [_connection cancel];
    }
    _isResponse = YES;
    _delegate = nil;
}

- (id)initWithDelegate:(id)aDelegate
{
    self = [super init];
    if (self) {
        _delegate = aDelegate;
    }
    return self;
}

- (void)startRequestWithUrl:(NSString *)serverUrl
{
    NSLog(@"requestURL:%@",serverUrl);
    self.responseData = [[NSMutableData alloc] init];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    if (_requestType == kRequestType_get) {
        [request setHTTPMethod:@"GET"];
        [request setURL:[NSURL URLWithString:serverUrl]];
        [request setTimeoutInterval:kTimeOut];
    }
    else if (_requestType == kRequestType_post) {
        [request setURL:[NSURL URLWithString:serverUrl]];
        [request setHTTPMethod:@"POST"];
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setHTTPBody:_postRequestData];
        
        NSString *dataLength = [NSString stringWithFormat:@"%d",_postRequestData.length];
        [request setValue:dataLength  forHTTPHeaderField:@"Content-Length"];
        
        
        [NSTimer scheduledTimerWithTimeInterval:kTimeOutPost target: self selector: @selector(handleTimer) userInfo:nil repeats:NO];
        _isResponse = NO;
        
    }
    else if (_requestType == kRequestType_oauth_get) {
        [request setHTTPMethod:@"GET"];
        [request setValue:[NSString stringWithFormat:@"Basic %@",_authorizationStr] forHTTPHeaderField:@"Authorization"];
        [request setURL:[NSURL URLWithString:serverUrl]];
    }
    if (_cokiesFlag) {
        [request setHTTPShouldHandleCookies:NO];
    }
    
    if (_connection) {
        [_connection cancel];
    }
    _connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    if (_delegate && [_delegate respondsToSelector:@selector(urlConnectionStart:)]) {
        [_delegate urlConnectionStart:self];
    }
}

#pragma mark- NSURLConnectionDelegate/NSURLConnectionDataDelegate
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    _isResponse = YES;
    NSString* msg = [NSString stringWithFormat:@"Error: %@ %@",
                     [error localizedDescription],
                     [[error userInfo] objectForKey:NSLocalizedFailureReasonErrorKey]];
    NSLog(@"Connection failed: %@", msg);
    if (_delegate && [_delegate respondsToSelector:@selector(urlConnectionDidFailWithError:error:)]) {
        [_delegate performSelector:@selector(urlConnectionDidFailWithError:error:) withObject:self withObject:error];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [_responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
//    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
//    NSDictionary *fields = [HTTPResponse allHeaderFields];
//    NSString *cookie = [fields valueForKey:@"Set-Cookie"];
    
     _statusCode = [(NSHTTPURLResponse *)response statusCode];
    NSLog(@"Response status:%d",_statusCode);
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

    _isResponse = YES;
    NSLog(@"Response: %@",[[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding]);
    if (_statusCode != 200 && _statusCode != 201) {
        if (_delegate && [_delegate respondsToSelector:@selector(urlConnectionDidFailWithError:error:)]) {
            [_delegate performSelector:@selector(urlConnectionDidFailWithError:error:) withObject:self withObject:_responseData];
        }
    }else{
        if (_delegate && [_delegate respondsToSelector:@selector(urlConnectionDidFinished:)]) {
            [_delegate urlConnectionDidFinished:self];
        }
    }
}
// 必须
- (BOOL)connection:(NSURLConnection *)connection canAuthenticateAgainstProtectionSpace:(NSURLProtectionSpace *)protectionSpace
{
    return [protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust];
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge
{
    if ([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust])
    {
        [challenge.sender useCredential:[NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust]forAuthenticationChallenge:challenge];
    }
    [challenge.sender continueWithoutCredentialForAuthenticationChallenge:challenge];
}

-(void) handleTimer
{
    if (!_isResponse) {
        NSLog(@"Connection failed: %@", @"Error: timeout");
        if (_connection) {
            [_connection cancel];
        }
        if (_delegate && [_delegate respondsToSelector:@selector(urlConnectionDidFailWithError:error:)]) {
            [_delegate performSelector:@selector(urlConnectionDidFailWithError:error:) withObject:self withObject:[NSError errorWithDomain:NSURLErrorDomain code:NSURLErrorTimedOut userInfo:nil]];
        }
    }
}

@end
