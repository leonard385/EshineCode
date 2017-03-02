//
//  RWTSearchResultsViewModel.h
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

@import Foundation;
#import "RWTViewModelServices.h"

#import "RWTFlickrSearchResults.h"

@interface RWTSearchResultsViewModel : NSObject

- (instancetype)initWithSearchResults:(RWTFlickrSearchResults *)results services:(id<RWTViewModelServices>)services;//搜索值  视图实例

@property (strong, nonatomic) NSString *title;//搜索标题
@property (strong, nonatomic) NSArray *searchResults;//搜索结果里面存放模型

@end
