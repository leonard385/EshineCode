//
//  RWTFlickrSearchViewModel.h
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RWTViewModelServices.h"

@interface RWTFlickrSearchViewModel : NSObject
@property (nonatomic, strong) NSString   *title;//VC标题
@property (nonatomic, strong) NSString   *searchText;//搜索字符
@property (strong, nonatomic) RACCommand *executeSearch;//go button的使能
@property (strong, nonatomic) NSArray *SearchHistory;//搜索历史

@property (strong, nonatomic) RACSignal  *connectionErrors;//连接错误
- (instancetype)initWithServices:(id<RWTViewModelServices>)service;//数据逻辑层
@end
