//
//  UILabel+SyLabel.m
//  SyCore
//
//  Created by 愤怒熊 on 14-5-30.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//

#import "UILabel+SyLabel.h"
#import "SyConstant.h"


@implementation UILabel (SyLabel)

-(CGSize)sizeWidth{
    return [self sizeWidthFont:self.font];
}
-(CGSize)sizeWidthFont:(UIFont *)font{
    
    CGSize size;
    if(IOS7){
        NSDictionary *attribute = @{NSFontAttributeName:font};
        size = [self.text boundingRectWithSize:CGSizeMake(0, self.frame.size.height) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
    }else{
        size = [self.text sizeWithFont:font constrainedToSize:CGSizeMake(MAXFLOAT, self.frame.size.height)];
    }
    return size;
}




-(CGSize)sizeHeight{
    return [self sizeHeightFont:self.font];
}
-(CGSize)sizeHeightFont:(UIFont *)font{
    CGSize size;
    if(IOS7){
        NSDictionary *attribute = @{NSFontAttributeName:font};
        size = [self.text boundingRectWithSize:CGSizeMake(self.frame.size.width, 0) options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
        
    }else{
        size = [self.text sizeWithFont:font constrainedToSize:CGSizeMake(self.frame.size.width, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    }
    return size;
}

-(void)lastCharacter{

}
-(void)lastCharacter:(UIFont *)font{

}



@end
