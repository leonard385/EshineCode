//
//  ZHCMessagesTableViewDataSource.h
//  ZHChat
//
//  Created by aimoke on 16/8/11.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class ZHCMessagesTableView;
@class ZHCMessagesTableViewCell;

@protocol ZHCMessageData;
@protocol ZHCMessageBubbleImageDataSource;
@protocol ZHCMessageAvatarImageDataSource;

NS_ASSUME_NONNULL_BEGIN
@protocol ZHCMessagesTableViewDataSource <NSObject,UITableViewDataSource>

@required
/**
 *  Asks the data source for the current sender's display name, that is, the current user who is sending messages.
 *
 *  @return An initialized string describing the current sender to display in a `ZHCMessagestableViewCell`.
 *
 *  @warning You must not return `nil` from this method. This value does not need to be unique.
 */
- (NSString *)senderDisplayName;

/**
 *  Asks the data source for the current sender's unique identifier, that is, the current user who is sending messages.
 *
 *  @return An initialized string identifier that uniquely identifies the current sender.
 *
 *  @warning You must not return `nil` from this method. This value must be unique.
 */
- (NSString *)senderId;

/**
 *  Asks the data source for the message data that corresponds to the specified cell at indexPath in the tableView.
 *
 *  @param tableView The tableView requesting this information.
 *  @param indexPath      The index path that specifies the location of the cell.
 *
 *  @return An initialized object that conforms to the `ZHCMessageData` protocol. You must not return `nil` from this method.
 */

/**
 *  Asks the data source for the message data that corresponds to the specified cell at indexPath in the tableView.
 *
 *  @param tableView The tableView requesting this information.
 *  @param indexPath      The index path that specifies the location of the cell.
 *
 *  @return An initialized object that conforms to the `ZHCMessageData` protocol. You must not return `nil` from this method.
 */
- (id<ZHCMessageData>)tableView:(ZHCMessagesTableView*)tableView messageDataForCellAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  Notifies the data source that the cell at indexPath has been deleted.
 *  Implementations of this method should remove the cell from the data source.
 *
 *  @param tableView The tableView requesting this information.
 *  @param indexPath      The index path that specifies the location of the cell.
 */
- (void)tableView:(ZHCMessagesTableView *)tableView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  Asks the data source for the message bubble image data that corresponds to the specified message data cell at indexPath in the tableView.
 *
 *  @param tableView The tableView requesting this information.
 *  @param indexPath      The index path that specifies the location of the cell.
 *
 *  @return An initialized object that conforms to the `ZHCMessageBubbleImageDataSource` protocol. You may return `nil` from this method if you do not
 *  want the specified cell to display a message bubble image.
 *
 *  @discussion It is recommended that you utilize `ZHCMessagesBubbleImageFactory` to return valid `ZHCMessagesBubbleImage` objects.
 *  However, you may provide your own data source object as long as it conforms to the `ZHCMessageBubbleImageDataSource` protocol.
 *
 *  @warning Note that providing your own bubble image data source objects may require additional
 *  configuration of the tableView layout object, specifically regarding its `messageBubbleTextViewFrameInsets` and `messageBubbleTextViewTextContainerInsets`.
 *
 *  @see ZHCMessagesBubbleImageFactory.
 *  @see ZHCMessagestableViewFlowLayout.
 */
- (nullable id<ZHCMessageBubbleImageDataSource>)tableView:(ZHCMessagesTableView *)tableView messageBubbleImageDataForCellAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the avatar image data that corresponds to the specified message data cell at indexPath in the tableView.
 *
 *  @param tableView The tableView requesting this information.
 *  @param indexPath      The index path that specifies the location of the cell.
 *
 *  @return A initialized object that conforms to the `ZHCMessageAvatarImageDataSource` protocol. You may return `nil` from this method if you do not want
 *  the specified cell to display an avatar.
 *
 *  @discussion It is recommended that you utilize `ZHCMessagesAvatarImageFactory` to return valid `ZHCMessagesAvatarImage` objects.
 *  However, you may provide your own data source object as long as it conforms to the `ZHCMessageAvatarImageDataSource` protocol.
 *
 *  @see ZHCMessagesAvatarImageFactory.
 *  @see ZHCMessagestableViewFlowLayout.
 */
- (nullable id<ZHCMessageAvatarImageDataSource>)tableView:(ZHCMessagesTableView *)tableView avatarImageDataForCellAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Ask the dataSource of the dequeueReusable cell
 *
 *  @param indexPath the indexpath
 *
 *  @return 'ZHCMessagesTableViewCell' object
 */
-(ZHCMessagesTableViewCell *)messageTableViewDequeueReusableCellWithIndexPath:(NSIndexPath *)indexPath;

@optional


/**
 *  Asks the delegate for the height of the `cellTopLabel` for the cell at the specified indexPath.
 *
 *  @param tableView       The tableView object displaying the flow layout.
 *  @param indexPath        The index path of the cell.
 *  @param cell             The cell.
 *  @return The height of the `cellTopLabel` for the cell at indexPath.
 *
 *  @see ZHCMessagestableViewCell.
 */
- (CGFloat)tableView:(ZHCMessagesTableView *)tableView heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  Asks the delegate for the height of the `messageBubbleTopLabel` for the cell at the specified indexPath.
 *
 *  @param tableView       The tableView object displaying the flow layout.
 *  @param indexPath       The index path of the cell.
 *
 *  @return The height of the `messageBubbleTopLabel` for the cell at indexPath.
 *
 *  @see ZHCMessagestableViewCell.
 */
- (CGFloat)tableView:(ZHCMessagesTableView *)tableView heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  Asks the delegate for the height of the `cellsSpaceLabel` for the cell at the specified indexPath.
 *
 *  @param tableView The tableView object displaying the flow layout.
 *  @param indexPath The index path of the cell.
 *
 *  @return The height of the `cellsSpaceLabel` for the cell at indexPath.
 */
-(CGFloat)tableView:(ZHCMessagesTableView *)tableView tableViewCellSeparatorHeightAtIndexpath:(NSIndexPath *)indexPath;

/**
 *  Asks the delegate for the height of the `cellBottomLabel` for the cell at the specified indexPath.
 *
 *  @param tableView       The tableView object displaying the flow layout.
 *  @param indexPath       The index path of the cell.
 *
 *  @return The height of the `cellBottomLabel` for the cell at indexPath.
 *
 *  @see ZHCMessagestableViewCell.
 */
- (CGFloat)tableView:(ZHCMessagesTableView *)tableView  heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;


/**
 *  Asks the data source for the text to display in the `cellTopLabel` for the specified
 *  message data cell at indexPath in the tableView.
 *
 *  @param tableView The tableView requesting this information.
 *  @param indexPath      The index path that specifies the location of the cell.
 *
 *  @return A configured attributed string or `nil` if you do not want text displayed for the cell at indexPath.
 *  Return an attributed string with `nil` attributes to use the default attributes.
 *
 *  @see ZHCMessagestableViewCell.
 */
- (NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the text to display in the `messageBubbleTopLabel` for the specified
 *  message data cell at indexPath in the tableView.
 *
 *  @param tableView The tableView requesting this information.
 *  @param indexPath      The index path that specifies the location of the cell.
 *
 *  @return A configured attributed string or `nil` if you do not want text displayed for the cell at indexPath.
 *  Return an attributed string with `nil` attributes to use the default attributes.
 *
 *  @see ZHCMessagestableViewCell.
 */
- (nullable NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Asks the data source for the text to display in the `cellBottomLabel` for the the specified
 *  message data cell at indexPath in the tableView.
 *
 *  @param tableView The tableView requesting this information.
 *  @param indexPath      The index path that specifies the location of the cell.
 *  @return A configured attributed string or `nil` if you do not want text displayed for the cell at indexPath.
 *  Return an attributed string with `nil` attributes to use the default attributes.
 *
 *  @see ZHCMessagestableViewCell.
 */
- (nullable NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath;



@end

NS_ASSUME_NONNULL_END