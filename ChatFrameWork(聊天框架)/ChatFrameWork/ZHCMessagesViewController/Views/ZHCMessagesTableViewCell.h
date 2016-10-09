//
//  ZHCMessagesTableViewCell.h
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHCMessagesLabel.h"
#import "ZHCMessagesCellTextView.h"

@class ZHCMessagesTableViewCell;
@class ZHCMessagesTableviewLayoutAttributes;

NS_ASSUME_NONNULL_BEGIN
/**
 *  The `ZHCMessagesTableViewCellDelegate` protocol defines methods that allow you to manage
 *  additional interactions within the TableView  cell.
 */
@protocol ZHCMessagesTableViewCellDelegate <NSObject>

@required


/**
 *  the cell's attributes the delegate must finish
 *
 *  @return ZHCMessagesTableviewLayoutAttributes object
 */
-(ZHCMessagesTableviewLayoutAttributes *)messagesTableViewCellAttributes;

/**
 *  Tells the delegate that the avatarImageView of the cell has been tapped.
 *
 *  @param cell The cell that received the tap touch event.
 */
- (void)messagesTableViewCellDidTapAvatar:(ZHCMessagesTableViewCell *)cell;

/**
 *  Tells the delegate that the message bubble of the cell has been tapped.
 *
 *  @param cell The cell that received the tap touch event.
 */
- (void)messagesTableViewCellDidTapMessageBubble:(ZHCMessagesTableViewCell *)cell;

/**
 *  Tells the delegate that the cell has been tapped at the point specified by position.
 *
 *  @param cell The cell that received the tap touch event.
 *  @param position The location of the received touch in the cell's coordinate system.
 *
 *  @discussion This method is *only* called if position is *not* within the bounds of the cell's
 *  avatar image view or message bubble image view. In other words, this method is *not* called when the cell's
 *  avatar or message bubble are tapped.
 *
 *  @see `messagesTableViewCellDidTapAvatar:`
 *  @see `messagesTableViewCellDidTapMessageBubble:`
 */
- (void)messagesTableViewCellDidTapCell:(ZHCMessagesTableViewCell *)cell atPosition:(CGPoint)position;

/**
 *  Tells the delegate that an actions has been selected from the menu of this cell.
 *  This method is automatically called for any registered actions.
 *
 *  @param cell The cell that displayed the menu.
 *  @param action The action that has been performed.
 *  @param sender The object that initiated the action.
 *
 *  @see `ZHCMessagesTableViewCell`
 */
- (void)messagesTableViewCell:(ZHCMessagesTableViewCell *)cell didPerformAction:(SEL)action withSender:(id)sender;

@end


/**
 *  The `ZHCMessagesTableViewCell` is an abstract base class that presents the content for
 *  a single message data item when that item is within the TableView view’s visible bounds.
 *  The layout and presentation of cells is managed by the TableView view and its corresponding layout object.
 *
 *  @warning This class is intended to be subclassed. You should not use it directly.
 *
 *  @see ZHCMessagesTableViewCellIncoming.
 *  @see ZHCMessagesTableViewCellOutgoing.
 */

@interface ZHCMessagesTableViewCell : UITableViewCell


/**
 *  The object that acts as the delegate for the cell.
 */
@property (weak, nonatomic) id<ZHCMessagesTableViewCellDelegate> delegate;



/**
 *  The height of the `cellsSpaceLabel` of a `ZHCMessagesTableviewCell`.
 *  This value should be greater than or equal to `0.0`.
 *
 *  @see ZHCMessagesTableviewCell.
 */
@property (assign, nonatomic) CGFloat cellsSpaceLabelHeight;

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

/**
 *  Returns the label that is pinned to the top of the cell.
 *  This label is most commonly used to display message timestamps.
 */
@property (weak, nonatomic, readonly) ZHCMessagesLabel *cellTopLabel;

/**
 *  Returns the label that is pinned just above the messageBubbleImageView, and below the cellTopLabel.
 *  This label is most commonly used to display the message sender.
 */
@property (weak, nonatomic, readonly) ZHCMessagesLabel *messageBubbleTopLabel;

/**
 *  Returns the label that is pinned to the bottom of the cell.
 *  This label is most commonly used to display message delivery status.
 */
@property (weak, nonatomic, readonly) ZHCMessagesLabel *cellBottomLabel;

/**
 *  Returns the text view of the cell. This text view contains the message body text.
 *
 *  @warning If mediaView returns a non-nil view, then this value will be `nil`.
 */
@property (weak, nonatomic, readonly) ZHCMessagesCellTextView *textView;


/**
 *  Returns the text Label of the cell. This text Label contains the message body text.
 *
 *  @warning If mediaView returns a non-nil view, then this value will be `nil`.
 */
@property (weak, nonatomic, readonly) ZHCMessagesLabel *messageLabel;


/**
 *  Returns the bubble image view of the cell that is responsible for displaying message bubble images.
 *
 *  @warning If mediaView returns a non-nil view, then this value will be `nil`.
 */
@property (weak, nonatomic, readonly) UIImageView *messageBubbleImageView;

/**
 *  Returns the message bubble container view of the cell. This view is the superview of
 *  the cell's textView and messageBubbleImageView.
 *
 *  @discussion You may customize the cell by adding custom views to this container view.
 *  To do so, override `tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath`
 *
 *  @warning You should not try to manipulate any properties of this view, for example adjusting
 *  its frame, nor should you remove this view from the cell or remove any of its subviews.
 *  Doing so could result in unexpected behavior.
 */
@property (weak, nonatomic, readonly) UIView *messageBubbleContainerView;

/**
 *  Returns the avatar image view of the cell that is responsible for displaying avatar images.
 */
@property (weak, nonatomic, readonly) UIImageView *avatarImageView;


/**
 *  Returns the avatar container view of the cell. This view is the superview of the cell's avatarImageView.
 *
 *  @discussion You may customize the cell by adding custom views to this container view.
 *  To do so, override `tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath`
 *
 *  @warning You should not try to manipulate any properties of this view, for example adjusting
 *  its frame, nor should you remove this view from the cell or remove any of its subviews.
 *  Doing so could result in unexpected behavior.
 */
@property (weak, nonatomic, readonly) UIView *avatarContainerView;


/**
 *  The media view of the cell. This view displays the contents of a media message.
 *
 *  @warning If this value is non-nil, then textView and messageBubbleImageView will both be `nil`.
 */
@property (weak, nonatomic) UIView *mediaView;


/**
 *  Returns the underlying gesture recognizer for tap gestures in the avatarImageView of the cell.
 *  This gesture handles the tap event for the avatarImageView and notifies the cell's delegate.
 */
@property (weak, nonatomic, readonly) UITapGestureRecognizer *tapGestureRecognizer;

/**
 *  Update layout
 */
-(void)applyLayoutAttributes;


/**
 *  Initial MediaView
 *
 *  @param mediaView         The meida view
 *  @param isOutgoingMessage The message is outgoingMessage or not.
 */
-(void)setMediaView:(UIView *)mediaView withisOutgoingMessage:(BOOL )isOutgoingMessage;

#pragma mark - Class methods

/**
 *  Returns the `UINib` object initialized for the cell.
 *
 *  @return The initialized `UINib` object.
 */
+ (UINib *)nib;

/**
 *  Returns the default string used to identify a reusable cell for text message items.
 *
 *  @return The string used to identify a reusable cell.
 */
+ (NSString *)cellReuseIdentifier;


/**
 *  Returns the default string used to identify a reusable cell for media message items.
 *
 *  @return The string used to identify a reusable cell.
 */
+ (NSString *)mediaCellReuseIdentifier;

/**
 *  Registers an action to be available in the cell's menu.
 *
 *  @param action The selector to register with the cell.
 *
 *  @discussion Non-standard or non-system actions must be added to the `UIMenuController` manually.
 *  You can do this by creating a new `UIMenuItem` and adding it via the controller's `menuItems` property.
 *
 *  @warning Note that all message cells share the all actions registered here.
 */
+ (void)registerMenuAction:(SEL)action;




@end
NS_ASSUME_NONNULL_END