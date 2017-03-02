//
//  RWTPreviousSearchViewModel.h
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/25.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTPreviousSearchViewModel : NSObject
@property (strong, nonatomic) NSString *searchString;//搜索字符
@property (nonatomic) NSUInteger totalResults; //搜索匹配项
@property (strong, nonatomic) NSURL *thumbnail;//图标
@end
