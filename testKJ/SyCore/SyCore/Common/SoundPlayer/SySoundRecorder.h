//
//  XMPSoundRecorder.h
//  XmppDemo
//
//  Created by weitong on 13-2-15.
//  Copyright (c) 2013年 weit. All rights reserved.

//  录制语音

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "amrFileCodec.h"

@protocol SySoundRecorderDelegate;

@interface SySoundRecorder : NSObject<AVAudioRecorderDelegate,AVAudioSessionDelegate,AVAudioPlayerDelegate>{


    BOOL                            _granted;

    NSString                        *_defaultFilePath;

    NSString *_fistfilePath;

}
//判断是否允许录音
@property (nonatomic,assign) BOOL                    granted;
//判断是否正在录音
@property (nonatomic,assign) BOOL                    isRunning;
//录音转后，默认的路径
@property (nonatomic,strong) NSString                *defaultFilePath;

@property (nonatomic,assign) id <                               SySoundRecorderDelegate> delegate;

+ (SySoundRecorder *)sharedRecorder;

//开始
- (void)start;

//暂停，是否生成录音文件
- (void)stop:(BOOL)isConvert;

//判断是否允许录音
-(BOOL)isGranted;

//生成文件前面加的默认文件夹路径
@property (nonatomic,strong) NSString                *fistfilePath;

@end



@protocol SySoundRecorderDelegate <NSObject>

@optional
//录音成功返回
- (void)soundRecorderDidFinished:(SySoundRecorder *)recorder formFilePath:(NSString *)formFilePath filePath:(NSString *)filePath;
//用户主动取消录音
- (void)soundRecorderDidCancel:(SySoundRecorder *)recorder;
//录音太短
- (void)soundRecorderDidCancelAndTooShort:(SySoundRecorder *)recorder;
//录音过程中返回的数据
- (void)soundRecorderVolumeDidChanged:(SySoundRecorder *)recorder volume:(float)volume second:(NSInteger)second;

@end