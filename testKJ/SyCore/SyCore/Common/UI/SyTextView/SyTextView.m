//
//  SyTextView.m
//  SyCore
//
//  Created by 愤怒熊 on 14-6-18.
//  Copyright (c) 2014年 menghua.wu. All rights reserved.
//
#define kTopContentInset -4
#define lBottonContentInset 12



#import "SyTextView.h"

@implementation SyTextView


- (void)setup{
    [super setup];
    
    if(!_textView){
        _textView = [[UITextView alloc] init];
        _textView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        _textView.userInteractionEnabled = YES;
        _textView.font = [UIFont systemFontOfSize:16.0f];
        _textView.textColor = [UIColor blackColor];
        _textView.backgroundColor = [UIColor clearColor];
        _textView.keyboardAppearance = UIKeyboardAppearanceDefault;
        _textView.keyboardType = UIKeyboardTypeDefault;
        _textView.returnKeyType = UIReturnKeySend;
        _textView.textAlignment = NSTextAlignmentLeft;
        _textView.delegate = self;
        [self addSubview:_textView];
        
    }
}

- (void)customLayoutSubviews{
    [super customLayoutSubviews];
    _textView.frame = CGRectMake(self.left, self.top + 2, self.width, self.height - 4);
    CGSize size = _textView.contentSize;
    if((size.height <= self.height -2 ) || [_textView.text isEqualToString:_placeHolder]){
        _textView.frame = CGRectMake(self.left, self.top + (self.height / 5 ), self.width, self.height - 4);
    }
}

- (void)setPlaceHolder:(NSString *)placeholders{
    _placeHolder = placeholders;
    _textView.text = placeholders;
    _textView.textColor = [UIColor lightGrayColor];
}

#pragma mark UITextView properties

-(void)setText:(NSString *)atext
{
	_textView.text = atext;
    [self textViewDidChange:_textView];
}

-(NSString*)text
{
	return _textView.text;
}

-(void)setFont:(UIFont *)afont
{
	_textView.font= afont;
}

-(UIFont *)font
{
	return _textView.font;
}

-(void)setTextColor:(UIColor *)color
{
	_textView.textColor = color;
}

-(UIColor*)textColor
{
	return _textView.textColor;
}

-(void)setTextAlignment:(NSTextAlignment)aligment
{
	_textView.textAlignment = aligment;
}

-(NSTextAlignment)textAlignment
{
	return _textView.textAlignment;
}

-(void)setTextVerticalAlignment:(NSTextVerticalAlignment)textVerticalAlignment
{
    
}


-(void)setSelectedRange:(NSRange)range
{
	_textView.selectedRange = range;
}

-(NSRange)selectedRange
{
	return _textView.selectedRange;
}

-(void)setEditable:(BOOL)beditable
{
	_textView.editable = beditable;
}

-(BOOL)isEditable
{
	return _textView.editable;
}

-(void)setDataDetectorTypes:(UIDataDetectorTypes)datadetector
{
	_textView.dataDetectorTypes = datadetector;
}

-(UIDataDetectorTypes)dataDetectorTypes
{
	return _textView.dataDetectorTypes;
}

-(void)setReturnKeyType:(UIReturnKeyType)keyType
{
	_textView.returnKeyType = keyType;
}

-(UIReturnKeyType)returnKeyType
{
	return _textView.returnKeyType;
}


- (BOOL)hasText
{
	return [_textView hasText];
}

- (void)scrollRangeToVisible:(NSRange)range
{
	[_textView scrollRangeToVisible:range];
}

-(void)clearText
{
    self.text = @"";
    [self textViewDidChange:_textView];
}

- (BOOL)canBecomeFirstResponder{
    return [_textView canBecomeFirstResponder];
}
- (BOOL)becomeFirstResponder{
    return [_textView becomeFirstResponder];
}

- (BOOL)canResignFirstResponder{
    return [_textView canResignFirstResponder];
}
- (BOOL)resignFirstResponder{
    return [_textView resignFirstResponder];
}


- (void)textViewDidChange:(SyTextView *)textView{
    NSLog(@"textViewDidChange");
    
    
}

#pragma mark -
#pragma mark UIExpandingTextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView{
    NSLog(@"textViewShouldBeginEditing");
    if([textView.text isEqualToString:_placeHolder]){
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    if( [self.textViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]){
        return [self.textViewDelegate textViewShouldBeginEditing:self];
    }
    return NO;
}
- (BOOL)textViewShouldEndEditing:(SyTextView *)textView{
    NSLog(@"textViewShouldEndEditing");
    if( [self.textViewDelegate respondsToSelector:@selector(textViewShouldBeginEditing:)]){
        return [self.textViewDelegate textViewShouldEndEditing:self];
    }
    return NO;
}

- (void)textViewDidBeginEditing:(SyTextView *)textView{
    NSLog(@"textViewDidBeginEditing");
    if([self.textViewDelegate respondsToSelector:@selector(textViewDidBeginEditing:)]){
        [self.textViewDelegate textViewDidBeginEditing:self];
    }
}
- (void)textViewDidEndEditing:(SyTextView *)textView{
    NSLog(@"textViewDidEndEditing");
    if(textView.text.length == 0){
        _textView.text = _placeHolder;
        _textView.textColor = [UIColor lightGrayColor];
        
        
    }
    
    
    NSLog(@"textViewDidEndEditing");
    if([self.textViewDelegate respondsToSelector:@selector(textViewDidEndEditing:)]){
        [self.textViewDelegate textViewDidEndEditing:self];
    }
}

- (BOOL)textView:(SyTextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    NSLog(@"shouldChangeTextInRange");
    
    if ([text isEqualToString:@"\n"]){
		return [self textViewShouldReturn:self];
	}
    if([self.textViewDelegate respondsToSelector:@selector(textView:shouldChangeTextInRange:replacementText:)]){
        return [self.textViewDelegate textView:self shouldChangeTextInRange:range replacementText:text];
    }
    return NO;
}

- (void)textView:(SyTextView *)textView willChangeHeight:(float)height{
    NSLog(@"willChangeHeight");
    if([self.textViewDelegate respondsToSelector:@selector(textView:willChangeHeight:)]){
        [self.textViewDelegate textView:self willChangeHeight:height];
    }
}
- (void)textView:(SyTextView *)textView didChangeHeight:(float)height{
    NSLog(@"didChangeHeight");
    if([self.textViewDelegate respondsToSelector:@selector(textView:didChangeHeight:)]){
        [self.textViewDelegate textView:self didChangeHeight:height];
    }
}

- (void)textViewDidChangeSelection:(SyTextView *)textView{
    NSLog(@"textViewDidChangeSelection");
    [self customLayoutSubviews];
    if([self.textViewDelegate respondsToSelector:@selector(textViewDidChangeSelection:)]){
        [self.textViewDelegate textViewDidChangeSelection:self];
    }
}
- (BOOL)textViewShouldReturn:(SyTextView *)textView{
    NSLog(@"textViewShouldReturn");
    if( [self.textViewDelegate respondsToSelector:@selector(textViewShouldReturn:)]){
        return [self.textViewDelegate textViewShouldReturn:self];
    }
    return NO;
}


@end
