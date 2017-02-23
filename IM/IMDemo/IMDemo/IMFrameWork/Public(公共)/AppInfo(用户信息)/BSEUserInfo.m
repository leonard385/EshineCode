//
//  BSEUserInfo.m
//  BSEM
//
//  Created by 逸信Mac on 16/3/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "BSEUserInfo.h"

@interface BSEUserInfo()

@end

@implementation BSEUserInfo
+(instancetype)shareMannager
{
    static BSEUserInfo *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[[self class]alloc]init];
    });
    return share;
}
-(instancetype)init{
    self =  [super init];
    if(self){
      
    }
    return self;
}

-(instancetype)initWithDic:(NSDictionary *)Dic{
    self =  [super init];
    if(self){
        [self setValuesForKeysWithDictionary:Dic];

    }
    return self;
}


@end
