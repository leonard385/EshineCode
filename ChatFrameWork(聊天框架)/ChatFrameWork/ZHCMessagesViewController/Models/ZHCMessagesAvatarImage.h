//
//  ZHCMessagesAvatarImage.h
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZHCMessageAvatarImageDataSource.h"

NS_ASSUME_NONNULL_BEGIN
@interface ZHCMessagesAvatarImage : NSObject<NSCopying,ZHCMessageAvatarImageDataSource>
/**
 *  The avatar image for a regular display state.
 */
@property (nonatomic, strong, nullable) UIImage *avatarImage;

/**
 *  The avatar image for a highlighted display state.
 */
@property (nonatomic, strong, nullable) UIImage *avatarHighlightedImage;


/**
 *  Returns the placeholder image for an avatar to display if avatarImage is `nil`.
 */
@property (nonatomic, strong, readonly) UIImage *avatarPlaceholderImage;


/**
 *  Initializes and returns an avatar image object having the specified image.
 *
 *  @param image The image for this avatar image. This image will be used for the all of the following
 *  properties: avatarImage, avatarHighlightedImage, avatarPlaceholderImage;
 *  This value must not be `nil`.
 *
 *  @return An initialized `ZHCMessagesAvatarImage` object.
 */
+ (instancetype)avatarWithImage:(UIImage *)image;


/**
 *  Initializes and returns an avatar image object having the specified placeholder image.
 *
 *  @param placeholderImage The placeholder image for this avatar image. This value must not be `nil`.
 *
 *  @return An initialized `ZHCMessagesAvatarImage` object.
 */
+ (instancetype)avatarImageWithPlaceholder:(UIImage *)placeholderImage;


/**
 *  Initializes and returns an avatar image object having the specified regular, highlighed, and placeholder images.
 *
 *  @param avatarImage      The avatar image for a regular display state.
 *  @param highlightedImage The avatar image for a highlighted display state.
 *  @param placeholderImage The placeholder image for this avatar image. This value must not be `nil`.
 *
 *  @return An initialized `ZHCMessagesAvatarImage` object.
 */
- (instancetype)initWithAvatarImage:(nullable UIImage *)avatarImage
                   highlightedImage:(nullable UIImage *)highlightedImage
                   placeholderImage:(UIImage *)placeholderImage NS_DESIGNATED_INITIALIZER;

/**
 *  Not a valid initializer.
 */
- (id)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
