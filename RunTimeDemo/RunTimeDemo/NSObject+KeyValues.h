//
//  NSObject+KeyValues.h
//  RunTimeDemo
//
//  Created by 倪望龙 on 2017/10/25.
//  Copyright © 2017年 jzg. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (KeyValues)
+(id)objectWithKeyValues:(NSDictionary *)aDictionary;
-(NSDictionary *)keyValuesWithObject;
@end
