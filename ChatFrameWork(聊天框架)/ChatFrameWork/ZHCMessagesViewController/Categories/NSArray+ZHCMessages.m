//
//  NSArray+ZHCMessages.m
//  ZHChat
//
//  Created by aimoke on 16/8/29.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "NSArray+ZHCMessages.h"
#import "NSBundle+ZHCMessages.h"


@implementation NSArray (ZHCMessages)


+(NSArray *)zhc_getEmojis
{
    NSBundle *bundle = [NSBundle zhc_getmessagesAssetBundle];
    NSAssert(bundle != Nil, @"MessagesBundle Can Not is Nil");
    NSString *path = [bundle pathForResource:@"ZHCEmojiList" ofType:@"plist" inDirectory:@"Emoji"];
    NSAssert(path != Nil, @"MessagesEmoji Path Can Not is Nil");
    return [NSArray arrayWithContentsOfFile:path];

}
@end
