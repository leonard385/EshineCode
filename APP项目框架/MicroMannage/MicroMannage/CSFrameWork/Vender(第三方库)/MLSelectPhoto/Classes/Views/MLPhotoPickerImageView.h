//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  PickerImageView.h
//
//  Created by 张磊 on 14-11-11.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MLPhotoPickerImageView : UIImageView

/**
 *  是否有蒙版层
 */
@property (nonatomic , assign , getter=isMaskViewFlag) BOOL maskViewFlag;
/**
 *  是否有右上角打钩的按钮
 */
@property (nonatomic , assign) BOOL animationRightTick;
/**
 *  是否视频类型
 */
@property (assign,nonatomic) BOOL isVideoType;

@end
