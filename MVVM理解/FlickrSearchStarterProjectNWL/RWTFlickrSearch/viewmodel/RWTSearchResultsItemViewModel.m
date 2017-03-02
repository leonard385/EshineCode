//
//  RWTSearchResultsItemViewModel.m
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import "RWTSearchResultsItemViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import <ReactiveCocoa/RACEXTScope.h>
#import "RWTFlickrPhotoMetadata.h"

@interface RWTSearchResultsItemViewModel ()

@property (weak, nonatomic) id<RWTViewModelServices> services;

@property (strong, nonatomic) RWTFlickrPhoto *photo;

@end

@implementation RWTSearchResultsItemViewModel

- (instancetype)initWithPhoto:(RWTFlickrPhoto *)photo services:(id<RWTViewModelServices>)services {
    self = [super init];
    if (self) {
        _title = photo.title;//标题
        _url = photo.url;//url连接
        _photo = photo;
        _services = services;
        
        [self SRRacInit];
    }
    return  self;
}

- (void)SRRacInit {
    // 1. 通过监听isVisible属性来创建信号。该信号发出的第一个next事件将包含这个属性的初始状态。
    // 因为我们只关心这个值的改变，所以在第一个事件上调用skip操作。
    RACSignal *visibleStateChanged = [RACObserve(self, isVisible) skip:1];
    
    // 2. 通过过滤visibleStateChanged信号来创建一个信号对，一个标识从可见到隐藏的转换，另一个标识从隐藏到可见的转换
    RACSignal *visibleSignal = [visibleStateChanged
                                filter:^BOOL(NSNumber *value) {
        return [value boolValue];
    }];
    
    RACSignal *hiddenSignal = [visibleStateChanged
                               filter:^BOOL(NSNumber *value) {
        return ![value boolValue];
    }];
    
    // 3. 这里是最神奇的地方。通过延迟visibleSignal信号1秒钟来创建fetchMetadata信号，在获取元数据之前暂停一会。
    // takeUntil操作确保如果cell在1秒的时间间隔内又一次隐藏时，来自visibleSignal的next事件被挂起 且不获取元数据(cell数据)。
    RACSignal *fetchMetadata = [[visibleSignal delay:1.0f]
                                takeUntil:hiddenSignal];
    
    @weakify(self)
    [fetchMetadata subscribeNext:^(id x) {
        @strongify(self)
        [[[self.services getFlickrSearchService] flickrImageMetadata:self.photo.identifier]
         subscribeNext:^(RWTFlickrPhotoMetadata *data) {
             self.favorites = @(data.favorites);
             self.comments = @(data.comments);
         }];
    }];
}

@end
