//
//  IMClientManage.m
//  IMDemo
//
//  Created by 倪望龙 on 2017/2/22.
//  Copyright © 2017年 XunYiJia. All rights reserved.
//

#import "IMClientManage.h"

@implementation IMClientManage
+(instancetype)shareMannager
{
    static IMClientManage *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[[self class]alloc]initWithHost:@"192.168.0.17" port:61613];
    });
    return share;
}

@end
