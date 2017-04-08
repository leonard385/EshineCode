//
//  CAShapeLayer+Mask.m
//  PraticeSaftTeacher
//
//  Created by 逸信Mac on 16/8/11.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "CAShapeLayer+Mask.h"

#define kCorner  4.0f
#define KtriangleHeight 10.0f
@implementation CAShapeLayer (Mask)

+(instancetype)createPaoPaoMaskLayerWithView:(UIView*)View
{
    
    CGFloat Width = View.bounds.size.width;
    CGFloat Height = View.bounds.size.height - KtriangleHeight;
    
    
    UIBezierPath * path = [UIBezierPath bezierPath];

    [path moveToPoint:CGPointMake(kCorner,0)];
    [path addLineToPoint:CGPointMake(Width - kCorner,0)];
    
    [path addArcWithCenter:CGPointMake(Width - kCorner, kCorner)
                    radius:kCorner
                startAngle:M_PI_2*3
                  endAngle:2*M_PI
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(Width, Height - kCorner)];
    
    [path addArcWithCenter:CGPointMake(Width - kCorner, Height - kCorner)
                    radius:kCorner
                startAngle:0
                  endAngle:M_PI_2
                 clockwise:YES];
    
    [path addLineToPoint:CGPointMake((Width/2.0f) + KtriangleHeight,Height)];
    [path addLineToPoint:CGPointMake((Width/2.0f), Height + KtriangleHeight)];
    [path addLineToPoint:CGPointMake((Width/2.0f)- KtriangleHeight,Height)];
    
    [path addLineToPoint:CGPointMake(kCorner,Height)];
    
    [path addArcWithCenter:CGPointMake(kCorner, Height - kCorner)
                    radius:kCorner
                startAngle:M_PI_2
                  endAngle:M_PI
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(0,kCorner)];
    [path addArcWithCenter:CGPointMake(kCorner,kCorner)
                    radius:kCorner
                startAngle:M_PI
                  endAngle:M_PI_2*3
                 clockwise:YES];
    [path closePath];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.3f;
    layer.shadowOffset = CGSizeMake(0, 5.0f);
    
    return layer;
}

+(instancetype)createLeftPaoPaoMaskLayerWithView:(UIView*)View
{
    
    CGFloat Width = View.bounds.size.width;
    CGFloat Height = View.bounds.size.height;
    
    
    UIBezierPath * path = [UIBezierPath bezierPath];
    
    [path moveToPoint:CGPointMake(kCorner + KtriangleHeight,0)];
    [path addLineToPoint:CGPointMake(Width - kCorner,0)];
    
    [path addArcWithCenter:CGPointMake(Width - kCorner, kCorner)
                    radius:kCorner
                startAngle:M_PI_2*3
                  endAngle:2*M_PI
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(Width, Height - kCorner)];
    
    [path addArcWithCenter:CGPointMake(Width - kCorner, Height - kCorner)
                    radius:kCorner
                startAngle:0
                  endAngle:M_PI_2
                 clockwise:YES];
    
    
    
    [path addLineToPoint:CGPointMake(kCorner+KtriangleHeight,Height)];
    
    [path addArcWithCenter:CGPointMake(kCorner + KtriangleHeight, Height - kCorner)
                    radius:kCorner
                startAngle:M_PI_2
                  endAngle:M_PI
                 clockwise:YES];
    [path addLineToPoint:CGPointMake(KtriangleHeight,kCorner + KtriangleHeight + KtriangleHeight)];
    
    [path addLineToPoint:CGPointMake(0,KtriangleHeight+kCorner)];
    [path addLineToPoint:CGPointMake(KtriangleHeight,KtriangleHeight/2+kCorner)];
    [path addLineToPoint:CGPointMake(KtriangleHeight,kCorner)];
    
    [path addArcWithCenter:CGPointMake(kCorner + KtriangleHeight,kCorner)
                    radius:kCorner
                startAngle:M_PI
                  endAngle:M_PI_2*3
                 clockwise:YES];
    [path closePath];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc]init];
    layer.path = path.CGPath;
    layer.shadowColor = [UIColor blackColor].CGColor;
    layer.shadowOpacity = 0.3f;
    layer.shadowOffset = CGSizeMake(0, 5.0f);
    
    return layer;
}
@end
