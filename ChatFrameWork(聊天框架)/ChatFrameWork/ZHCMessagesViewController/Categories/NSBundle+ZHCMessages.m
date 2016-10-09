//
//  NSBundle+ZHCMessages.m
//  ZHChat
//
//  Created by aimoke on 16/8/8.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "NSBundle+ZHCMessages.h"
#import "ZHCMessagesViewController.h"

@implementation NSBundle (ZHCMessages)

+ (NSBundle *)zhc_messagesBundle
{
    return [NSBundle bundleForClass:[ZHCMessagesViewController class]];
}


+ (NSBundle *)zhc_getmessagesAssetBundle
{
    NSString *bundlePath = [NSBundle zhc_messagesBundle].resourcePath;
    NSString *assetsPath = [bundlePath stringByAppendingPathComponent:@"ZHCMessagesAssets.bundle"];
    return [NSBundle bundleWithPath:assetsPath];
}


+ (NSString *)zhc_localizedStringForKey:(NSString *)key
{
    return NSLocalizedStringFromTableInBundle(key, @"ZHCMessages", [NSBundle zhc_getmessagesAssetBundle], nil);
}



@end
