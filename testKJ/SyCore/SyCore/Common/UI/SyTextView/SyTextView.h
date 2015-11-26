//
//  SyTextView.h
//  SyCore
//
//  Created by 愤怒熊 on 14-6-18.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//


typedef enum
{
    VerticalAlignmentTop = 0, // default
    VerticalAlignmentMiddle,
    VerticalAlignmentBottom,
} NSTextVerticalAlignment;

#import "SyBaseView.h"

@protocol SyTextViewDelegate;
@interface SyTextView : SyBaseView<UITextViewDelegate>{

    NSString                                             *_placeHolder;
    UITextView                                           *_textView;
    NSTextVerticalAlignment                              _textVerticalAlignment;


}
@property (nonatomic ,assign) id<SyTextViewDelegate>     textViewDelegate;
@property (nonatomic,retain ) UITextView                 *textView;

//提示用户输入的标语
@property (nonatomic,strong ) NSString                   *placeHolder;

@property (nonatomic,copy) NSString *text;
@property (nonatomic,retain) UIFont *font;
@property (nonatomic,retain) UIColor *textColor;
@property (nonatomic,assign) NSTextAlignment textAlignment;
@property (nonatomic,assign) NSTextVerticalAlignment textVerticalAlignment;
@property (nonatomic) NSRange selectedRange;
@property (nonatomic,getter=isEditable) BOOL editable;
@property (nonatomic) UIDataDetectorTypes dataDetectorTypes __OSX_AVAILABLE_STARTING(__MAC_NA, __IPHONE_3_0);
@property (nonatomic) UIReturnKeyType returnKeyType;
//隐藏
//@property (nonatomic, retain) UIImageView *textViewBackgroundImage;
- (BOOL)hasText;
- (void)scrollRangeToVisible:(NSRange)range;
- (void)clearText;

//键盘操作
- (BOOL)canBecomeFirstResponder;    // default is NO
- (BOOL)becomeFirstResponder;

- (BOOL)canResignFirstResponder;    // default is YES
- (BOOL)resignFirstResponder;



@end



@protocol SyTextViewDelegate <NSObject>

- (BOOL)textViewShouldBeginEditing:(SyTextView *)textView;
- (BOOL)textViewShouldEndEditing:(SyTextView *)textView;

- (void)textViewDidBeginEditing:(SyTextView *)textView;
- (void)textViewDidEndEditing:(SyTextView *)textView;

- (BOOL)textView:(SyTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
- (void)textViewDidChange:(SyTextView *)textView;

- (void)textView:(SyTextView *)textView willChangeHeight:(float)height;
- (void)textView:(SyTextView *)textView didChangeHeight:(float)height;

- (void)textViewDidChangeSelection:(SyTextView *)textView;
- (BOOL)textViewShouldReturn:(SyTextView *)textView;
@end

