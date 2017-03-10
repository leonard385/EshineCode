//
//  NSString+PSPinyinFirst.m
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/30.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "NSString+PSPinyinFirst.h"

@implementation NSString (PSPinyinFirst)
// 获取字符串首字母
+ (NSString*)pinyinFirstLetter:(NSString*) hanzi {
    NSString *result = @"";
    NSMutableString *ms = [[NSMutableString alloc] initWithString:hanzi];
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
        //        NSLog(@"pinyin1: %@", ms);
    }
    if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)){
        //        NSLog(@"pinyin2: %@", ms);
    }
    if (ms.length>0) {
        result = [ms substringToIndex:1];
        //        NSLog(@"pinyin3: %@", result);
    }
    return [result uppercaseString];
}
@end
