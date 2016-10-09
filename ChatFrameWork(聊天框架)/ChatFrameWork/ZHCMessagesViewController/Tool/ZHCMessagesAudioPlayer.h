//
//  ZHCMessagesVoicePlayer.h
//  ZHChat
//
//  Created by aimoke on 15/7/2.
//  Copyright (c) 2015年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
@interface ZHCMessagesAudioPlayer : NSObject<AVAudioSessionDelegate,AVAudioPlayerDelegate>
@property(strong, nonatomic) AVAudioPlayer* audioPlayer;
@property(strong, nonatomic) NSString *voiceURL;

+(instancetype)shareVoicePlayer;
-(void)playAudioWithUrl:(NSURL *)url;



@end
