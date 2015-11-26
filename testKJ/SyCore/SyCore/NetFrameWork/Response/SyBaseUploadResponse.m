//
//  SyBaseUploadResponse.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseUploadResponse.h"

@implementation SyBaseUploadResponse
@synthesize result=_result;


- (id)init{
    self = [super init];
    if (self) {
        _result = [[NSMutableDictionary alloc] init];
    }
    return self;
}
-(void)addResult:(NSData*)result withKey:(NSString*)key {
    [_result setObject:[self handleResult:result] forKey:key];
}

-(NSObject*)handleResult:(NSData*)result {
    //todo sub
    return result;
}

@end
