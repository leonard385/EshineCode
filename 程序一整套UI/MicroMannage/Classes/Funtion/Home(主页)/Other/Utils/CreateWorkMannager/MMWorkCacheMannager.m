//
//  MMWorkCreateMannager.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/21.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkCacheMannager.h"
@interface MMWorkCacheMannager()

@end

@implementation MMWorkCacheMannager
+(instancetype)shareMannager
{
    static MMWorkCacheMannager *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[[self class]alloc]init];
    });
    return share;
}

-(void)save{
 
}

-(instancetype)load{
    return self;
}


@end
