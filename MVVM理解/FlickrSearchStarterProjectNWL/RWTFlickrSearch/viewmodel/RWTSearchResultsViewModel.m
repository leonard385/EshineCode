//
//  RWTSearchResultsViewModel.m
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsViewModel.h"
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>
#import "RWTSearchResultsItemViewModel.h"

@implementation RWTSearchResultsViewModel
- (instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results//结果
                             services:(id<RWTViewModelServices>)services//ViewModel处理相关类
{
    if (self = [super init]) {
        
        _title = results.searchString;
        
        //tableViewCell ViewModel初始化
        _searchResults =
        [results.photos linq_select:^id(RWTFlickrPhoto *photo) {
            return [[RWTSearchResultsItemViewModel alloc]
                    initWithPhoto:photo services:services];
        }];
    }

    return self;
}
@end
