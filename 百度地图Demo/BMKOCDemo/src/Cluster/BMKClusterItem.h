//
//  BMKClusterItem.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/9/15.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#ifndef BMKClusterItem_h
#define BMKClusterItem_h

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
/**
 * 表示一个标注
 */
@interface BMKClusterItem : NSObject

///经纬度，初始化后，不可修改
@property (nonatomic, assign) CLLocationCoordinate2D coor;

@end

/**
 * 聚合后的标注
 */
@interface BMKCluster : NSObject

///经纬度
@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
///所包含BMKClusterItem
@property (nonatomic, strong) NSMutableArray *clusterItems;
///包含BMKClusterItem个数
@property (nonatomic, readonly) NSUInteger size;

@end

#endif /* BMKClusterItem_h */
