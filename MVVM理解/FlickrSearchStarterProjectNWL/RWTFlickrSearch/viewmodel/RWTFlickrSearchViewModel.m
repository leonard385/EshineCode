//
//  RWTFlickrSearchViewModel.m
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import "RWTFlickrSearchViewModel.h"
#import "RWTSearchResultsViewModel.h"
#import "RWTSearchResultsViewController.h"

#import "RWTPreviousSearchViewModel.h"
#import <LinqToObjectiveC/NSArray+LinqExtensions.h>

@interface RWTFlickrSearchViewModel()
@property (nonatomic, weak) id<RWTViewModelServices> services;//ViewModel服务类
@property NSMutableArray *mutablePreviousSearches;//搜索记录
@end

@implementation RWTFlickrSearchViewModel

- (instancetype)initWithServices:(id<RWTViewModelServices>)services
{
    self = [super init];
    if (self)
    {
        _services = services;
        [self initialize];
    }
    return self;
}

#pragma mark -
- (void)initialize
{
    self.title = @"Flickr Search";
    self.mutablePreviousSearches = [NSMutableArray new];
    self.SearchHistory = [NSArray new];
    /*
     * go按键使能信号初始化 searchTextfiled 输入>3
     */
    RACSignal * validSearchSignal = [[RACObserve(self, searchText)
      map:^id(NSString *text) {
        return @(text.length >= 3);//条件输入字符大于三
    }]
     distinctUntilChanged];
    
  
    [validSearchSignal subscribeNext:^(id x)
     {
         NSLog(@"%s-----search text is valid %@",__func__,x);
     }];
    /*
      go按键  RACCommand 点击
     */
    self.executeSearch =
    [[RACCommand alloc]initWithEnabled:validSearchSignal signalBlock:^RACSignal *(id input) {
        //1.在这里执行业务逻辑操作
        //2.并通过信号异步返回结果
        return [self executeSearchSignal];
    }];
    
    /**
     *  错误处理
     * RACCommand类有一个errors属性，用于发送命令执行时产生的任何错误。
     */
    self.connectionErrors = self.executeSearch.errors;
}

#pragma mark - 执行搜索
- (RACSignal *)executeSearchSignal
{
    return [[[[self.services getFlickrSearchService] flickrSearchSignal:self.searchText]logAll]
            doNext:^(id result) {
                //添加记录
                 [self addToSearchHistory:result];
                //推入到结果VC
                RWTSearchResultsViewModel *resultsViewModel =
                [[RWTSearchResultsViewModel alloc] initWithSearchResults:result
                                                                services:self.services];//result界面下一个界面
                RWTSearchResultsViewController *resVC = [[RWTSearchResultsViewController alloc]initWithViewModel:resultsViewModel];
                [self.services pushViewModelVC:resVC];
               
    }];
}

#pragma mark - 添加到搜索历史记录
- (void)addToSearchHistory:(RWTFlickrSearchResults *)result {
    
    //便利最近搜索数组
    RWTPreviousSearchViewModel* match = [[self.SearchHistory linq_where:^BOOL(RWTPreviousSearchViewModel *x)
    {
        return x.searchString == result.searchString;
    }] linq_firstOrNil];
    //有相似项  ---> 替换
    if (match) {
        [self.mutablePreviousSearches removeObject:match];
        [self.mutablePreviousSearches insertObject:match atIndex:0];
    } else {//否则插入新的搜索数据
        RWTPreviousSearchViewModel *previousSearch = [RWTPreviousSearchViewModel new];
        previousSearch.searchString = result.searchString;
        previousSearch.totalResults = result.totalResults;
        previousSearch.thumbnail = [[result.photos firstObject] url];
        [self.mutablePreviousSearches insertObject:previousSearch atIndex:0];
    }
    //超出10条则删除最后一条
    if (self.mutablePreviousSearches.count > 10) {
        [self.mutablePreviousSearches removeLastObject];
    }
    
    self.SearchHistory = [NSArray arrayWithArray:self.mutablePreviousSearches];
}
@end
