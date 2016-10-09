//
//  ZHCMessageBubbleImageDataSource.h
//  ZHChat
//
//  Created by aimoke on 16/8/16.
//  Copyright © 2016年 zhuo. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


/**
 *  The `ZHCMessageBubbleImageDataSource` protocol defines the common interface through which
 *  a `ZHCMessagesViewController` and `ZHCMessagesTableViewView` interact with
 *  message bubble image model objects.
 *
 *  It declares the required and optional methods that a class must implement so that instances
 *  of that class can be display properly within a `ZHCMessagesTableViewCell`.
 *
 *  A concrete class that conforms to this protocol is provided in the library. See `ZHCMessagesBubbleImage`.
 *
 *  @see ZHCMessagesBubbleImage.
 */

@protocol ZHCMessageBubbleImageDataSource <NSObject>

@required

/**
 *  @return The message bubble image for a regular display state.
 *
 *  @warning You must not return `nil` from this method.
 */
- (UIImage *)messageBubbleImage;

/**
 *  @return The message bubble image for a highlighted display state.
 *
 *  @warning You must not return `nil` from this method.
 */
- (UIImage *)messageBubbleHighlightedImage;

@end
NS_ASSUME_NONNULL_END