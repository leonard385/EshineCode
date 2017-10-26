
//
//  person.m
//  RunTimeDemo
//
//  Created by 倪望龙 on 2017/10/24.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import "person.h"
#import <objc/objc-class.h>
@interface person()
{
    NSNumber *size;
    NSString *hate;
    NSString *favor;
}
@end
@implementation person

-(void)getAllPropertys{
    unsigned int outCount = 0;
    objc_property_t *propertyLists = class_copyPropertyList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        objc_property_t property = propertyLists[i];
        const char *propertyName = property_getName(property);
        NSString *propertyString = [NSString stringWithUTF8String:propertyName];
        NSLog(@"property : %@",propertyString);
    }
}

-(void)getAllIvars{
    unsigned int outCount = 0;
    Ivar *vars = class_copyIvarList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        Ivar var = vars[i];
        const char *name = ivar_getName(var);
        NSString *nameStr = [NSString stringWithUTF8String:name];
        NSLog(@"Ivar : %@",nameStr);
    }
}

-(void)getAllMethods{
    unsigned int outCount = 0;
    Method *methods = class_copyMethodList([self class], &outCount);
    for (unsigned int i = 0;  i < outCount; i++) {
        Method method = methods[i];
        const char *methodName = sel_getName(method_getName(method));
        NSString *methodNameStr = [NSString stringWithUTF8String:methodName];
        NSLog(@"person Method Name: %@",methodNameStr);
    }
}

-(void)getPropertysAndAttribute{
    unsigned int outCount = 0;
    objc_property_t *propertyLists = class_copyPropertyList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        objc_property_t property = propertyLists[i];
        const char *propertyChar  = property_getName(property);
        NSString *propertyString = [NSString stringWithUTF8String:propertyChar];
        unsigned int attrOutCount = 0;
        objc_property_attribute_t *attributes = property_copyAttributeList(property, &attrOutCount);
        objc_property_attribute_t  attribute = attributes[0];
        if(attribute.value){//排除NULL的情况
            NSString *attributName = [NSString stringWithUTF8String:attribute.value];
            NSLog(@"%@ attribute : %@",propertyString,attributName);
        }
    }
}

-(void)printAllValue{
    unsigned int outCount = 0;
    objc_property_t *propertys = class_copyPropertyList([self class], &outCount);
    for (unsigned int i = 0; i < outCount; i++) {
        objc_property_t property = propertys[i];
        const char *propertyName = property_getName(property);
        NSString *propName = [NSString stringWithUTF8String:propertyName];
        SEL getPerSEL = sel_registerName(propertyName);
        if([self respondsToSelector:getPerSEL]){
            id value = ((id (*)(id,SEL))(void *)objc_msgSend)(self,getPerSEL);
            NSLog(@"%@ : %@",propName,value);
        }
    }
}



@end
