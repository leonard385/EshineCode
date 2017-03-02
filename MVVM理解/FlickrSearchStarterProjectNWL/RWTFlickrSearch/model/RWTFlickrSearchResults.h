//
//  RWTFlickrSearchResults.h
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RWTFlickrSearchResults : NSObject
@property (strong, nonatomic) NSString *searchString;//搜索字符
@property (strong, nonatomic) NSArray *photos;//结果
@property (nonatomic) NSInteger totalResults;//所有搜索匹配项数目
@end
