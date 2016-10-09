//
//  ZHCMessagesVoicePlayer.m
//  ZHChat
//
//  Created by aimoke on 15/7/2.
//  Copyright (c) 2015年 zhuo. All rights reserved.
//

#import "ZHCMessagesAudioPlayer.h"

@implementation ZHCMessagesAudioPlayer

#pragma mark － Lifecycle
+(instancetype)shareVoicePlayer
{
    static ZHCMessagesAudioPlayer *_AudioPlayer = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate,^{
        _AudioPlayer = [[ZHCMessagesAudioPlayer alloc]init];
    });
    return _AudioPlayer;
}



-(void)playAudioWithUrl:(NSURL *)url
{
    self.audioPlayer =  [[AVAudioPlayer alloc]initWithContentsOfURL:url error:nil];
    self.audioPlayer.delegate = self;
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    
}


@end
