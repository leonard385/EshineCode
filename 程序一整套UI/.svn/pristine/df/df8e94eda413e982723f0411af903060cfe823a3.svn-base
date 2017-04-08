//
//  MMSImageUploadModel.m
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/27.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "MMSImageUploadModel.h"

@implementation MMSImageUploadModel
-(instancetype)init{
    self = [super init];
    if(self ){
        _isCommit = @(NO);//初始值为0
    }
    return self;
}

-(instancetype)initWithDic:(NSDictionary *)Dic{
    self =  [super init];
    if(self){
        [self setValuesForKeysWithDictionary:Dic];
        _isCommit = @(YES);
    }
    return self;
}

-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"]){
       _ImageID = value;
    }
    if([key isEqualToString:@"patch_url"]){
        _PhotoUrl = value;
    }
}

-(void)setNilValueForKey:(NSString *)key
{
    
}
@end
