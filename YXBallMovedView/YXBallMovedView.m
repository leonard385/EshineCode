//
//  BallMovedView.m
//  ballMoved
//
//  Created by qianqian on 16/7/11.
//  Copyright © 2016年 qianqian. All rights reserved.
//

#import "YXBallMovedView.h"

@interface YXBallMovedView()
{
    NSTimer *timer;
    NSTimer *timerUpdateBallFrame;
    UIView *view;
    NSInteger deltaTime;
    
    ViewVerticalMoveType viewVerticalMoveType;
    ViewHorizontalMoveType viewHorizontalMoveType;

}
@end


@implementation YXBallMovedView

- (instancetype)initWithFrame:(CGRect)frame
{
   self = [super initWithFrame:frame];
    
    if (self) {
        
        CGRect rect = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        self.frame = rect;
        self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
        [self initialBall];
        [self initialTimer];
        
    }

    return self;
}

+ (instancetype)ballMovedView
{
    
    YXBallMovedView *ballMovedView = [[YXBallMovedView alloc] init];
    return ballMovedView;
    
}

- (void)setBallBgViewRect:(CGRect)ballBgViewRect
{
    if (ballBgViewRect.size.width != 0) {
        
          self.frame = ballBgViewRect;
        
    }
    
}

- (void)setImage:(UIImage *)image
{
    if (_ivBall) {
        
        _ivBall.image = image;
        
    }
    
}

#pragma ---------------------小球初始化---------------------------
- (void)initialBall
{
    CGFloat viewX = arc4random_uniform(100);
    CGFloat viewY = arc4random_uniform(300);
    
    view = [[UIView alloc] initWithFrame:CGRectMake(viewX, viewY, 100, 60)];
    [self addSubview:view];
    
    _ivBall = [[UIImageView alloc] initWithImage:_image?_image:[UIImage imageNamed:@"ball"]];
    _ivBall.frame = CGRectMake(30, 0, 40, 40);
    _ivBall.layer.cornerRadius = 20;
    _ivBall.layer.masksToBounds = YES;
    [view addSubview:_ivBall];
    
    _lbBallTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 40, 100, 20)];
    _lbBallTime.text = @"计时";
    _lbBallTime.textAlignment = NSTextAlignmentCenter;
    [view addSubview:_lbBallTime];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(ballOnClicked)];
    [view addGestureRecognizer:tapGestureRecognizer];
    
}

#pragma ---------------------初始化计时器--------------------------
- (void)initialTimer
{
    deltaTime = 0;
    timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(calculateTimer) userInfo:nil repeats:YES];
     [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    [timer fire];
    
    timerUpdateBallFrame = [NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(YXUpdateMove) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timerUpdateBallFrame forMode:NSRunLoopCommonModes];
    [timerUpdateBallFrame fire];

}

- (void)calculateTimer
{   
    deltaTime++;
    NSInteger hours   = deltaTime / 3600;
    NSInteger minutes = (deltaTime%3600) / 60;
    NSInteger seconds = deltaTime%60;
    
    NSString *hoursStr   = [NSString stringWithFormat:@"%.2ld",hours];
    NSString *minutesStr = [NSString stringWithFormat:@"%.2ld",minutes];
    NSString *secondsStr = [NSString stringWithFormat:@"%.2ld",seconds];
    
    NSString *timeStr;//获取时间字符串
    if (hours == 0) {
        timeStr = [NSString stringWithFormat:@"%@:%@", minutesStr, secondsStr];
    } else {
        timeStr = [NSString stringWithFormat:@"%@:%@:%@", hoursStr, minutesStr, secondsStr];
    }
    self.lbBallTime.text = [NSString stringWithFormat:@"%@",timeStr];

}

//判断小球在界面的边缘类型
- (void)YXJudgeGcvEdge
{

    CGRect viewRect = view.frame;
    if (viewRect.origin.x == -30)
    {
        viewHorizontalMoveType = viewHorizontalMoveTypeRight;
    }
    
    else if (viewRect.origin.x == (self.frame.size.width - viewRect.size.width + 30))
    {
        viewHorizontalMoveType = viewHorizontalMoveTypeLeft;
    }
    else{}
    
    if (viewRect.origin.y == 0)
    {
        viewVerticalMoveType = viewVerticalMoveTypeBottom;
        
    }
    else if(viewRect.origin.y == self.frame.size.height - viewRect.size.height)
    {
        viewVerticalMoveType = viewVerticalMoveTypeTop;
    }
    else{}
    
}
//小球移动
- (void)YXUpdateMove
{
    NSLog(@"sasd");
    //获取金币视图的位置和大小
    [self YXJudgeGcvEdge];
    CGRect viewRect = view.frame;
    if ((viewRect.origin.x >= -30)
        && (viewRect.origin.x <= (self.frame.size.width - viewRect.size.width + 30)))
    {
        if (viewHorizontalMoveType == viewHorizontalMoveTypeRight) {
            viewRect.origin.x = viewRect.origin.x + 1;
        }
        if (viewHorizontalMoveType == viewHorizontalMoveTypeLeft) {
            viewRect.origin.x = viewRect.origin.x - 1;
        }
    }
    
    if ((viewRect.origin.y >= 0)
        && (viewRect.origin.y) <= (self.frame.size.height - viewRect.size.height))
    {
        if (viewVerticalMoveType == viewVerticalMoveTypeTop){
            viewRect.origin.y = viewRect.origin.y - 1;
        }
        if (viewVerticalMoveType == viewVerticalMoveTypeBottom) {
            viewRect.origin.y = viewRect.origin.y + 1;
        }
        
    }
    view.frame = viewRect;
    
}

#pragma -------------点击小球代理方法激发---------------------------
- (void)ballOnClicked
{

    if (_delegate && [_delegate respondsToSelector:@selector(YXBallMovedClick:withDeltaTime:)]) {
        
        [_delegate YXBallMovedClick:self withDeltaTime:deltaTime];
        
    }
    
    [view removeFromSuperview];
    [self removeFromSuperview];

    //停止计时
    [timer invalidate];
    timer = nil;
    [timerUpdateBallFrame invalidate];
    timerUpdateBallFrame = nil;

}

- (void)dealloc
{
   

}
@end
