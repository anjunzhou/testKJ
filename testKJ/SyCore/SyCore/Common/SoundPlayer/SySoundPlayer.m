//
//  XMPSoundPlayer.m
//  XmppDemo
//
//  Created by weitong on 13-2-19.
//  Copyright (c) 2013年 weit. All rights reserved.
//

#import "SySoundPlayer.h"
#import "amrFileCodec.h"
#import "SyConstant.h"
#import <UIKit/UIKit.h>
#import "NSString+SyString.h"

@interface SySoundPlayer()<AVAudioPlayerDelegate>
{
    AVAudioPlayer*                              _player;
    NSString*                                   _currentMicrotalkId;
    NSTimeInterval                              _currentTimeInterval;
    
    float                                      _playerDuration;
    NSTimer                                     *_soundTimer;
}

@property(nonatomic,strong) NSString*           currentMicrotalkId;
@property(nonatomic,assign) NSTimeInterval      currentTimeInterval;

@end



@implementation SySoundPlayer

@synthesize player                              = _player;
@synthesize currentMicrotalkId          = _currentMicrotalkId;
@synthesize currentTimeInterval         = _currentTimeInterval;

+ (SySoundPlayer *)sharedPlayer
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (id)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(sensorStateChange:)
                                                     name:@"UIDeviceProximityStateDidChangeNotification"
                                                   object:nil];
        
        self.currentMicrotalkId = @"";
        self.currentTimeInterval = 0;
    }
    return self;
}


- (void)playWithPath:(NSString *)path{
    
    _playerPath =  path;
    
    NSLog(@"%d", [_player isPlaying]);
    if (_player && _player.isPlaying && [path isEqualToString:_currentMicrotalkId]) {
        _currentTimeInterval = _player.currentTime;
        [_player pause];
        return;
    }else{
        [[UIDevice currentDevice] setProximityMonitoringEnabled:YES];
        
        AVAudioSession *audioSession = [AVAudioSession sharedInstance];
        // 默认情况下扬声器播放
        NSInteger soundMode = [[NSUserDefaults standardUserDefaults] integerForKey:kSoundModel];
        if (soundMode == XMPSoundModeDefault) {
            [audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        }else{
            [audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
        }
        [audioSession setActive:YES error:nil];
        NSError *error = nil;
        
        if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
            if (![[NSFileManager defaultManager] fileExistsAtPath:[path replaceCharacter:@"amr" withString:@"wav"]]) {
                NSData *amrToWav  = [NSData dataWithContentsOfFile:path];
                NSData *wavData = DecodeAMRToWAVE(amrToWav);
                path = [path replaceCharacter:@"amr" withString:@"wav"];
                [wavData writeToFile:path atomically:YES];
            }else{
               path = [path replaceCharacter:@"amr" withString:@"wav"]; 
            }
        }
        
        _player = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:path] error:&error];
        [_player setDelegate:self];
        //完整的播放数量
        [_player setVolume:1.0];
        //其实播放时间
        [_player setCurrentTime:0];
        //是否允许计数
        [_player setMeteringEnabled:YES];
        //刷新声音峰值
        [ _player updateMeters];
        if ([_player prepareToPlay]) {
            if(_soundTimer == nil){
                _soundTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self
                                                             selector:@selector(playProgress)
                                                             userInfo:nil repeats:YES];
            }
            [_player play];
        }
        NSLog(@"___%d", [_player isPlaying]);
    }
    
}

//播放进度条
- (void)playProgress
{
    //通过音频播放时长的百分比,给progressview进行赋值;
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%f",_player.currentTime],@"currentTime", [NSString stringWithFormat:@"%f",_player.volume],@"volume",nil];
    
}
- (void)stop
{
    if (_player) {
        if(_soundTimer != nil){
            [_soundTimer invalidate];
            _soundTimer = nil;
        }
        [_player stop];
    }
}

//处理监听触发事件
-(void)sensorStateChange:(NSNotificationCenter *)notification;
{
    //如果此时手机靠近面部放在耳朵旁，那么声音将通过听筒输出，并将屏幕变暗（省电啊）
    if ([[UIDevice currentDevice] proximityState]){
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }else{
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}

- (void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag
{
    NSLog(@"audioPlayerDidFinishPlaying");
    //    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    //    [audioSession setActive:NO error:nil];
    //    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
    
    _currentMicrotalkId = @"";
    _currentTimeInterval = 0;
    
    if(_soundTimer != nil){
        [_soundTimer invalidate];
        _soundTimer = nil;
        [[NSNotificationCenter defaultCenter] postNotificationName:@"voiceButtonNotification" object:nil];
    }
}

/* if an error occurs while decoding it will be reported to the delegate. */
- (void)audioPlayerDecodeErrorDidOccur:(AVAudioPlayer *)player error:(NSError *)error
{
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    [audioSession setActive:NO error:nil];
    [[UIDevice currentDevice] setProximityMonitoringEnabled:NO];
}


- (void)soundModeChanged:(NSInteger)soundMode
{
    if (soundMode == XMPSoundModeDefault) {
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    }else{
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
}


@end
