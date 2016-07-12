//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  UIView+Extension.h
//
//  Created by 张磊 on 14-11-14.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface UIView (Extension)

@property (nonatomic,assign) CGFloat ml_x;
@property (nonatomic,assign) CGFloat ml_y;
@property (nonatomic,assign) CGFloat ml_centerX;
@property (nonatomic,assign) CGFloat ml_centerY;
@property (nonatomic,assign) CGFloat ml_width;
@property (nonatomic,assign) CGFloat ml_height;
@property (nonatomic,assign) CGSize ml_size;

- (void)showMessageWithText:(NSString *)text;
@end
