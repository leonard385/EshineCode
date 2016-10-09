//
//  ZHCMessagesVoiceRecorder.h
//  ZHChat
//
//  Created by aimoke on 16/8/30.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <AudioToolbox/AudioToolbox.h>
#import <UIKit/UIKit.h>
#define SOUND_METER_COUNT       40
#define WAVE_UPDATE_FREQUENCY   0.05

@class ZHCMessagesVoiceRecorder;

@protocol ZHCMessagesVoiceDelegate <NSObject>

@optional

- (void)zhc_voiceRecorded:(NSString *)recordPath length:(float)recordLength;

- (void)zhc_failRecord;

@end


@interface ZHCMessagesVoiceRecorder : NSObject<AVAudioRecorderDelegate>{
    NSMutableDictionary *recordSetting;
    NSString *recorderFilePath;
    AVAudioRecorder *AudioRecorder;
    SystemSoundID soundID;
    float recordTime;
}
@property (nonatomic, assign) id<ZHCMessagesVoiceDelegate> delegate;


- (void)zhc_startRecording;

- (void)zhc_stopRecording;

- (void)zhc_cancelRecord;
@end
