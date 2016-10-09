//
//  ZHCMessagesBubbleCalculator.h
//  ZHChat
//
//  Created by aimoke on 16/8/11.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "ZHCMessageData.h"
#import "ZHCMessagesTableView.h"



@interface ZHCMessagesBubbleCalculator : NSObject
/**
 *   ZHCMessagesBubbleCalculator factory
 *
 *  @return ZHCMessagesBubbleCalculator instance
 */
//+(instancetype)shareZHCMessagesBubbleCalculator;

/**
 *  Computes and returns the size of the `messageBubbleImageView` property
 *  of a `ZHCMessagesTableViewCell` for the specified messageData at indexPath.
 *
 *  @param messageData A message data object.
 *  @param indexPath   The index path at which messageData is located.
 *  @param tableView      The tableView object asking for this information.
 *
 *  @return A sizes that specifies the required dimensions to display the entire message contents.
 *  Note, this is *not* the entire cell, but only its message bubble.
 */
- (CGSize)messageBubbleSizeForMessageData:(id<ZHCMessageData>)messageData
                              atIndexPath:(NSIndexPath *)indexPath withTableView:(ZHCMessagesTableView *)tableView;

/**
 *  Notifies the receiver that the layout will be reset.
 *  Use this method to clear any cached layout information, if necessary.
 *
 *  @param tableView The tableView object notifying the receiver.
 */
- (void)prepareForResettingLayoutWithTableView:(ZHCMessagesTableView *)tableView;

@end
