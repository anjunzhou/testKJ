//
//  SyBaseUploadRequest.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyBaseUploadRequest.h"

@implementation SyBaseUploadRequest
@synthesize files=_files;


- (id)init{
    self = [super init];
    if (self) {
        _files = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)addFile:(NSString*)filePath withName:(NSString*)fileName{
    [_files setObject:filePath forKey:fileName];
}
- (void)addData:(NSData*)fileData withName:(NSString*)fileName{
    [_files setObject:fileData forKey:fileName];
}
@end
