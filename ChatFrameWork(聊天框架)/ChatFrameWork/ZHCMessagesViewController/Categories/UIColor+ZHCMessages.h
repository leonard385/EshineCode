//
//  UIColor+ZHCMessages.h
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (ZHCMessages)
/**
 *  create a color with HSB Values lick iOS messages green bubble color.
 *
 *  @return color
 */
+ (UIColor *)zhc_messagesBubbleGreenColor;

+(UIColor *)zhc_messagesBubbleBlueColor;

+(UIColor *)zhc_messagesBubbleRedColor;

+(UIColor *)zhc_messagesBubbleLightGrayColor;

/**
 *  Creates and returns a new color object whose brightness component is decreased by the given value, using the initial color values of the receiver.
 *
 *  @param value A floating point value describing the amount by which to decrease the brightness of the receiver.
 *
 *  @return A new color object whose brightness is decreased by the given values. The other color values remain the same as the receiver.
 */
- (UIColor *)zhc_colorByDarkeningColorWithValue:(CGFloat)value;
@end
