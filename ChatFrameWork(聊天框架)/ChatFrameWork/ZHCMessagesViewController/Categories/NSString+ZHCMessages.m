//
//  NSString+ZHCMessages.m
//  ZHChat
//
//  Created by aimoke on 16/8/19.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "NSString+ZHCMessages.h"

@implementation NSString (ZHCMessages)

- (NSString *)zhc_stringByTrimingWhitespace
{
    return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}


@end
