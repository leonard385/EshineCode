//
//  YHUtil.m
//  DevicePermission
//
//  Created by Jyh on 15/8/24.
//  Copyright (c) 2015年 iyhjiang.com. All rights reserved.
//

#import "YHUtil.h"
#import <AVFoundation/AVFoundation.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <CoreLocation/CoreLocation.h>

@implementation YHUtil

+ (BOOL)isAllowCamera
{
    NSString *mediaType = AVMediaTypeVideo;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:mediaType];
    if(authStatus == AVAuthorizationStatusRestricted || authStatus == AVAuthorizationStatusDenied){
        NSLog(@"相机权限受限");
        return NO;
    } else {
        return YES;
    }
    
    return NO;
}

+ (BOOL)isAllowPhotoAlbum
{
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusRestricted || author ==ALAuthorizationStatusDenied){
        //无权限
        return NO;
    }
    return YES;
}

+ (BOOL)isAllowDeviceMicophone
{
    __block BOOL isAllow = YES;
    if([[AVAudioSession sharedInstance] respondsToSelector:@selector(requestRecordPermission:)]){
        [[AVAudioSession sharedInstance] requestRecordPermission:^(BOOL granted) {
            if(granted) {
                //用户同意
                isAllow = YES;

            }else{
                //用户不同意
                isAllow = NO;
            }
        }];
    }
    
    return isAllow;
}

+ (BOOL)isSilenced
{
    return NO;
}

+ (BOOL)isAllowLocaiton
{
    return [CLLocationManager locationServicesEnabled];
}

@end
