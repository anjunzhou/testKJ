//
//  XMPSoundPlayer.h
//  XmppDemo
//
//  Created by weitong on 13-2-19.
//  Copyright (c) 2013年 weit. All rights reserved.

//  播放语音

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>

@interface SySoundPlayer : NSObject{

    NSString                                        *_playerPath;
}

+ (SySoundPlayer *)sharedPlayer;

@property (nonatomic,strong) AVAudioPlayer          *player;


@property (nonatomic,strong) NSString               *playerPath;


- (void)playWithPath:(NSString *)path;

- (void)stop;

- (void)soundModeChanged:(NSInteger)soundMode;

@end
