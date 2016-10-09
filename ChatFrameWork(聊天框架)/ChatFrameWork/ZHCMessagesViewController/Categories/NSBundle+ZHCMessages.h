//
//  NSBundle+ZHCMessages.h
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN
@interface NSBundle (ZHCMessages)

/**
 *  get bundle from ZHCMessagesViewController
 *
 *  @return Bundle
 */
+(NSBundle *)zhc_messagesBundle;

/**
 *  get bundle for Assets from ZHCMessagesViewController
 *
 *  @return
 */
+(NSBundle *)zhc_getmessagesAssetBundle;





/**
 *  Returns a localized version of the string designated by the specified key and residing in the ZHCMessages table.
 *
 *  @param key The key for a string in the ZHCMessages table.
 *
 *  @return A localized version of the string designated by key in the ZHCMessages table.
 */
+ (nullable NSString *)zhc_localizedStringForKey:(NSString *)key;

@end
NS_ASSUME_NONNULL_END