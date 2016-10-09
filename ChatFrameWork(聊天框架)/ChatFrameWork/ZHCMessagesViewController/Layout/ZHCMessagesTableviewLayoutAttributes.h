//
//  ZHCMessagesTableviewLayoutAttributes.h
//  ZHChat
//
//  Created by aimoke on 16/8/11.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN


@interface ZHCMessagesTableviewLayoutAttributes : NSObject<NSCopying>


/**
 *   ZHCMessagesTableviewLayoutAttributes factory
 *
 *  @return ZHCMessagesTableviewLayoutAttributes instance
 */
+(instancetype)shareZHCMessagesTableviewLayoutAttributesFactory;


/**
 *  The inset of the textView Frame in textViewContainView.
 *  The specified inset values should be greater than or equal to `0.0`.
 */
@property (assign, nonatomic) UIEdgeInsets textViewTextFrameInsets;

/**
 *  message avatar container view space with Super View.
 */
@property(assign, nonatomic) CGFloat messageAvatarHorizontallySpaceWithSuperView;

/**
 *  message bubble container view space with Super View.
 */
@property(assign, nonatomic) CGFloat messageBubbleHorizontallySpaceWithSuperView;

/**
 *  message bubble container view space with Avatar View.
 */
@property(assign, nonatomic) CGFloat messageBubbleSpaceWithAvatar;


/**
 *  The font used to display the body of a text message in a message bubble within a `ZHCMessagesTableviewCell`.
 *  This value must not be `nil`.
 */
@property (strong, nonatomic) UIFont *messageBubbleFont;

/**
 *  The width of the `messageBubbleContainerView` of a `ZHCMessagesTableviewCell`.
 *  This value should be greater than `0.0`.
 *
 *  @see ZHCMessagesTableviewCell.
 */
@property (assign, nonatomic) CGFloat messageBubbleContainerViewWidth;

/**
 *  The inset of the text container's layout area within the text view's content area in a `ZHCMessagesTableviewCell`.
 *  The specified inset values should be greater than or equal to `0.0`.
 */
@property (assign, nonatomic) UIEdgeInsets textViewTextContainerInsets;



/**
 *  The size of the `avatarImageView` of a `ZHCMessagesTableviewCell`.
 *  The size values should be greater than or equal to `0.0`.
 */
//@property (assign, nonatomic) CGSize avatarViewSize;

/**
 *  The size of the `avatarImageView` of a `ZHCMessagesTableviewCellIncoming`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see ZHCMessagesTableviewCellIncoming.
 */
@property (assign, nonatomic) CGSize incomingAvatarViewSize;

/**
 *  The size of the `avatarImageView` of a `ZHCMessagesTableviewCellOutgoing`.
 *  The size values should be greater than or equal to `0.0`.
 *
 *  @see `ZHCMessagesTableviewCellOutgoing`.
 */
@property (assign, nonatomic) CGSize outgoingAvatarViewSize;

/**
 *  The height of the `cellTopLabel` of a `ZHCMessagesTableviewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see ZHCMessagesTableviewCell.
 */
@property (assign, nonatomic) CGFloat cellTopLabelHeight;

/**
 *  The height of the `messageBubbleTopLabel` of a `ZHCMessagesTableviewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see ZHCMessagesTableviewCell.
 */
@property (assign, nonatomic) CGFloat messageBubbleTopLabelHeight;

/**
 *  The height of the `cellBottomLabel` of a `ZHCMessagesTableviewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see ZHCMessagesTableviewCell.
 */
@property (assign, nonatomic) CGFloat cellBottomLabelHeight;
@end
NS_ASSUME_NONNULL_END