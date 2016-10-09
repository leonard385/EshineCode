//
//  ZHCMessagesMediaViewBubbleImageMasker.h
//  ZHChat
//
//  Created by aimoke on 16/8/15.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@class ZHCMessagesBubbleImageFactory;

NS_ASSUME_NONNULL_BEGIN

/**
 *  An instance of `ZHCMessagesMediaViewBubbleImageMasker` is an object that masks
 *  media views for a `ZHCMessageMediaData` object. Given a view, it will mask the view
 *  with a bubble image for an outgoing or incoming media view.
 *
 *  @see ZHCMessageMediaData.
 *  @see ZHCMessagesBubbleImageFactory.
 *  @see ZHCMessagesBubbleImage.
 */

@interface ZHCMessagesMediaViewBubbleImageMasker : NSObject

/**
 *  Returns the bubble image factory that the masker uses to mask media views.
 */
@property (strong, nonatomic, readonly) ZHCMessagesBubbleImageFactory *bubbleImageFactory;

/**
 *  Creates and returns a new instance of `ZHCMessagesMediaViewBubbleImageMasker`
 *  that uses a default instance of `ZHCMessagesBubbleImageFactory`. The masker uses the `ZHCMessagesBubbleImage`
 *  objects returned by the factory to mask media views.
 *
 *  @return An initialized `ZHCMessagesMediaViewBubbleImageMasker` object.
 *
 *  @see ZHCMessagesBubbleImageFactory.
 *  @see ZHCMessagesBubbleImage.
 */
- (instancetype)init;

/**
 *  Creates and returns a new instance of `ZHCMessagesMediaViewBubbleImageMasker`
 *  having the specified bubbleImageFactory. The masker uses the `ZHCMessagesBubbleImage`
 *  objects returned by the factory to mask media views.
 *
 *  @param bubbleImageFactory An initialized `ZHCMessagesBubbleImageFactory` object to use for masking media views. This value must not be `nil`.
 *
 *  @return An initialized `ZHCMessagesMediaViewBubbleImageMasker` object.
 *
 *  @see ZHCMessagesBubbleImageFactory.
 *  @see ZHCMessagesBubbleImage.
 */
- (instancetype)initWithBubbleImageFactory:(ZHCMessagesBubbleImageFactory *)bubbleImageFactory NS_DESIGNATED_INITIALIZER;

/**
 *  Applies an outgoing bubble image mask to the specified mediaView.
 *
 *  @param mediaView The media view to mask.
 */
- (void)applyOutgoingBubbleImageMaskToMediaView:(UIView *)mediaView;

/**
 *  Applies an incoming bubble image mask to the specified mediaView.
 *
 *  @param mediaView The media view to mask.
 */
- (void)applyIncomingBubbleImageMaskToMediaView:(UIView *)mediaView;

/**
 *  A convenience method for applying a bubble image mask to the specified mediaView.
 *  This method uses the default instance of `ZHCMessagesBubbleImageFactory`.
 *
 *  @param mediaView  The media view to mask.
 *  @param isOutgoing A boolean value specifiying whether or not the mask should be for an outgoing or incoming view.
 *  Specify `YES` for outgoing and `NO` for incoming.
 */
+ (void)applyBubbleImageMaskToMediaView:(UIView *)mediaView isOutgoing:(BOOL)isOutgoing;
@end
NS_ASSUME_NONNULL_END