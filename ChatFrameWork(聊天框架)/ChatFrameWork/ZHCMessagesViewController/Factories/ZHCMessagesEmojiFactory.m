//
//  ZHCEmojiFactory.m
//  ZHChat
//
//  Created by aimoke on 16/8/29.
//  Copyright © 2016年 zhuo. All rights reserved.
//


#define EMOJI_CODE_TO_SYMBOL(x) ((((0x808080F0 | (x & 0x3F000) >> 4) | (x & 0xFC0) << 10) | (x & 0x1C0000) << 18) | (x & 0x3F) << 24);

#import "ZHCMessagesEmojiFactory.h"

@implementation ZHCMessagesEmojiFactory

+(NSArray *)zhc_getDefaultEmotions
{
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0x1f600; i<=0x1f64F; i++) {
        if (i < 0xf641 || i > 0x1F644) {
            int sym = EMOJI_CODE_TO_SYMBOL(i);
            NSString *emotion = [[NSString alloc]initWithBytes:&sym length:sizeof(sym) encoding:NSUTF8StringEncoding];
            [array addObject:emotion];
        }
    }
    return array;
}



@end
