//
//  ZHCMessagesTableView.h
//  ZHChat
//
//  Created by aimoke on 16/8/11.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZHCMessagesTableViewDataSource.h"
#import "ZHCMessagesTableViewDelegate.h"
#import "ZHCMessagesTableViewCell.h"
#import "ZHCMessagesTableviewLayoutAttributes.h"



NS_ASSUME_NONNULL_BEGIN
@interface ZHCMessagesTableView : UITableView<ZHCMessagesTableViewCellDelegate>

/**
 *  The object that provides the data for the tableView.
 *  The data source must adopt the `ZHCMessagesTableViewDataSource` protocol.
 */
@property (weak, nonatomic, nullable) id<ZHCMessagesTableViewDataSource> dataSource;

/**
 *  The object that acts as the delegate of the tableView.
 *  The delegate must adopt the `ZHCMessagesTableViewDelegate` protocol.
 */
@property (weak, nonatomic, nullable) id<ZHCMessagesTableViewDelegate> delegate;


/**
 *  The layout used to organize the tableView’s cells.
 */
@property (strong, nonatomic) ZHCMessagesTableviewLayoutAttributes *tableViewLayout;

-(ZHCMessagesTableViewCell *)messageTableViewDequeueReusableCellWithIndexPath:(NSIndexPath *)indexPath;
@end
NS_ASSUME_NONNULL_END