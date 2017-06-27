//
//  UIButton+BBTButton.h
//  bangbangtang
//
//  Created by guoyun3 on 16/5/9.
//  Copyright © 2016年 guoyun3. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, UKButtonEdgeInsetsStyle) {
    UKButtonEdgeInsetsStyleTop = 0, // image在上，label在下
    UKButtonEdgeInsetsStyleLeft = 1 << 1, // image在左，label在右
    UKButtonEdgeInsetsStyleBottom = 1 << 2, // image在下，label在上
    UKButtonEdgeInsetsStyleRight = 1 << 3 // image在右，label在左
};

@interface UIButton(BBTButton)

/**
 *  设置button的titleLabel和imageView的布局样式，及间距
 *
 *  @param style titleLabel和imageView的布局样式
 *  @param space titleLabel和imageView的间距
 */
- (void)layoutButtonWithEdgeInsetsStyle:(UKButtonEdgeInsetsStyle)style imageTitleSpace:(CGFloat)space;

//倒计时
- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;
@end
