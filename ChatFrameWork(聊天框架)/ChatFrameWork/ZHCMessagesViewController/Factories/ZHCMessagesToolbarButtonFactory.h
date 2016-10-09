//
//  ZHCMessagesToolbarButtonFactory.h
//  ZHChat
//
//  Created by aimoke on 16/8/19.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 *  `ZHCMessagesToolbarButtonFactory` is a factory that provides a means for creating the default
 *  toolbar button items to be displayed in the content view of a `ZHCMessagesInputToolbar`.
 */
@interface ZHCMessagesToolbarButtonFactory : NSObject

/**
 *  Creates and returns a new instance of `ZHCMessagesToolbarButtonFactory` that uses
 *  the default font for creating buttons.
 *
 *  @return An initialized `ZHCMessagesToolbarButtonFactory` object.
 */
- (instancetype)init;

/**
 *  Creates and returns a new instance of `ZHCMessagesToolbarButtonFactory` that uses
 *  the specified font for creating buttons.
 *
 *  @param A font that will be used for the buttons produced by the factory.
 *
 *  @return An initialized `ZHCMessagesToolbarButtonFactory` object.
 */
- (instancetype)initWithFont:(UIFont *)font NS_DESIGNATED_INITIALIZER;


/**
 *  Creates and returns a new button that is styled as the default send button.
 *  The button has title text `@"Send"` and no image.
 *
 *  @return A newly created button.
 */
- (UIButton *)defaultSendButtonItem;




/**
 *  Creates and returns a new button that is styled as the default Left button.
 *  The button has a paper clip icon image and no text.
 *  @return A newly created button.
 */
-(UIButton *)defaultInputViewBarLeftButtonItem;


/**
 *  Creates and returns a new button that is styled as the default Right button.
 *  The button has a paper clip icon image and no text.
 *  @return A newly created button.
 */
-(UIButton *)defaultInputViewBarRightButtonItem;


/**
 *  Creates and returns a new button that is styled as the default Middel button.
 *  The button has a paper clip icon image and no text.
 *  @return A newly created button.
 */
-(UIButton *)defaultInputViewBarMiddelButtonItem;

/**
 *  Creates and returns a new button that is styled as the default LongPress button.
 *  The button has a paper clip icon image and no text.
 *  @return A newly created button.
 */
-(UIButton *)defaultInputViewVoiceLongPressButtonItem;

@end
NS_ASSUME_NONNULL_END