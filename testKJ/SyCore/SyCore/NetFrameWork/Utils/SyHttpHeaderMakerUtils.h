//
//  SyHttpHeaderMakerUtils.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SyHttpHeaderMakerUtils : NSObject

+ (NSString *)getGetRequestParmetersStrByDic:(NSDictionary *)parametersDic type:(NSInteger)type;
+ (NSData *)getPostRequestDataByDic:(NSDictionary *)parametersDic;
+ (NSString *)getPostRequestSeverUrlByDic:(NSDictionary *)parametersDic;

@end
