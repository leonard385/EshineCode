//
//  ZHCMessagesBubleImageFactory.h
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZHCMessagesBubbleImage.h"


@interface ZHCMessagesBubbleImageFactory : NSObject

/**
 * Specifies the layout direction of the message bubble. The default value is initialized
 * from `[UIApplication sharedApplication]`.
 */
@property (nonatomic, assign)UIUserInterfaceLayoutDirection layOutDirection;

/**
 *  Creates and returns a new instance of `ZHCMessagesBubbleImageFactory` that uses the
 *  default bubble image assets, cap insets, and layout direction.
 *
 *  @return An initialized `ZHCMessagesBubbleImageFactory` object.
 */
- (instancetype)init;


/**
 *  Create and returns a new instance of ZHCMessagesBubleImageFactory
 *
 *  @param bubbleImage     bubbleImage
 *  @param capInsets       The values to use for the cap insets that define the unstretchable regions of the image.Specify `UIEdgeInsetsZero` to have the factory create insets that allow the image to stretch from its center point.
 
 *  @param layoutDirection Special the image layoutDirection
 *
 *  @return ZHCMessagesBubleImageFactory instance
 */
- (instancetype)initWithBubbleImage:(UIImage *)bubbleImage
                          capInsets:(UIEdgeInsets)capInsets
                    layoutDirection:(UIUserInterfaceLayoutDirection)layoutDirection;


/**
 *  Create and return a 'ZHCMessagesBubbleImage' object with specified color for "outgoing" messages
 *
 *  @param color message back color
 *
 *  @return 'ZHCMessagesBubbleImage' object
 */
- (ZHCMessagesBubbleImage *)outgoingMessagesBubbleImageWithColor:(UIColor *)color;


/**
 *  Create and return a 'ZHCMessagesBubbleImage' object with specified color for "ingoing" messages
 *
 *  @param color message back color
 *
 *  @return 'ZHCMessagesBubbleImage' object
 */

- (ZHCMessagesBubbleImage *)incomingMessagesBubbleImageWithColor:(UIColor *)color;
@end
