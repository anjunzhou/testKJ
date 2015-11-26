//
//  SyBaseUploadProvider.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SyBaseProvider.h"
#import "SyFormConnection.h"

@interface SyFormProvider : SyBaseProvider <SyFormConnectionDelegate> {
    SyFormConnection *_conn;
}



@end


