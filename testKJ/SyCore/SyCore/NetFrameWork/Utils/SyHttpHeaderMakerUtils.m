//
//  SyHttpHeaderMakerUtils.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyHttpHeaderMakerUtils.h"
#import "JSON.h"
#import "SyServerManager.h"
#import "SyBaseRequest.h"
#import "SyConstant.h"

@implementation SyHttpHeaderMakerUtils


+ (NSString *)getGetRequestParmetersStrByDic:(NSDictionary *)parametersDic type:(NSInteger)type
{
    NSMutableString *str = [[NSMutableString alloc] init];
    
    NSString *managerName = [parametersDic objectForKey:kManagerName];
    NSString *methodName = [parametersDic objectForKey:kMethodName];
    if (type == kRequestType_get) {
        [str appendFormat:@"%@/%@/%@",[SyServerManager defaultManager].serverAddress,managerName,methodName];
    }
    else if (type == kRequestType_oauth_get) {
        [str appendFormat:@"%@/%@/%@",[SyServerManager defaultManager].oauthAddress,managerName,methodName];
    }
    else if (type == kRequestType_version_get) {
        [str appendFormat:@"%@/%@",[SyServerManager defaultManager].versionAddress,methodName];
    }
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSDictionary *dic = [parametersDic objectForKey:kArguments];
    for (NSString *key in [dic allKeys]) {
        id value = [dic objectForKey:key];
        
        if ([value isKindOfClass:[NSString class]]) {
            // 为空不拼装
//            if (![value isEqual:@""]) {
                [array addObject:[NSString stringWithFormat:@"%@=%@",key,value]];
//            }
        }
        else if ([value isKindOfClass:[NSNumber class]]) {
            NSNumber *number = (NSNumber *)value;
            [array addObject:[NSString stringWithFormat:@"%@=%@",key,number.stringValue]];
        }
    }
    if(array.count > 0){
        [str appendFormat:@"?%@",[array componentsJoinedByString:@"&"]];
    }
    
//    const char *c = [str cStringUsingEncoding:NSISOLatin1StringEncoding];
//    NSString *str2 = [[NSString alloc] initWithCString:c encoding:NSUTF8StringEncoding];
    
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(
                                                                     NULL,
                                                                     (__bridge CFStringRef)str,
                                                                     (__bridge CFStringRef)@"%",
                                                                     NULL, CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding)));
    
    
    //    return (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)str, (CFStringRef)@"%", NULL, kCFStringEncodingUTF8);
}
+ (NSString *)getPostRequestSeverUrlByDic:(NSDictionary *)parametersDic
{
    NSString *str = @"";
    
    NSString *managerName = [parametersDic objectForKey:kManagerName];
    NSString *methodName = [parametersDic objectForKey:kMethodName];
    str = [str stringByAppendingString:[SyServerManager defaultManager].serverAddress];
    if(managerName.length > 0){
        str = [str stringByAppendingFormat:@"/%@",managerName];
    }
    if(methodName.length > 0){
        str = [str stringByAppendingFormat:@"/%@",methodName];
    }
    return str;
}


+ (NSData *)getPostRequestDataByDic:(NSDictionary *)parametersDic
{
    NSString *jsonStr = [[parametersDic objectForKey:kArguments] JSONRepresentation];
    NSLog(@"post:jsonStr %@",jsonStr);
    NSLog(@"size:%ld",strlen([jsonStr UTF8String]));
    return [jsonStr dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    //    return [NSData dataWithBytes:[jsonStr UTF8String] length:strlen([jsonStr UTF8String])];
}


@end
