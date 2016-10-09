//
//  UIView+ZHCMessages.m
//  ZHChat
//
//  Created by aimoke on 16/8/9.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "UIView+ZHCMessages.h"

@implementation UIView (ZHCMessages)


- (void)zhc_pinSubview:(UIView *)subview toEdge:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant
{
    [self addConstraint:[NSLayoutConstraint constraintWithItem:subview
                                                     attribute:attribute
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:attribute
                                                    multiplier:1.0f
                                                      constant:constant]];
    
    
    
}

-(void)zhc_pinSelfToEdge:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant
{
     [self addConstraint:[NSLayoutConstraint constraintWithItem:self attribute:attribute relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:constant]];
}


- (void)zhc_pinAllEdgesOfSubview:(UIView *)subview
{
    [self zhc_pinSubview:subview toEdge:NSLayoutAttributeBottom withConstant:0.0f];
    [self zhc_pinSubview:subview toEdge:NSLayoutAttributeTop withConstant:0.0f];
    [self zhc_pinSubview:subview toEdge:NSLayoutAttributeLeading withConstant:0.0f];
    [self zhc_pinSubview:subview toEdge:NSLayoutAttributeTrailing withConstant:0.0f];
}


-(void)zhc_pinFrameOfSubView:(UIView *)subView withFrame:(CGRect)frame
{
    [self zhc_pinSubview:subView toEdge:NSLayoutAttributeLeading withConstant:frame.origin.x];
    [self zhc_pinSubview:subView toEdge:NSLayoutAttributeTop withConstant:frame.origin.y];
    
    [self zhc_pinSelfToEdge:NSLayoutAttributeWidth withConstant:frame.size.width];
    [self zhc_pinSelfToEdge:NSLayoutAttributeHeight withConstant:frame.size.height];
}


-(void)zhc_pinInsets:(UIEdgeInsets)edgeInsets withSubView:(UIView *)subview
{
    [self zhc_pinSubview:subview toEdge:NSLayoutAttributeBottom withConstant:-edgeInsets.bottom];
    [self zhc_pinSubview:subview toEdge:NSLayoutAttributeTop withConstant:edgeInsets.top];
    [self zhc_pinSubview:subview toEdge:NSLayoutAttributeLeading withConstant:edgeInsets.left];
    [self zhc_pinSubview:subview toEdge:NSLayoutAttributeTrailing withConstant:-edgeInsets.right];
}



@end
