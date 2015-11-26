//
//  UILabel+SyUILabel.m
//  SyCore
//
//  Created by 愤怒熊 on 14-7-19.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "UILabel+SyUILabel.h"

@implementation UILabel (SyUILabel)


/**
 *  设置行距
 *
 *  @param lineSpacing 行距距离
 */
-(void)setLineSpacing:(NSInteger )lineSpacing{
    if(self.text && self.text.length > 0){
        NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self.text];
        NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
        
        [paragraphStyle setLineSpacing:lineSpacing];//调整行间距
        
        [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, self.text.length)];
        self.attributedText = attributedString;
    }
    
}


@end
