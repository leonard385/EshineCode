//
//  BMKClusterManager.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/9/15.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "BMKClusterManager.h"

@interface BMKClusterManager () {
    BMKClusterAlgorithm *_algorithm;
}

@end

@implementation BMKClusterManager

- (id)init {
    self = [super init];
    if (self) {
        _algorithm = [[BMKClusterAlgorithm alloc] init];
    }
    return self;
}

///添加item
- (void)addClusterItem:(BMKClusterItem*)clusterItem {
    @synchronized(_algorithm) {
        [_algorithm addItem:clusterItem];
    }
}

///清除items
- (void)clearClusterItems {
    @synchronized(_algorithm) {
        [_algorithm clearItems];
    }
}

/**
 * 获取聚合后的标注
 * @param zoomLevel map的级别
 * @return BMKCluster数组
 */
- (NSArray*)getClusters:(CGFloat) zoomLevel {
    return [_algorithm getClusters:zoomLevel];
}

@end