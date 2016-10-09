//
//  ZHCVideoMediaItem.h
//  ZHChat
//
//  Created by aimoke on 16/8/18.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMediaItem.h"
NS_ASSUME_NONNULL_BEGIN

/**
 *  The `ZHCVideoMediaItem` class is a concrete `ZHCMediaItem` subclass that implements the `ZHCMessageMediaData` protocol
 *  and represents a video media message. An initialized `ZHCVideoMediaItem` object can be passed
 *  to a `ZHCMediaMessage` object during its initialization to construct a valid media message object.
 *  You may wish to subclass `ZHCVideoMediaItem` to provide additional functionality or behavior.
 */

@interface ZHCVideoMediaItem : ZHCMediaItem<ZHCMessageMediaData, NSCoding, NSCopying>

/**
 *  The URL that identifies a video resource.
 */
@property (nonatomic, strong, nullable) NSURL *fileURL;

/**
 *  A boolean value that specifies whether or not the video is ready to be played.
 *
 *  @discussion When set to `YES`, the video is ready. When set to `NO` it is not ready.
 */
@property (nonatomic, assign) BOOL isReadyToPlay;

/**
 *  Initializes and returns a video media item having the given fileURL.
 *
 *  @param fileURL       The URL that identifies the video resource.
 *  @param isReadyToPlay A boolean value that specifies if the video is ready to play.
 *
 *  @return An initialized `ZHCVideoMediaItem`.
 *
 *  @discussion If the video must be downloaded from the network,
 *  you may initialize a `ZHCVideoMediaItem` with a `nil` fileURL or specify `NO` for
 *  isReadyToPlay. Once the video has been saved to disk, or is ready to stream, you can
 *  set the fileURL property or isReadyToPlay property, respectively.
 */
- (instancetype)initWithFileURL:(nullable NSURL *)fileURL isReadyToPlay:(BOOL)isReadyToPlay;
@end
NS_ASSUME_NONNULL_END