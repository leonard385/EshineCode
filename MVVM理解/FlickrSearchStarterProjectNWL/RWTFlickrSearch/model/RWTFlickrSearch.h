//
//  RWTFlickrSearch.h
//  RWTFlickrSearch
//
//  Created by 逸信Mac on 15/11/24.
//  Copyright © 2015年 Colin Eberhardt. All rights reserved.
//

@protocol RWTFlickrSearch <NSObject>

//暴露数据请求API接口
- (RACSignal *)flickrSearchSignal:(NSString *)searchString;
- (RACSignal *)flickrImageMetadata:(NSString *)photoId;
@end
