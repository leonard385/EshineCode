//
//  ZHCMessagesComposerTextView.h
//  ZHChat
//
//  Created by aimoke on 16/8/19.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZHCMessagesComposerTextView;
NS_ASSUME_NONNULL_BEGIN
/**
 *  A delegate object used to notify the receiver of paste events from a `ZHCMessagesComposerTextView`.
 */
@protocol ZHCMessagesComposerTextViewPasteDelegate <NSObject>

/**
 *  Asks the delegate whether or not the `textView` should use the original implementation of `-[UITextView paste]`.
 *
 *  @discussion Use this delegate method to implement custom pasting behavior.
 *  You should return `NO` when you want to handle pasting.
 *  Return `YES` to defer functionality to the `textView`.
 */
- (BOOL)composerTextView:(ZHCMessagesComposerTextView *)textView shouldPasteWithSender:(id)sender;

@end

/**
 *  An instance of `ZHCMessagesComposerTextView` is a subclass of `UITextView` that is styled and used
 *  for composing messages in a `ZHCMessagesViewController`. It is a subview of a `ZHCMessagesToolbarContentView`.
 */
@interface ZHCMessagesComposerTextView : UITextView


/**
 *  The text to be displayed when the text view is empty. The default value is `nil`.
 */
@property (copy, nonatomic, nullable) NSString *placeHolder;

/**
 *  The color of the place holder text. The default value is `[UIColor lightGrayColor]`.
 */
@property (strong, nonatomic) UIColor *placeHolderTextColor;

/**
 *  The object that acts as the paste delegate of the text view.
 */
@property (weak, nonatomic, nullable) id<ZHCMessagesComposerTextViewPasteDelegate> pasteDelegate;


/**
 *  Determines whether or not the text view contains text after trimming white space
 *  from the front and back of its string.
 *
 *  @return `YES` if the text view contains text, `NO` otherwise.
 */
- (BOOL)hasText;

@end
NS_ASSUME_NONNULL_END