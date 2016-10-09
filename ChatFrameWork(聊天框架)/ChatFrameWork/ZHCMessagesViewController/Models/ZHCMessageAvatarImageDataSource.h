//
//  ZHCMessageAvatarImageDataSource.h
//  ZHChat
//
//  Created by aimoke on 16/8/16.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 *  The `ZHCMessageAvatarImageDataSource` protocol defines the common interface through which
 *  a `ZHCMessagesViewController` and `ZHCMessagesTableViewView` interact with avatar image model objects.
 *
 *  It declares the required and optional methods that a class must implement so that instances
 *  of that class can be display properly within a `ZHCMessagesTableViewCell`.
 *
 *  A concrete class that conforms to this protocol is provided in the library. See `ZHCMessagesAvatarImage`.
 *
 *  @see ZHCMessagesAvatarImage.
 */

@protocol ZHCMessageAvatarImageDataSource <NSObject>

@required

/**
 *  @return The avatar image for a regular display state.
 *
 *  @discussion You may return `nil` from this method while the image is being downloaded.
 */
- (nullable UIImage *)avatarImage;

/**
 *  @return The avatar image for a highlighted display state.
 *
 *  @discussion You may return `nil` from this method if this does not apply.
 */
- (nullable UIImage *)avatarHighlightedImage;

/**
 *  @return A placeholder avatar image to be displayed if avatarImage is not yet available, or `nil`.
 *  For example, if avatarImage needs to be downloaded, this placeholder image
 *  will be used until avatarImage is not `nil`.
 *
 *  @discussion If you do not need support for a placeholder image, that is, your images
 *  are stored locally on the device, then you may simply return the same value as avatarImage here.
 *
 *  @warning You must not return `nil` from this method.
 */
- (UIImage *)avatarPlaceholderImage;


@end


NS_ASSUME_NONNULL_END