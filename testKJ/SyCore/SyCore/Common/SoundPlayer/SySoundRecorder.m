//
//  XMPSoundRecorder.m
//  XmppDemo
//
//  Created by weitong on 13-2-15.
//  Copyright (c) 2013年 weit. All rights reserved.
//

#import "SySoundRecorder.h"
#import "SySoundPlayer.h"
#import "SyConstant.h"
#import "SyDateUtil.h"
#import "SyFileManager.h"


@interface SySoundRecorder()
{
    AVAudioSession*                                 _audioSession;
    
    AVAudioRecorder*                                _audioRecorder;
    
    //计时器
    NSTimer*                                        _levelTimer;
    //录音开始时间
    NSTimeInterval                                  _beginTime;
    //记录当前录音的状态，防止多次结束录音
    int                                             _soundUsedCount;
    
}
@property(nonatomic,strong) AVAudioSession*         audioSession;
@property(nonatomic,strong) AVAudioRecorder*        audioRecorder;


- (void)levelTimerCallback:(NSTimer *)timer;

@end

@implementation SySoundRecorder

@synthesize delegate                    = _delegate;
@synthesize isRunning                   = _isRunning;
@synthesize audioSession                = _audioSession;
@synthesize audioRecorder               = _audioRecorder;
@synthesize granted = _granted;


+ (SySoundRecorder *)sharedRecorder
{
    static dispatch_once_t pred = 0;
    __strong static id _sharedObject = nil;
    dispatch_once(&pred, ^{
        _sharedObject = [[self alloc] init];
    });
    return _sharedObject;
}

- (void)setup
{
    _isRunning = NO;
    _soundUsedCount = 0;
    [self createAudioSession];
}
- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)start{
    NSLog(@"start 录音");
    if (_isRunning) {
        NSLog(@"already running");
        return;
    }
    [[SySoundPlayer sharedPlayer] stop];
    _isRunning = YES;
    //创建一个零时文件
    NSString *recorderFilePath = [SyFileManager recordFilePathWithFileName:kSourceRecordFileName cleanFlag:YES];
    NSError* error = nil;
    NSMutableDictionary* recordSetting = [[NSMutableDictionary alloc] init];
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatLinearPCM] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:8000] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    [recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    [recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    //判断用户是否可以使用麦克风
    [self createAudioSession];
    
    [_audioSession setActive:YES error:nil];
    [_audioSession setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
    
    NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    error = nil;
    _audioRecorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&error];
    [_audioRecorder setDelegate:self];
    //音频统计记录
    [_audioRecorder prepareToRecord];
    //一个布尔值,指示是否启用
    _audioRecorder.meteringEnabled = YES;
    
    
    //启动或恢复
    [_audioRecorder record];
    
    _beginTime = [NSDate timeIntervalSinceReferenceDate];
    
    _levelTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target: self selector: @selector(levelTimerCallback:) userInfo: nil repeats: YES];
    
    
    _soundUsedCount = 0;
}
-(BOOL)isGranted{
    NSLog(@"%d",_granted);
    if(!IOS7){
        //非ios7设备没有该功能
        return  YES;
    }
    return _granted;
}
-(void)createAudioSession{
    //创建音频上下文
    if(!_audioSession){
        _audioSession = [AVAudioSession sharedInstance];
        [_audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
    }
    [_audioSession setActive:NO error:nil];
    if ([_audioSession respondsToSelector:@selector(requestRecordPermission:)]) {
        [_audioSession performSelector:@selector(requestRecordPermission:) withObject:^(BOOL granted) {
            if (granted) {
                // 允许使用麦克风
                self.granted = YES;
            }
            else {
                // 不允许使用麦克风
                self.granted = NO;
            }
        }];
    }
}
- (void)stop:(BOOL)isConvert
{
    NSLog(@"end 录音");
    _soundUsedCount ++;
    if (_soundUsedCount > 1) {
        NSLog(@"重复使用了");
        return;
    }
    [_levelTimer invalidate];
    _levelTimer=nil;
    
    double timeInterval = ([NSDate timeIntervalSinceReferenceDate] - _beginTime);
    if (timeInterval >= 1.0 && isConvert ) {
        // 音频长度符合要求，并且结束录音
        [self didCancelStop];
        NSString* cafFilePath = [SyFileManager recordFilePathWithFileName:kSourceRecordFileName cleanFlag:NO];
        
        NSString *amrFilePath;
        NSString *datePath = [[SyDateUtil strFromDate:[NSDate date] formatter:kDateFormate_YYYYMMDDHHMMSS] stringByAppendingString:@".amr"];
        if(_fistfilePath.length > 0){
            NSRange range = [_fistfilePath rangeOfString:@"/" options:NSBackwardsSearch];
            if(range.location > 0){
                NSString *directory = [_fistfilePath substringToIndex:range.location];
                amrFilePath = [[SyFileManager createFullPath:[NSString stringWithFormat:@"%@/%@",kFileTempPath,directory]] stringByAppendingString:[_fistfilePath substringFromIndex:range.location]];
                datePath = _fistfilePath;
            }
        }
        amrFilePath = [SyFileManager recordFilePathWithFileName:datePath cleanFlag:NO];
        
        @try {
            NSData* cafData = [NSData dataWithContentsOfFile:cafFilePath];
            NSData* amrData = EncodeWAVEToAMR(cafData,1,16);
            [amrData writeToFile:amrFilePath atomically:YES];
        }@catch (NSException *exception) {
            [NSException raise:@".." format:@".."];
        }@finally {
            
        }
        NSLog(@"record: amrFilePath:%@",datePath);
        if (_delegate && [_delegate respondsToSelector:@selector(soundRecorderDidFinished:formFilePath:filePath:)]) {
            [_delegate soundRecorderDidFinished:self formFilePath:amrFilePath filePath:datePath];
        }
    }else{
        if (isConvert && timeInterval < 1.2 && _delegate && [_delegate respondsToSelector:@selector(soundRecorderDidCancelAndTooShort:)]) {
            [NSTimer scheduledTimerWithTimeInterval:0.1 target: self selector: @selector(didCancelStop) userInfo: nil repeats: NO];
            //太短
            [_delegate soundRecorderDidCancelAndTooShort:self];
        }else if (_delegate && [_delegate respondsToSelector:@selector(soundRecorderDidCancel:)]) {
            [self didCancelStop];
            //主动取消
            [_delegate soundRecorderDidCancel:self];
        }
    }
}

-(void)didCancelStop{
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(concurrentQueue, ^{
        [_audioRecorder stop];
        _audioRecorder = nil;
        [_audioSession setActive:NO error:nil];
        [_audioSession setCategory:AVAudioSessionCategoryPlayback error:nil];
        _isRunning = NO;
    });
}

- (void)levelTimerCallback:(NSTimer *)timer{
    
    //当前录音时间
    double timeInterval = ([NSDate timeIntervalSinceReferenceDate] - _beginTime);
    //
    if (timeInterval > kVoice_TimeOut) {
        [self stop:YES];
        return;
    }
    [_audioRecorder updateMeters];
    //计算音量高低
    double volume = fabs([_audioRecorder averagePowerForChannel: 0] / -160);
    if (_delegate && [_delegate respondsToSelector:@selector(soundRecorderVolumeDidChanged:volume:second:)]) {
        [_delegate soundRecorderVolumeDidChanged:self volume:volume second:(NSInteger)timeInterval];
    }
}


@end
