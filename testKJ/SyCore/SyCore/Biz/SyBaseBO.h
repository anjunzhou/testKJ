//
//  SyBaseBO.h
//  DaJiaCore
//
//  Created by zhengxiaofeng on 13-6-25.
//  Copyright (c) 2013年 zhengxiaofeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyConstant.h"
#import "SyBaseProvider.h"
#import "SyURLProvider.h"
#import "SyFormProvider.h"
#import "SyCacheManager.h"

@interface SyBaseBO : NSObject<SyProviderDelegate> 


@property (nonatomic, weak) id<SyProviderDelegate> delegate;

@end
