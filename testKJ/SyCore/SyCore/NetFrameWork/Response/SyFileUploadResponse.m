//
//  SyFileUploadResponse.m
//  SyCore
//
//  Created by menghua.wu on 14-4-23.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyFileUploadResponse.h"

@implementation SyFileUploadResponse

-(NSObject*)handleResult:(NSData*)result {
    NSError *error = nil;
    NSDictionary *jsonObject = [NSJSONSerialization JSONObjectWithData:result options:NSJSONReadingAllowFragments error:&error];
    if (error) {
        return result;
    }else{
        return [jsonObject objectForKey:@"fileID"];
    }
}
@end
