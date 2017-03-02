//
//  RWTViewModelServicesImpl.m
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import "RWTViewModelServicesImpl.h"
#import "RWTFlickrSearchImpl.h"

#import "RWTSearchResultsViewController.h"
@interface RWTViewModelServicesImpl ()
@property (strong, nonatomic) RWTFlickrSearchImpl *searchService;//数据逻辑实现类
//@property (strong, nonatomic) RWTLookUpImpl * lookUpService;//数据逻辑实现2
@property (weak, nonatomic) UINavigationController *navigationController;//naigationController导航控制器这里的导航控制器是根导航控制器
@end

@implementation RWTViewModelServicesImpl

#pragma mark - 初始化赋值navigation
- (instancetype)initWithNavigationController:(UINavigationController *)navigationController {
    if (self = [super init]) {
        _searchService = [RWTFlickrSearchImpl new];//service 数据逻辑
        _navigationController = navigationController;//navgation
    }
    return self;
}

#pragma mark - 获取数据逻辑类服务
- (id<RWTFlickrSearch>)getFlickrSearchService
{
    return self.searchService;
}

#pragma mark - 推入视图
- (void)pushViewModelVC:(UIViewController *)viewController{
    [self.navigationController pushViewController:viewController animated:YES];
}
@end
