//
//  ZHCMediaItem.h
//  ZHChat
//
//  Created by aimoke on 16/8/15.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessageMediaData.h"
#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN
/**
 *  The `ZHCMediaItem` class is an abstract base class for media item model objects that represents
 *  a single media attachment for a user message. It provides some default behavior for media items,
 *  including a default mediaViewDisplaySize, a default mediaPlaceholderView, and view masking as
 *  specified by appliesMediaViewMaskAsOutgoing.
 *
 *  @warning This class is intended to be subclassed. You should not use it directly.
 *
 *  @see ZHCLocationMediaItem.
 *  @see ZHCPhotoMediaItem.
 *  @see ZHCVideoMediaItem.
 */

@interface ZHCMediaItem : NSObject<ZHCMessageMediaData, NSCoding, NSCopying>

/**
 *  A boolean value indicating whether this media item should apply
 *  an outgoing or incoming bubble image mask to its media views.
 *  Specify `YES` for an outgoing mask, and `NO` for an incoming mask.
 *  The default value is `YES`.
 */
@property (assign, nonatomic) BOOL appliesMediaViewMaskAsOutgoing;

/**
 *  Initializes and returns a media item with the specified value for maskAsOutgoing.
 *
 *  @param maskAsOutgoing A boolean value indicating whether this media item should apply
 *  an outgoing or incoming bubble image mask to its media views.
 *
 *  @return An initialized `ZHCMediaItem` object.
 */
- (instancetype)initWithMaskAsOutgoing:(BOOL)maskAsOutgoing;

/**
 *  Clears any media view or media placeholder view that the item has cached.
 */
- (void)clearCachedMediaViews;

@end
NS_ASSUME_NONNULL_END