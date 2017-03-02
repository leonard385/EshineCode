//
//  RWTSearchResultsItemViewModel.h
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//
@import Foundation;
#import "RWTFlickrPhoto.h"
#import "RWTViewModelServices.h"

@interface RWTSearchResultsItemViewModel : NSObject
@property (nonatomic) BOOL isVisible;
@property (strong, nonatomic) NSString *title; //图片标题
@property (strong, nonatomic) NSURL *url; //图片url数据
@property (strong, nonatomic) NSNumber *favorites;//喜欢
@property (strong, nonatomic) NSNumber *comments;//评论

- (instancetype) initWithPhoto:(RWTFlickrPhoto *)photo services:(id<RWTViewModelServices>)services;

@end
