//
//  NSObject+KeyValues.m
//  RunTimeDemo
//
//  Created by 倪望龙 on 2017/10/25.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import "NSObject+KeyValues.h"
#import <objc/objc-class.h>
@implementation NSObject (KeyValues)

/**
 *  单一键值对赋值
 *
 *  @param aDictionary 字典
 *
 *  @return 对象
 */
+(id)objectWithKeyValues:(NSDictionary *)aDictionary{
    id objc = [self new];
    for (NSString *key in aDictionary.allKeys) {
        id value = aDictionary[key];
        NSString *methodName = [NSString stringWithFormat:@"set%@%@:",[key substringToIndex:1].uppercaseString,[key substringFromIndex:1]];
        SEL selector = sel_registerName(methodName.UTF8String);
        if([objc respondsToSelector:selector]){
            ((void (*)(id,SEL,id))(void *)objc_msgSend)(objc,selector,value);
        }
    }
    return objc;
}

/**
 *  对象
 *
 *  @return 字典
 */
-(NSDictionary *)keyValuesWithObject{
    unsigned int outCount = 0;
    objc_property_t *propertyList = class_copyPropertyList([self class], &outCount);
    NSMutableDictionary *dic = [NSMutableDictionary new];
    for (unsigned int i = 0;i < outCount; i++) {
        objc_property_t property = propertyList[i];
        const char *name = property_getName(property);
        NSString *key = [NSString stringWithUTF8String:name];
        SEL getMethod = sel_registerName(name);
        if([self respondsToSelector:getMethod]){
            id value = ((id (*)(id,SEL))(void*)objc_msgSend)(self,getMethod);
            dic[key] = value;
        }
    }
    return dic;
}
@end
