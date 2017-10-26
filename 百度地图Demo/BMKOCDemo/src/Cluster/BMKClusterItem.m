//
//  BMKClusterItem.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/9/15.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "BMKClusterItem.h"

@implementation BMKClusterItem

@synthesize coor = _coor;

@end

@implementation BMKCluster

@synthesize coordinate = _coordinate;
@synthesize clusterItems = _clusterItems;

- (id)init {
    self = [super init];
    if (self) {
        _clusterItems = [[NSMutableArray alloc] init];
    }
    return self;
}

- (NSUInteger)size {
    return _clusterItems.count;
}

@end