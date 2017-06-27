//
//  DrawView.m
//  PopView
//
//  Created by 123 on 16/5/4.
//  Copyright © 2016年 asura. All rights reserved.
//

#import "DrawView.h"

//标示数
static int stage = 0;

@interface DrawView ()

//定时器
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation DrawView

#pragma mark - init
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
    
}

#pragma mark - animation
-(void) startAnimating
{
    if (!self.timer.isValid) {
        //时时刷新界面
        self.timer =[NSTimer timerWithTimeInterval:0.1 target:self selector:@selector(setNeedsDisplay) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    
    self.hidden = NO;
    stage++;
}
-(void) stopAnimating
{
    self.hidden = YES;
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - confgure
//获取颜色
-(UIColor *) getColorForStage:(int) currentStage WithAlpha:(double) alpha
{
    int max = 20;
    int cycle = currentStage % max;
    
    if (cycle < max/4) {
        return [UIColor colorWithRed:232.0/255.0 green:131.0/255.0 blue:37.0/255.0 alpha:alpha];
    } else if (cycle < max/4*2) {
        return [UIColor colorWithRed:90.0/255.0 green:91.0/255.0 blue:83.0/255.0 alpha:alpha];
    } else if (cycle < max/4*3) {
        return [UIColor colorWithRed:33.0/255.0 green:31.0/255.0 blue:31.0/255.0 alpha:alpha];
        
    } else  {
        return [UIColor colorWithRed:19.0/255.0 green:109.0/255.0 blue:198.0/255.0 alpha:alpha];
    }
    
}
//计算线条的终点
-(CGPoint) pointOnInnerCirecleWithAngel:(int) angel
{
    double r = self.frame.size.height/2/2;
    double cx = self.frame.size.width/2;
    double cy = self.frame.size.height/2;
    double x = cx + r*cos(M_PI/10*angel);
    double y = cy + r*sin(M_PI/10*angel);
    return CGPointMake(x, y);
}
//计算线段的起点
-(CGPoint) pointOnOuterCirecleWithAngel:(int) angel
{
    double r = self.frame.size.height/2;
    double cx = self.frame.size.width/2;
    double cy = self.frame.size.height/2;
    double x = cx + r*cos(M_PI/10*angel);
    double y = cy + r*sin(M_PI/10*angel);
    return CGPointMake(x, y);
}
#pragma mark - drawRect
-(void) drawRect:(CGRect)rect
{
    CGPoint point;
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(ctx, 2.0);
    
    for (int i = 1 ; i<=10; ++i) {
        
        CGContextSetStrokeColorWithColor(ctx, [[self getColorForStage:stage+i WithAlpha:0.1 *i] CGColor]);
        point = [self pointOnOuterCirecleWithAngel:stage+i];
        CGContextMoveToPoint(ctx, point.x, point.y);
        point = [self pointOnInnerCirecleWithAngel:stage+i];
        CGContextAddLineToPoint( ctx, point.x, point.y);
        CGContextStrokePath(ctx);
    }
    stage++;
}

@end
