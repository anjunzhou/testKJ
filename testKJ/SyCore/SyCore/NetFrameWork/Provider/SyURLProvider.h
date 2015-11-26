//
//  SyURLProvider.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyBaseProvider.h"
#import "SyURLConnection.h"

@class SyBaseResponse;
@class SyBaseRequest;

//服务器业务接口
@interface SyURLProvider : SyBaseProvider <SyURLConnectionDelegate> {
    SyURLConnection             *_urlConnection;
}
@end
