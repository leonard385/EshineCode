//
//  CXSearchSectionModel.h
//  搜索页面的封装
//
//  Created by 蔡翔 on 16/7/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CXSearchSectionModel : NSObject

@property (nonatomic, copy) NSString *section_id;
@property (nonatomic, copy) NSString *section_title;
@property (nonatomic, copy) NSArray *section_contentArray;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
