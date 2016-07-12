//
//  YHUtil.h
//  DevicePermission
//
//  Created by Jyh on 15/8/24.
//  Copyright (c) 2015年 iyhjiang.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YHUtil : NSObject

/**
 *  检测是否允许访问相机
 *
 *  @return
 */
+ (BOOL)isAllowCamera;

/**
 *  检测是否允许访问手机相册
 *
 *  @return
 */
+ (BOOL)isAllowPhotoAlbum;

/**
 *  检测是否允许访问麦克风
 *
 *  @return
 */
+ (BOOL)isAllowDeviceMicophone;

/**
 *  检测设备是否处于静音模式
 *
 *  @return
 */
+ (BOOL)isSilenced;

/**
 *  检测是否允许使用定位服务
 *
 *  @return
 */
+ (BOOL)isAllowLocaiton;

@end
