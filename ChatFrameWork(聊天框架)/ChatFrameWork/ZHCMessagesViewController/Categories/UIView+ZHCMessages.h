//
//  UIView+ZHCMessages.h
//  ZHChat
//
//  Created by aimoke on 16/8/9.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (ZHCMessages)


/**
 *  Pins the subview of the receiver to the edge of its frame, as specified by the given attribute, by adding a layout constraint.
 *
 *  @param subview   The subview to which the receiver will be pinned.
 *  @param attribute The layout constraint attribute specifying one of `NSLayoutAttributeBottom`, `NSLayoutAttributeTop`, `NSLayoutAttributeLeading`, `NSLayoutAttributeTrailing`.
 *  @param constant   The constant.
 */
- (void)zhc_pinSubview:(UIView *)subview toEdge:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant;


/**
 *  Pins the self as specified by the given attribute, by adding a layout constraint.
 *
 *  @param attribute The layout constraint attribute specifying one of `NSLayoutAttributeWidth`,'NSLayoutAttributeHeight'.

 *  @param constant  The constant.
 */
-(void)zhc_pinSelfToEdge:(NSLayoutAttribute)attribute withConstant:(CGFloat)constant;

/**
 *  Pins all edges of the specified subview to the receiver.
 *
 *  @param subview The subview to which the receiver will be pinned.
 */
- (void)zhc_pinAllEdgesOfSubview:(UIView *)subview;


/**
 *  Pins all edges of the specified subview to the receiver.
 *
 *  @param subview The subview to which the receiver will be pinned.
 */
-(void)zhc_pinFrameOfSubView:(UIView *)subView withFrame:(CGRect)frame;

/**
 *  Pins spicified edges of the specified subview to the receiver.
 *
 *  @param subview The subview to which the receiver will be pinned.
 */
-(void)zhc_pinInsets:(UIEdgeInsets)edgeInsets withSubView:(UIView *)subview;
@end
