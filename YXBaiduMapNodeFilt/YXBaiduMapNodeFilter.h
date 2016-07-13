//
//  YXBaiduMapNodeFilt.h
//  map
//
//  Created by qianqian on 16/7/12.
//  Copyright © 2016年 qianqian. All rights reserved.


//地图区域结构体
typedef struct
{
    double MinLon;
    double MinLat;
    double MaxLon;
    double MaxLat;
    int numbersNode;
    
}RegionType;

@interface YXBaiduMapNodeFilter : NSObject

/*
 mapView为地图对象
 */
@property (strong, nonatomic) BMKMapView *mapView;
/*
 地图被分区到数组
 */
@property (strong, nonatomic) NSMutableArray *arrRegion;
/*
 分区后节点标注数组
 */
@property (strong, nonatomic) NSMutableArray *arrAnnotationFiltered;

/*
 对象初始化
 参数mapView为地图对象
 */
+ (instancetype)baiduMapNodeFilter:(BMKMapView *)mapView;

/*
 筛选节点实例方法
 参数arrAnnotation为所有需要筛选的数组
 */
-(void)addAnnnionsWithFliter:(NSMutableArray *)arrAnnotation;

@end
