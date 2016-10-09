//
//  ZHCMessagesMoreView.h
//  ZHChat
//
//  Created by aimoke on 16/8/26.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCMessagesMoreView;


NS_ASSUME_NONNULL_BEGIN


@protocol ZHCMessagesMoreViewDelegate <NSObject>
@optional

/**
 *  Tells the delegate that the MoreViewItem has been tapped.
 *
 *  @param moreView The moreView
 *  @param index    The moreViewItem Index
 */
-(void)messagesMoreView:(ZHCMessagesMoreView *)moreView selectedMoreViewItemWithIndex:(NSInteger)index;
@end

@protocol ZHCMessagesMoreViewDataSource <NSObject>

@required
-(NSArray *)messagesMoreViewTitles:(ZHCMessagesMoreView *)moreView;
-(NSArray *)messagesMoreViewImgNames:(ZHCMessagesMoreView *)moreView;

@end

@interface ZHCMessagesMoreView : UIView

@property (weak, nonatomic) id<ZHCMessagesMoreViewDelegate> delegate;
@property (weak, nonatomic) id<ZHCMessagesMoreViewDataSource> dataSource;
@property (assign, nonatomic) NSInteger numberItemPerLine;
@property (assign, nonatomic) UIEdgeInsets edgeInsets;

-(void)reloadData;
@end
NS_ASSUME_NONNULL_END
