//
//  UIView+DESIGNABLE.m
//  BESIGNABLE
//
//  Created by 123 on 16/5/22.
//  Copyright © 2016年 asura. All rights reserved.
//

#import "UIView+EXTENSION.h"
#import <objc/runtime.h>

@implementation UIView (EXTENSION)

#pragma mark - IB
- (void)setCornerRadius:(CGFloat)cornerRadius{
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius = cornerRadius;
}

- (void)setBorderColor:(UIColor *)borderColor{
    self.layer.borderColor = borderColor.CGColor;
}

- (void)setBorderWidth:(CGFloat)borderWidth{
    self.layer.borderWidth = borderWidth;
}

- (void)setDefineValue:(CGFloat)defineValue{
    objc_setAssociatedObject(self, @selector(defineValue), @(defineValue), OBJC_ASSOCIATION_ASSIGN);
}

- (CGFloat)cornerRadius{
    return self.layer.cornerRadius;
}

- (UIColor *)borderColor{
    return [UIColor colorWithCGColor:self.layer.borderColor];
}

- (CGFloat)borderWidth{
    return self.layer.borderWidth;
}

- (CGFloat)defineValue{
    return [objc_getAssociatedObject(self, @selector(defineValue)) floatValue];
}

#pragma mark - 坐标
- (void)setOriginX:(CGFloat)originX {
    CGRect frame = self.frame;
    frame.origin.x = originX;
    self.frame = frame;
    return;
}

- (CGFloat)originX {
    return self.frame.origin.x;
}

- (void)setOriginY:(CGFloat)originY {
    CGRect frame = self.frame;
    frame.origin.y = originY;
    self.frame = frame;
    return;
}

- (CGFloat)originY {
    return self.frame.origin.y;
}

- (void)setRightX:(CGFloat)rightX {
    CGRect frame = self.frame;
    frame.origin.x = rightX - [self width];
    self.frame = frame;
    return;
}

- (CGFloat)rightX {
    return [self originX] + [self width];
}

- (void)setBottomY:(CGFloat)bottomY {
    CGRect frame = self.frame;
    frame.origin.y = bottomY - [self height];
    self.frame = frame;
    return;
}

- (CGFloat)bottomY {
    return [self originY] + [self height];
}

- (void)setCenterX:(CGFloat)centerX {
    self.center = CGPointMake(centerX, self.center.y);
    return;
}

- (CGFloat)centerX {
    return self.center.x;
}

- (void)setCenterY:(CGFloat)centerY {
    self.center = CGPointMake(self.center.x, centerY);
    return;
}

- (CGFloat)centerY {
    return self.center.y;
}

- (void)setWidth:(CGFloat)width {
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
    return;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setHeight:(CGFloat)height {
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
    return;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setOrigin:(CGPoint)origin {
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
    return;
}

- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
    return;
}

- (CGSize)size {
    return self.frame.size;
}


// 移除此view上的所有子视图
- (void)removeAllSubviews {
    for (UIView *view in self.subviews) {
        [view removeFromSuperview];
    }
}
//获取视图所在的 UIViewController
- (UIViewController *)viewController
{
    for (UIView *next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
//切圆角
- (void)roundWithSide:(BBTSide)side spacing:(CGFloat)spacing
{
    UIBezierPath *maskPath;
    switch (side) {
        case BBTSideTopLeft: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:UIRectCornerTopLeft
                                                   cornerRadii:CGSizeMake(spacing, spacing)];
            break;
        }
        case BBTSideTopRight: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:UIRectCornerTopRight
                                                   cornerRadii:CGSizeMake(spacing, spacing)];
            break;
        }
        case BBTSideBottomLeft: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:UIRectCornerBottomLeft
                                                   cornerRadii:CGSizeMake(spacing, spacing)];
            break;
        }
        case BBTSideBottomRight: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:UIRectCornerBottomRight
                                                   cornerRadii:CGSizeMake(spacing, spacing)];
            break;
        }
        case BBTSideAll: {
            maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                             byRoundingCorners:UIRectCornerAllCorners
                                                   cornerRadii:CGSizeMake(spacing, spacing)];
            break;
        }
    }
    //上左,下左
    if (side == (BBTSideTopLeft | BBTSideBottomLeft)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomLeft
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    //上左,下右
    if (side == (BBTSideTopLeft | BBTSideBottomRight)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    //上右,下左
    if (side == (BBTSideTopLeft | BBTSideBottomRight)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    //上右,下右
    if (side == (BBTSideTopRight | BBTSideBottomRight)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    //上右,上左
    if (side == (BBTSideTopRight | BBTSideTopLeft)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerTopRight | UIRectCornerTopLeft
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    //下左,下右
    if (side == (BBTSideBottomLeft | BBTSideBottomRight)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerBottomLeft | UIRectCornerBottomRight
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    //上左,上右,下左
    if (side == (BBTSideTopLeft | BBTSideBottomLeft | BBTSideTopRight)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight | UIRectCornerTopRight
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    //上左,上右,下右
    if (side == (BBTSideTopLeft | BBTSideBottomRight | BBTSideTopRight)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight | UIRectCornerTopRight
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    //上右,下左,下右
    if (side == (BBTSideTopRight | BBTSideBottomLeft | BBTSideBottomRight)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerTopRight | UIRectCornerBottomRight | UIRectCornerBottomLeft
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    //上左,下左,下右
    if (side == (BBTSideTopLeft | BBTSideBottomLeft | BBTSideBottomRight)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerTopLeft | UIRectCornerBottomRight | UIRectCornerBottomLeft
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    if (side == (BBTSideTopLeft | BBTSideBottomLeft | BBTSideBottomRight | BBTSideTopRight)) {
        maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds
                                         byRoundingCorners:UIRectCornerAllCorners
                                               cornerRadii:CGSizeMake(spacing, spacing)];
    }
    // Create the shape layer and set its path
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = self.bounds;
    maskLayer.path = maskPath.CGPath;
    
    // Set the newly created shape layer as the mask for the image view's layer
    self.layer.mask = maskLayer;
    
    self.layer.masksToBounds = YES;
}
@end
