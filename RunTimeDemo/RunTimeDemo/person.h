//
//  person.h
//  RunTimeDemo
//
//  Created by 倪望龙 on 2017/10/24.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSObject+KeyValues.h"
@interface person : NSObject
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSNumber *age;
@property(nonatomic,strong)NSNumber *sex;
@property(nonatomic,strong)NSNumber *height;
@property(nonatomic,strong)NSNumber *weight;

/**
 *  获取类所有变量
 */
-(void)getAllIvars;
/**
 *  获取类所有属性
 */
-(void)getAllPropertys;
/**
 *  获取类所有属性以及属性数据类型
 */
-(void)getPropertysAndAttribute;
/**
 *  获取类方法列表
 */
-(void)getAllMethods;

/**
 *  打印类的属性以及属性值
 */
-(void)printAllValue;
@end
