//
//  CXSearchModel.m
//  搜索页面的封装
//
//  Created by 蔡翔 on 16/7/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "CXSearchModel.h"

#define FAST_DirectoryModel_SET_VALUE_FOR_STRING(dictname,value) dictionary[dictname]!= nil &&dictionary[dictname]!=[NSNull null]? dictionary[dictname] : value;


@implementation CXSearchModel

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.content_name = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"content_name", @"");
    }
    return self;
}

@end
