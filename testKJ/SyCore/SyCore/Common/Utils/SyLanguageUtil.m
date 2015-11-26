//
//  SyLanguageUtil.m
//  SyCore
//
//  Created by 愤怒熊 on 14-6-16.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "SyLanguageUtil.h"

@implementation SyLanguageUtil

+ (BOOL )getPreferredLanguage{
    NSUserDefaults* defs = [NSUserDefaults standardUserDefaults];
    NSArray* languages = [defs objectForKey:@"AppleLanguages"];
    NSString* preferredLang = [languages objectAtIndex:0];
    if([preferredLang isEqualToString:@"en"]){
        return false;
    }else{
        return true;
    }
}

@end
