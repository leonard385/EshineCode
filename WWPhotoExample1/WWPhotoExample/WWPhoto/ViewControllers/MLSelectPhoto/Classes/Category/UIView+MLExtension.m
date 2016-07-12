//  github: https://github.com/MakeZL/MLSelectPhoto
//  author: @email <120886865@qq.com>
//
//  UIView+Extension.m
//
//  Created by 张磊 on 14-11-14.
//  Copyright (c) 2014年 com.zixue101.www. All rights reserved.
//

#import "UIView+MLExtension.h"
#import "MLSelectPhotoCommon.h"

@implementation UIView (Extension)

- (void)setMl_x:(CGFloat)x{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}
- (CGFloat)ml_x{
    return self.frame.origin.x;
}
- (void)setMl_y:(CGFloat)y{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}
- (CGFloat)ml_y{
    return self.frame.origin.y;
}
- (void)setMl_centerX:(CGFloat)centerX{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
- (CGFloat)ml_centerX{
    return self.center.x;
}

- (void)setMl_centerY:(CGFloat)centerY{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
- (CGFloat)ml_centerY{
    return self.center.y;
}

- (void)setMl_width:(CGFloat)width{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}
- (CGFloat)ml_width{
    return self.frame.size.width;
}

- (void)setMl_height:(CGFloat)height{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}
- (CGFloat)ml_height{
    return self.frame.size.height;
}


- (void)setMl_size:(CGSize)size{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)ml_size{
    return self.frame.size;
}

- (void)showMessageWithText:(NSString *)text{
    UILabel *alertLabel = [[UILabel alloc] init];
    alertLabel.font = [UIFont systemFontOfSize:15];
    alertLabel.text = text;
    alertLabel.textAlignment = NSTextAlignmentCenter;
    alertLabel.layer.masksToBounds = YES;
    alertLabel.textColor = [UIColor whiteColor];
    alertLabel.frame = CGRectMake(0, 0, 100, 80);
    [alertLabel sizeToFit];
    alertLabel.ml_width += 50;
    alertLabel.ml_height = 80;
    alertLabel.ml_x = (self.ml_width - alertLabel.ml_width) * 0.5;
    alertLabel.ml_y = (self.ml_height - alertLabel.ml_height) * 0.5;
    alertLabel.backgroundColor = [UIColor colorWithRed:25/255.0 green:25/255.0 blue:25/255.0 alpha:1.0];
    alertLabel.layer.cornerRadius = 10.0f;
    [[UIApplication sharedApplication].keyWindow addSubview:alertLabel];

    [UIView animateWithDuration:KHUDShowDuration animations:^{
        alertLabel.alpha = 0.0;
    } completion:^(BOOL finished) {
        [alertLabel removeFromSuperview];
    }];
}

@end
