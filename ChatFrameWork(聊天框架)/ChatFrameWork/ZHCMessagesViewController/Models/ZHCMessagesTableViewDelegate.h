//
//  ZHCMessagesTableViewDelegate.h
//  ZHChat
//
//  Created by aimoke on 16/8/16.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ZHCMessagesTableView;
@class ZHCMessagesTableViewCell;

NS_ASSUME_NONNULL_BEGIN
@protocol ZHCMessagesTableViewDelegate <NSObject,UITableViewDelegate>


/**
 *  Notifies the delegate that the avatar image view at the specified indexPath did receive a tap event.
 *
 *  @param tableView  The tableView object that is notifying the delegate of the tap event.
 *  @param avatarImageView The avatar image view that was tapped.
 *  @param indexPath       The index path of the cell for which the avatar was tapped.
 */
- (void)tableView:(ZHCMessagesTableView *)tableView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the message bubble at the specified indexPath did receive a tap event.
 *
 *  @param tableView The tableView object that is notifying the delegate of the tap event.
 *  @param indexPath      The index path of the cell for which the message bubble was tapped.
 */
- (void)tableView:(ZHCMessagesTableView *)tableView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  Notifies the delegate that the cell at the specified indexPath did receive a tap event at the specified touchLocation.
 *
 *  @param tableView The tableView object that is notifying the delegate of the tap event.
 *  @param indexPath      The index path of the cell for which the message bubble was tapped.
 *  @param touchLocation  The location of the touch event in the cell's coordinate system.
 *
 *  @warning This method is *only* called if position is *not* within the bounds of the cell's
 *  avatar image view or message bubble image view. In other words, this method is *not* called when the cell's
 *  avatar or message bubble are tapped. There are separate delegate methods for these two cases.
 *
 *  @see `tableView:didTapAvatarImageView:atIndexPath:`
 *  @see `tableView:didTapMessageBubbleAtIndexPath:atIndexPath:`
 */
- (void)tableView:(ZHCMessagesTableView *)tableView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation;



/**
 *  Tells the delegate that an actions has been selected from the menu of this cell.
 *  This method is automatically called for any registered actions.
 *
 *  @param tableView The tableView that displayed the menu.
 *  @param action The action that has been performed.
 *  @param sender The object that initiated the action.
 *
 *  @see `ZHCMessagesTableView`
 */

- (void)tableView:(ZHCMessagesTableView *)tableView performAction:(SEL)action forcellAtIndexPath:(NSIndexPath *)indexPath withSender:(nullable id)sender;
@end
NS_ASSUME_NONNULL_END