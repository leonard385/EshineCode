//
//  CXSearchSectionModel.m
//  搜索页面的封装
//
//  Created by 蔡翔 on 16/7/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "CXSearchSectionModel.h"
#import "CXSearchModel.h"

#define FAST_DirectoryModel_SET_VALUE_FOR_STRING(dictname,value) dictionary[dictname]!= nil &&dictionary[dictname]!=[NSNull null]? dictionary[dictname] : value;
@interface CXSearchSectionModel()
@property (nonatomic, strong)NSMutableArray *content_Array;
@end

@implementation CXSearchSectionModel

-(NSMutableArray *)content_Array
{
    if (_content_Array == nil) {
        _content_Array = [NSMutableArray array];
    }
    return _content_Array;
}


- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.section_id = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"section_id", @"0");
        self.section_title = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"section_title", @"");
        NSArray *emp = FAST_DirectoryModel_SET_VALUE_FOR_STRING(@"section_content",@[]);
        if (emp.count > 0) {
            for (NSDictionary *content_dict in emp) {
                CXSearchModel *model = [[CXSearchModel alloc] initWithDictionary:content_dict];
                [self.content_Array addObject:model];
            }
            self.section_contentArray = self.content_Array;
        }
    }
    return self;
}


@end
