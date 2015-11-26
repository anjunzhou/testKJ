//
//  SyBasePageResponse.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseResponse.h"

@interface SyBasePageResponse : SyBaseResponse {
    NSInteger       _totalNumber;
    NSInteger       _totalPage;
    NSArray         *_content;
}

@property (nonatomic, assign) NSInteger     totalNumber;
@property (nonatomic, assign) NSInteger     totalPage;
@property (nonatomic, retain) NSArray       *content;

+ (Class)content_class;

@end
