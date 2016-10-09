//
//  ZHCMessagesVoiceRecorder.m
//  ZHChat
//
//  Created by aimoke on 16/8/30.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessagesVoiceRecorder.h"
@interface ZHCMessagesVoiceRecorder()

@end
@implementation ZHCMessagesVoiceRecorder

#pragma mark - life cycle
-(instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

#pragma mark - PrivateMethods
-(NSString *)getTempVoicePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *voiceFile = [documentsDirectory stringByAppendingPathComponent:@"zhcmessagestemp.caf"];
    
    return voiceFile;
    
}


#pragma mark - Public Methods
- (void)zhc_startRecording {
     NSString *filePath = [self getTempVoicePath];
    recordTime = 0;
    AVAudioSession *audioSession = [AVAudioSession sharedInstance];
    BOOL audioHWAvailable = audioSession.inputAvailable;
    if (! audioHWAvailable) {
        UIAlertView *cantRecordAlert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
                                   message: @"Audio input hardware not available"
                                  delegate: nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [cantRecordAlert show];
        return;
    }
    NSError *err = nil;
    [audioSession setCategory :AVAudioSessionCategoryPlayAndRecord error:&err];
    if(err){
        NSLog(@"audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        return;
    }
    [audioSession setActive:YES error:&err];
    err = nil;
    if(err){
        NSLog(@"audioSession: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        return;
    }
    
    recordSetting = [[NSMutableDictionary alloc] init];
    
    // You can change the settings for the voice quality
    [recordSetting setValue :[NSNumber numberWithInt:kAudioFormatAppleIMA4] forKey:AVFormatIDKey];
    [recordSetting setValue:[NSNumber numberWithFloat:16000.0] forKey:AVSampleRateKey];
    [recordSetting setValue:[NSNumber numberWithInt: 1] forKey:AVNumberOfChannelsKey];
    
    // if you are using kAudioFormatLinearPCM format, activate these settings
    //[recordSetting setValue :[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //[recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsBigEndianKey];
    //[recordSetting setValue :[NSNumber numberWithBool:NO] forKey:AVLinearPCMIsFloatKey];
    
    NSLog(@"Recording at: %@", filePath);
    recorderFilePath = filePath;
    
    NSURL *url = [NSURL fileURLWithPath:recorderFilePath];
    
    err = nil;
    
    NSData *audioData = [NSData dataWithContentsOfFile:[url path] options: 0 error:&err];
    if(audioData)
    {
        NSFileManager *fm = [NSFileManager defaultManager];
        [fm removeItemAtPath:[url path] error:&err];
    }
    
    err = nil;
    AudioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&err];
    if(!AudioRecorder){
        NSLog(@"recorder: %@ %ld %@", [err domain], (long)[err code], [[err userInfo] description]);
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle: @"Warning"
                                   message: [err localizedDescription]
                                  delegate: nil
                         cancelButtonTitle:@"OK"
                         otherButtonTitles:nil];
        [alert show];
        return;
    }
    
    [AudioRecorder setDelegate:self];
    [AudioRecorder recordForDuration:(NSTimeInterval) 60];
    [AudioRecorder prepareToRecord];
    [AudioRecorder record];
    
}

- (void)zhc_stopRecording {
    recordTime = AudioRecorder.currentTime;
    if (AudioRecorder.isRecording) {
        [AudioRecorder stop];
    }
    if (recordTime > 1 ) {
        if ([self.delegate respondsToSelector:@selector(zhc_voiceRecorded:length:)]) {
            [self.delegate zhc_voiceRecorded:recorderFilePath length:recordTime];
        }
    }else{
        [AudioRecorder deleteRecording];
        if ([self.delegate respondsToSelector:@selector(zhc_failRecord)]) {
            [self.delegate zhc_failRecord];
        }
    }

}

-(void)zhc_cancelRecord
{
   
    [AudioRecorder stop];
    [AudioRecorder deleteRecording];
}



@end
