//
//  ZHCPhotoMediaItem.h
//  ZHChat
//
//  Created by aimoke on 16/8/15.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMediaItem.h"

NS_ASSUME_NONNULL_BEGIN
/**
 *  The `ZHCPhotoMediaItem` class is a concrete `ZHCMediaItem` subclass that implements the `ZHCMessageMediaData` protocol
 *  and represents a photo media message. An initialized `ZHCPhotoMediaItem` object can be passed
 *  to a `ZHCMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `ZHCPhotoMediaItem` to provide additional functionality or behavior.
 */
@interface ZHCPhotoMediaItem : ZHCMediaItem

/**
 *  The image for the photo media item. The default value is `nil`.
 */
@property (copy, nonatomic, nullable) UIImage *image;

/**
 *  Initializes and returns a photo media item object having the given image.
 *
 *  @param image The image for the photo media item. This value may be `nil`.
 *
 *  @return An initialized `ZHCPhotoMediaItem`.
 *
 *  @discussion If the image must be dowloaded from the network,
 *  you may initialize a `ZHCPhotoMediaItem` object with a `nil` image.
 *  Once the image has been retrieved, you can then set the image property.
 */
- (instancetype)initWithImage:(nullable UIImage *)image;

@end
NS_ASSUME_NONNULL_END