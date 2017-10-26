//
//  BMKClusterQuadtree.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/9/15.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#ifndef BMKClusterQuadtree_h
#define BMKClusterQuadtree_h

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import "BMKClusterItem.h"

@interface BMKQuadItem : NSObject

@property (nonatomic, readonly) CGPoint pt;
@property (nonatomic, strong) BMKClusterItem *clusterItem;

@end

@interface BMKClusterQuadtree : NSObject

///四叉树区域
@property (nonatomic, assign) CGRect rect;
///所包含BMKQuadItem
@property(nonatomic, readonly) NSMutableArray *quadItems;

- (id)initWithRect:(CGRect) rect;

///添加item
- (void)addItem:(BMKQuadItem*) quadItem;

///清除items
- (void)clearItems;

///获取rect范围内的BMKQuadItem
- (NSArray*)searchInRect:(CGRect) searchRect;

@end

#endif /* BMKClusterQuadtree_h */
