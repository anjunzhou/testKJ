//
//  SyBasePageResponse.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBasePageResponse.h"

@implementation SyBasePageResponse
@synthesize totalNumber = _totalNumber;
@synthesize totalPage = _totalPage;
@synthesize content = _content;

+ (Class)content_class
{
    // TODO SUBCLASS
    return [NSObject class];
}

@end
