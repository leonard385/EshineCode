//
//  NSString+ZHCMessages.h
//  ZHChat
//
//  Created by aimoke on 16/8/19.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface NSString (ZHCMessages)

/**
 *  @return A copy of the receiver with all leading and trailing whitespace removed.
 */
- (NSString *)zhc_stringByTrimingWhitespace;


@end
NS_ASSUME_NONNULL_END