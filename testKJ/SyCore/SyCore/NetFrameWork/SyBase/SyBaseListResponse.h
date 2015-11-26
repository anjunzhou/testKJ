//
//  SyBaseListResponse.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseResponse.h"

@interface SyBaseListResponse : SyBaseResponse

@property (nonatomic, strong) NSArray   *dataArray;

+ (Class)dataArray_class;

@end



/*
 *  返回数组 解析
 */