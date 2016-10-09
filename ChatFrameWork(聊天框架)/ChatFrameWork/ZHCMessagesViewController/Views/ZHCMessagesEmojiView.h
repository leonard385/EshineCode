//
//  ZHCMessagesEmojiView.h
//  ZHChat
//
//  Created by aimoke on 16/8/29.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCMessagesEmojiView;

/**
 *  ZHCMessagesEmojiView Delegate
 *
 *  Used to respond to some of the operations callback
 */
@protocol ZHCEmojiViewDelegate <NSObject>

/**
 *  When you choose a Emoji
 *
 *  @param emojiView The emoji keyboard view
 *  @param emoji     The selected emoji character
 */
-(void)emojiView:(ZHCMessagesEmojiView *)emojiView didSelectEmoji:(NSString *)emoji;

/**
 *  When the touch bottom right corner of the delete key
 *
 *  You should remove the last character(emoji) in the text box
 *  @param emojiView    The emoji keyboard view
 *  @param deletebutton The delete button
 */
-(void)emojiView:(ZHCMessagesEmojiView *)emojiView didPressDeleteButton:(UIButton *)deletebutton;


/**
 *  When you click press Button in Emoji View.
 *
 *  @param emojiView  The emoji keyboard View
 *  @param sendButton The send Button.
 */
-(void)emojiView:(ZHCMessagesEmojiView *)emojiView didPressSendButton:(UIButton *)sendButton;

@end




@interface ZHCMessagesEmojiView : UIView

/**
 *  The delegate of 'ZHCMessagesEmojiView' instance.
 */
@property (nonatomic, weak) id<ZHCEmojiViewDelegate> delegate;

/**
 *  Emoji container used to store all the elements
 */
@property (nonatomic, strong) UIScrollView *scrollView;

/**
 *  UIPageControl for next page
 */
@property (nonatomic, strong) UIPageControl *pageControl;


/**
 *  Bottom View.
 */
@property (nonatomic, strong) UIView *bottomView;

/**
 *  Send Button.
 */
@property (weak, nonatomic) UIButton *sendButton;


-(void)reloadData;

@end

/**
 *  The Delete Button
 *
 *  You do not care about it
 */
@interface ZHCEmojiDeleteButton : UIButton

@end
