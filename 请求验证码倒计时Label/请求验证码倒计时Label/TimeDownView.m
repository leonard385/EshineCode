//
//  timeDownView.m
//  请求验证码倒计时Label
//
//  Created by eshine_1233 on 16/7/8.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "timeDownView.h"
#import "QosTimer.h"

@interface TimeDownView ()
@property (nonatomic, strong) UIButton *btn;
@property (nonatomic, strong) UILabel *label;
@end

@implementation TimeDownView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setupView];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

//创建btn  和label
- (void)setupView
{
    //创建btn
    UIButton *btn = [[UIButton alloc]initWithFrame:self.bounds];
    self.btn = btn;
    btn.backgroundColor = [UIColor redColor];
    [btn setTitle:@"获取验证码" forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    //创建label
    UILabel *label = [[UILabel alloc]initWithFrame:self.bounds];
    [label setBackgroundColor:[UIColor redColor]];
    //label.font = [UIFont systemFontOfSize:10];
    label.adjustsFontSizeToFitWidth = YES;
    [label setTextColor:[UIColor blueColor]];
    
    self.label = label;
    [self addSubview:label];
    [self addSubview:btn];
}


- (void)btnClick:(UIButton *)btn
{
    NSLog(@"单击按钮");
    self.handBlock();
    
    [QosTimer TimeCountDown:self.timeCount handleDis:^(NSString *str) {
        self.label.hidden = NO;
        self.btn.hidden = YES;
        self.label.text = str;
    } complete:^{
        self.btn.hidden = NO;
        self.label.hidden = YES;
    }];
    
}


@end
