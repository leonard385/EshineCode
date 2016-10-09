//
//  UIImage+ZHCMessages.h
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (ZHCMessages)

/**
 *  Creates and returns a new image object that is masked with the specified mask color.
 *
 *  @param maskColor The color value for the mask. This value must not be `nil`.
 *
 *  @return A new image object masked with the specified color.
 */
- (UIImage *)zhc_imageMaskedWithColor:(UIColor *)maskColor;


/**
 *  @return The compact message bubble image.
 *
 *  @discussion This is the default bubble image used by `ZHCMessagesBubbleImageFactory`.
 */
+ (UIImage *)zhc_getBubbleCommpactImage;

/**
 *  @return The default typing indicator image.
 */
+ (UIImage *)zhc_defaultTypingIndicatorImage;

/**
 *  @return The default play icon image.
 */
+ (UIImage *)zhc_defaultPlayImage;

/**
 *  @return The default pause icon image.
 */
+ (UIImage *)zhc_defaultPauseImage;

/**
 *  @return The default Emotion delete image.
 */
+ (UIImage *)zhc_defaultEmptionDeleteImage;


/**
 *  @return The default input toolbar Emotion image.
 */
+(UIImage *)zhc_defaultEmotionImage;

/**
 *  @return The highlighted input toolbar Emotion image.
 */
+(UIImage *)zhc_highlightedEmotionImage;

/**
 *  @return The default input toolbar Voice image.
 */
+(UIImage *)zhc_defaultVoiceImage;


/**
 *  @return The default input toolbar Keyboard image.
 */
+(UIImage *)zhc_defaultKeyboardImage;

/**
 *  @return The highlighted input toolbar Keyboard image.
 */
+(UIImage *)zhc_highlightedKeyboardImage;

/**
 *  @return The default input toolbar More image.
 */
+(UIImage *)zhc_defaultMoreImage;

/**
 *  @return The default input toolbar LongPress image.
 */
+(UIImage *)zhc_defaultLongPressVoiceImage;


/**
 *  @return The highlighted input toolbar LongPress image.
 */
+(UIImage *)zhc_highlightedPressVoiceImage;


/**
 *  @return The specified image .
 */
+(UIImage *)zhc_getImageWithImageName:(NSString *)imgName;

@end
