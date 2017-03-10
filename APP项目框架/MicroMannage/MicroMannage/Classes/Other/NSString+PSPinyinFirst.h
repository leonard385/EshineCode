//
//  NSString+PSPinyinFirst.h
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/30.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PSPinyinFirst)
//汉字拼音首字母
+ (NSString*)pinyinFirstLetter:(NSString*) hanzi;
@end
