//
//  BMKClusterQuadtree.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/9/15.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "BMKClusterQuadtree.h"


#define MAX_POINTS_PER_NODE 40

@implementation BMKQuadItem

@synthesize pt = _pt;
@synthesize clusterItem = _clusterItem;

- (void)setClusterItem:(BMKClusterItem *)clusterItem {
    _clusterItem = clusterItem;
    _pt = [self convertCoordinateToPoint:clusterItem.coor];
}

- (CGPoint)convertCoordinateToPoint:(CLLocationCoordinate2D) coor {
    /*
     final double x = latLng.longitude / 360 + .5;
     final double siny = Math.sin(Math.toRadians(latLng.latitude));
     final double y = 0.5 * Math.log((1 + siny) / (1 - siny)) / -(2 * Math.PI) + .5;
     
     return new Point(x * mWorldWidth, y * mWorldWidth);
     */
    CGFloat x = coor.longitude / 360.f + 0.5;
    CGFloat siny = sin(coor.latitude * M_PI / 180.f);
    CGFloat y = 0.5 * log((1 + siny) / (1 - siny)) / -(2 * M_PI) + 0.5;
    return CGPointMake(x, y);
}

@end

@interface BMKClusterQuadtree () {
    NSMutableArray *_childrens;
}

@end

@implementation BMKClusterQuadtree

@synthesize rect = _rect;

- (id)init {
    self = [super init];
    if (self){
        _quadItems = [[NSMutableArray alloc] initWithCapacity:MAX_POINTS_PER_NODE];
    }
    return self;
}

- (id)initWithRect:(CGRect) rect {
    self = [super init];
    if (self) {
        _quadItems = [[NSMutableArray alloc] initWithCapacity:MAX_POINTS_PER_NODE];
        _rect = rect;
    }
    return self;
}

//四叉树拆分
- (void)subdivide {
    _childrens = [[NSMutableArray alloc] initWithCapacity:4];
    CGFloat x = _rect.origin.x;
    CGFloat y = _rect.origin.y;
    CGFloat w = _rect.size.width / 2.f;
    CGFloat h = _rect.size.height / 2.f;
    [_childrens addObject:[[BMKClusterQuadtree alloc] initWithRect:CGRectMake(x, y, w, h)]];
    [_childrens addObject:[[BMKClusterQuadtree alloc] initWithRect:CGRectMake(x + w, y, w, h)]];
    [_childrens addObject:[[BMKClusterQuadtree alloc] initWithRect:CGRectMake(x, y + h, w, h)]];
    [_childrens addObject:[[BMKClusterQuadtree alloc] initWithRect:CGRectMake(x + w, y + h, w, h)]];
}

//数据插入
- (void)addItem:(BMKQuadItem *)quadItem {
    if (quadItem == nil) {
        return ;
    }
    if ([self rect:_rect containsPt:quadItem.pt] == NO) {
        return;
    }
    
    if(_quadItems.count < MAX_POINTS_PER_NODE) {
        [_quadItems addObject:quadItem];
        return ;
    }
    
    if(_childrens == nil || _childrens.count == 0) {
        [self subdivide];
    }
    for (BMKClusterQuadtree *children in _childrens) {
        [children addItem:quadItem];
    }
}

- (void)clearItems {
    _childrens = nil;
    if (_quadItems) {
        [_quadItems removeAllObjects];
    }
}

///获取rect范围内的BMKQuadItem
- (NSArray*)searchInRect:(CGRect) searchRect {
    //searchrect和四叉树区域rect无交集
    if ([self isRect:searchRect intersectsWith:_rect] == NO) {
        return [NSArray array];
    }
    
    NSMutableArray *array = [NSMutableArray array];
    
    //searchrect包含四叉树区域
    if ([self rect:searchRect containsRect:_rect]) {
        [array addObjectsFromArray:_quadItems];
    } else {
        for (BMKQuadItem *item in _quadItems) {
            if ([self rect:searchRect containsPt:item.pt]) {
                [array addObject:item];
            }
        }
    }
    
    if(_childrens != nil && _childrens.count == 4) {
        for (BMKClusterQuadtree *children in _childrens) {
            [array addObjectsFromArray:[children searchInRect:searchRect]];
        }
    }
    
    return array;
}

//rect是否包含pt
- (BOOL)rect:(CGRect) rect  containsPt:(CGPoint) pt {
    return rect.origin.x <= pt.x && pt.x <= (rect.size.width + rect.origin.x) && rect.origin.y <= pt.y && pt.y <= (rect.size.height + rect.origin.y);
}


//rect是否相交
- (BOOL)isRect:(CGRect) rect1 intersectsWith:(CGRect) rect2 {
    CGFloat maxx = MAX(rect1.origin.x, rect2.origin.x);
    CGFloat minx = MIN(rect1.origin.x + rect1.size.width, rect2.origin.x + rect2.size.width);
    if (maxx - minx > 0) {
        return NO;
    }
    CGFloat maxy = MAX(rect1.origin.y, rect2.origin.y);
    CGFloat miny = MIN(rect1.origin.y + rect1.size.height, rect2.origin.y + rect2.size.height);
    if (maxy - miny > 0) {
        return NO;
    }
    return YES;
}

//是否第一个矩形包含了第二个矩形
- (BOOL)rect:(CGRect) r1 containsRect:(CGRect) r2 {
    return r1.origin.x <= r2.origin.x && r1.size.width >= r2.size.width && r1.origin.y <= r2.origin.y && r1.size.height >= r2.size.height;
}

@end