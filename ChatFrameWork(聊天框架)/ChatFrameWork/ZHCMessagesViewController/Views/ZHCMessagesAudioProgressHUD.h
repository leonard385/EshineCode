//
//  ZHCMessagesAudioProgressHUD.h
//  ZHChat
//
//  Created by aimoke on 16/8/30.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, ZHCAudioProgressState){
    ZHCAudioProgressSuccess /**<Success */,
    ZHCAudioProgressError /**< Fail,Error */,
    ZHCAudioProgressShort /**< Time is too short */,
    ZHCAudioProgressMessage /**< Custom Message fail*/,
};

@interface ZHCMessagesAudioProgressHUD : UIView




/**
 *  Show the HUD.
 */
+(void)zhc_show;

/**
 *  Dissmiss the HUD With Specified Message.
 *
 *  @param message the message.
 */
+(void)zhc_dismissWithMessage:(NSString *)message;

/**
 *  Dismiss the HUD Wiht Custom state.
 *
 *  @param progressState see 'ZHCAudioProgressState'
 */
+ (void)zhc_dismissWithProgressState:(ZHCAudioProgressState)progressState;

/**
 *  Change HUD SubTitle。
 *
 *  @param str The Title.
 */
+ (void)zhc_changeSubTitle:(NSString *)str;

@end
