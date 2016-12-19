//
//  NSMutableDictionary+URLScheme.h
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 2016/12/12.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (URLScheme)

/**
 *  截取URL中的参数
 *
 *  @return NSMutableDictionary parameters
 */
+(NSMutableDictionary *)getURLParameters:(NSString *)urlStr;

@end
