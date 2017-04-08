//
//  AYBubbleView.m
//  AYBubbleView
//
//  Created by Andy on 16/4/2.
//  Copyright © 2016年 AYJk. All rights reserved.
//

#import "AYBubbleView.h"

@interface AYBubbleView () {
    //    圆A切点
    CGPoint point_A;
    CGPoint point_B;
    //    圆B切点
    CGPoint point_C;
    CGPoint point_D;
    //    两圆切线中点坐标，控制BezierPath
    CGPoint controlPoint_AC;
    CGPoint controlPoint_BD;
    
    CGFloat radius_A;
    CGFloat radius_B;
    CGFloat center_distance;
    
    CGPoint circleA_Center;
    CGPoint circleB_Center;
    
    CGFloat sinValue;
    CGFloat cosValue;
}
@property (nonatomic, strong) UIView *frontView;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) CAShapeLayer *animationLayer;
@end

@implementation AYBubbleView

- (instancetype)initWithCenterPoint:(CGPoint)centerPoint bubleRadius:(CGFloat)radius addToSuperView:(UIView *)superView {
    
    if (self = [super initWithFrame:CGRectMake(centerPoint.x - radius, centerPoint.y - radius, radius * 2, radius * 2)]) {
        self.decayCoefficent = .1;
        [superView addSubview:self];
        [self config];
    }
    return self;
}

- (void)setBubbleColor:(UIColor *)bubbleColor {
    
    if (_bubbleColor != bubbleColor) {
        _bubbleColor = bubbleColor;
        self.frontView.backgroundColor = self.bubbleColor;
        self.backView.backgroundColor = self.bubbleColor;
    }
}

- (void)config {
    
    self.backgroundColor = [UIColor clearColor];
    self.animationLayer = [CAShapeLayer layer];
    self.frontView = [[UIView alloc] initWithFrame:self.frame];
    self.backView = [[UIView alloc] initWithFrame:self.frame];
    self.frontView.layer.cornerRadius = self.frontView.bounds.size.width * .5;
    self.backView.layer.cornerRadius = self.backView.bounds.size.width * .5;
    self.backView.hidden = YES;
    [self.superview addSubview:self.frontView];
    [self.superview addSubview:self.backView];
    UIPanGestureRecognizer *panGestureRecongnizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
    [self.frontView addGestureRecognizer:panGestureRecongnizer];
    [self addBubbleAnimation];
    
    self.unReadLabel = [[UILabel alloc] initWithFrame:self.frontView.bounds];
    self.unReadLabel.textAlignment = NSTextAlignmentCenter;
    self.unReadLabel.textColor = [UIColor whiteColor];
    self.unReadLabel.font = [UIFont systemFontOfSize:11 weight:0.05];
    [self.frontView addSubview:self.unReadLabel];
}

- (void)addBubbleAnimation {
    
    CAKeyframeAnimation *scaleXAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.x"];
    scaleXAnimation.values = @[@1.0,@1.1,@1.0];
    scaleXAnimation.keyTimes = @[@0,@0.5,@1.0];
    scaleXAnimation.repeatCount = HUGE_VAL;
    scaleXAnimation.autoreverses = YES;
    scaleXAnimation.duration = 2.0;
    scaleXAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleXAnimation forKey:@"frontScaleXAnimation"];
    
    CAKeyframeAnimation *scaleYAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale.y"];
    scaleYAnimation.values = @[@1.0,@1.1,@1.0];
    scaleYAnimation.keyTimes = @[@0,@0.5,@1.0];
    scaleYAnimation.duration = 2.4;
    scaleYAnimation.autoreverses = YES;
    scaleYAnimation.repeatCount = HUGE_VAL;
    scaleYAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.frontView.layer addAnimation:scaleYAnimation forKey:@"frontScaleYAnimation"];
}

- (void)removeBubbleAnimation {
    [self.frontView.layer removeAllAnimations];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    
    CGPoint panPoint = [pan locationInView:self.superview];
    if (pan.state == UIGestureRecognizerStateBegan) {
        self.backView.hidden = NO;
        [self removeBubbleAnimation];
    } else if (pan.state == UIGestureRecognizerStateChanged) {
        self.frontView.center = panPoint;
        [self calculatePoint];
        if (radius_B < radius_A / 10) {
            self.backView.hidden = YES;
            [self.animationLayer removeFromSuperlayer];
        }
    } else if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled || pan.state == UIGestureRecognizerStateFailed) {

        if (radius_B >= radius_A / 10) {
            
            [UIView animateWithDuration:.5 delay:0 usingSpringWithDamping:.4 initialSpringVelocity:.8 options:UIViewAnimationOptionCurveEaseInOut animations:^{
                self.frontView.frame = self.frame;
            } completion:^(BOOL finished) {
                if (finished) {
                    [self addBubbleAnimation];
                }
            }];
            if (self.cleanMessageBlock) {
                self.cleanMessageBlock(NO);
            }
        } else {
            [self hidenBubbleView];
            self.frontView.frame = self.frame;
            [self addBubbleAnimation];
            if (self.cleanMessageBlock) {
                self.cleanMessageBlock(YES);
            }
        }
        self.backView.bounds = self.frontView.bounds;
        self.backView.layer.cornerRadius = self.backView.frame.size.width * .5;
        [self.animationLayer removeFromSuperlayer];
        self.backView.hidden = YES;
    }
}

- (void)calculatePoint {
    
    circleA_Center = self.frontView.center;
    circleB_Center = self.backView.center;
    CGFloat x1 = circleA_Center.x;
    CGFloat y1 = circleA_Center.y;
    CGFloat x2 = circleB_Center.x;
    CGFloat y2 = circleB_Center.y;
    center_distance = sqrtf(powf(x1 - x2, 2) + powf(y1 - y2, 2));
    if (center_distance == 0) {
        sinValue = 0;
        cosValue = 1;
    } else {
        
        sinValue = (x2 - x1) / center_distance;
        cosValue = (y2 - y1) / center_distance;
    }
    
    radius_A = self.frontView.bounds.size.width * .5;
    radius_B = self.frontView.bounds.size.width * .5 - center_distance / self.decayCoefficent;
    
    point_A = CGPointMake(x1 - radius_A * cosValue, y1 + radius_A * sinValue);
    point_B = CGPointMake(x1 + radius_A * cosValue, y1 - radius_A * sinValue);
    point_C = CGPointMake(x2 - radius_B * cosValue, y2 + radius_B * sinValue);
    point_D = CGPointMake(x2 + radius_B * cosValue, y2 - radius_B * sinValue);
    controlPoint_AC = CGPointMake(point_C.x - center_distance * .5 * sinValue, point_C.y - center_distance * .5 * cosValue);
    controlPoint_BD = CGPointMake(point_D.x - center_distance * .5 * sinValue, point_D.y - center_distance * .5 * cosValue);
    UIBezierPath *shapePath = [UIBezierPath bezierPath];
    [shapePath moveToPoint:point_A];
    [shapePath addQuadCurveToPoint:point_C controlPoint:controlPoint_AC];
    [shapePath addLineToPoint:point_D];
    [shapePath addQuadCurveToPoint:point_B controlPoint:controlPoint_BD];
    [shapePath moveToPoint:point_A];
    [shapePath closePath];
    self.backView.bounds = CGRectMake(0, 0, radius_B * 2, radius_B * 2);
    self.backView.layer.cornerRadius = radius_B;
    
    self.animationLayer.path = shapePath.CGPath;
    self.animationLayer.fillColor = self.bubbleColor.CGColor;
    if (!self.backView.hidden) {
        [self.superview.layer addSublayer:self.animationLayer];
    }
}

- (void)setDecayCoefficent:(CGFloat)decayCoefficent {
    
    if (decayCoefficent > 1) {
        decayCoefficent = 1;
    }
    if (decayCoefficent < .05) {
        decayCoefficent = .03;
    }
    if (_decayCoefficent != decayCoefficent) {
        _decayCoefficent = decayCoefficent * 50;
    }
}

- (void)hidenBubbleView {
    
    self.frontView.hidden = YES;
    self.hidden = YES;
}

- (void)showBubbleView {
    
    self.frontView.hidden = NO;
    self.hidden = NO;
}
@end
