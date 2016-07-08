//
//  timeDownView.h
//  请求验证码倒计时Label
//
//  Created by eshine_1233 on 16/7/8.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^handleBlock)() ;

@interface TimeDownView : UIView
//倒计时总时间
@property (nonatomic, assign) int timeCount;
//点击按钮处理回调
@property (nonatomic, copy) handleBlock handBlock;
@end
