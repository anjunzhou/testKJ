//
//  SyBaseUploadResponse.h
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseResponse.h"

//上传响应对象
@interface SyBaseUploadResponse : SyBaseResponse {
    NSMutableDictionary *_result;
}

@property(nonatomic, strong)NSMutableDictionary    *result;

-(void)addResult:(NSString*)result withKey:(NSString*)key;

-(NSObject*)handleResult:(NSData*)result;

@end
