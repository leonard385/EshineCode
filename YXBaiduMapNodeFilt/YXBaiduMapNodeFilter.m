//
//  YXBaiduMapNodeFilt.m
//  map
//
//  Created by qianqian on 16/7/12.
//  Copyright © 2016年 qianqian. All rights reserved.
//

#import "YXBaiduMapNodeFilter.h"

@implementation YXBaiduMapNodeFilter

+ (instancetype)baiduMapNodeFilter:(BMKMapView *)mapView
{
    YXBaiduMapNodeFilter *baiDuMapNodeFilter = [[YXBaiduMapNodeFilter alloc] init];
    baiDuMapNodeFilter.mapView = mapView;
    baiDuMapNodeFilter.arrAnnotationFiltered = [NSMutableArray array];
    [baiDuMapNodeFilter getRegionLonlatWithMapView:mapView];
    return baiDuMapNodeFilter;

}

#pragma  ----------------获取地图矩形左上右下点经纬度并将矩形分区----------------
- (void)getRegionLonlatWithMapView:(BMKMapView *)mapView
{
    //地图左上与右下点经纬度
    CLLocationCoordinate2D mapViewLeftUpPoint;
    CLLocationCoordinate2D mapViewRightDownPoint;
    
    BMKCoordinateRegion region = [mapView convertRect:mapView.frame toRegionFromView:mapView];
    
    mapViewLeftUpPoint.latitude = region.center.latitude + region.span.latitudeDelta/2;
    mapViewLeftUpPoint.longitude = region.center.longitude - region.span.longitudeDelta/2;
    mapViewRightDownPoint.latitude = region.center.latitude - region.span.latitudeDelta/2;
    mapViewRightDownPoint.longitude = region.center.longitude + region.span.longitudeDelta/2;
    
    //将地图分区
    self.arrRegion = [self DivideRegionMinlon:mapViewLeftUpPoint.longitude MinLat:mapViewRightDownPoint.latitude MaxLon:mapViewRightDownPoint.longitude MaxLat:mapViewLeftUpPoint.latitude];

}


#pragma  ----------------将屏幕经纬度划分为36个区域----------------
-(NSMutableArray *)DivideRegionMinlon:(double)minlon MinLat:(double)Minlat MaxLon:(double)maxlon MaxLat:(double)MaxLat
{
    static double maxX = 6;
    static double maxY = 6;
    
    NSMutableArray *regionCoordnion = [NSMutableArray new];
    double offsetx = (maxlon - minlon)/maxY;
    double offsety = (MaxLat - Minlat)/maxX;
    for(int i = 0;i < maxX;i++){
        double Sminlon = minlon + offsetx*i;
        double Smaxlon = minlon + offsetx*(i+1);
        
        for(int j = 0;j< maxY;j++){
            double sminLat = Minlat + offsety * j;
            double smaxLat = Minlat + offsety * (j+1);
            
            RegionType region;
            region.MinLon = Sminlon;
            region.MaxLon = Smaxlon;
            region.MinLat = sminLat;
            region.MaxLat = smaxLat;
            NSValue *strucValue = [NSValue valueWithBytes:&region objCType:@encode(RegionType)];
            [regionCoordnion addObject:strucValue];
        }
        
    }
    return regionCoordnion;
}

#pragma ------------根据地图比例尺确定每个小区域可显示节点的个数-----------------
- (NSInteger)aboutRegionCoordnionCount
{
    int maxTesult = 3;
    float level = self.mapView.zoomLevel;
    
    if (level - 15 > 1) {
        
        maxTesult = 3 * (level - 15);
    }
    return maxTesult;
}


#pragma mark -----------------将用户所有需要筛选过滤的标注加入集合arrAnnotation进行筛选并显示标注-----------------
-(void)addAnnnionsWithFliter:(NSMutableArray *)arrAnnotation
{
    [self.arrAnnotationFiltered removeAllObjects];
    
    int i = 0;
    NSInteger numberNode = 0;
    NSInteger AnntionMaxNum = [self aboutRegionCoordnionCount];
    
    //遍历区域
    for (NSValue *RegionStruc in self.arrRegion) {
        
        i++;
        numberNode = 0;
        RegionType region;
        [RegionStruc getValue:&region];//NSValue值转region
        
        //遍历总标注筛选
        for (BMKPointAnnotation *annotation in arrAnnotation) {
            
            //如果将要显示的节点在区域范围内
            if ( ( (annotation.coordinate.longitude > region.MinLon) && (annotation.coordinate.longitude < region.MaxLon) ) &&
                ( (annotation.coordinate.latitude > region.MinLat) && (annotation.coordinate.latitude < region.MaxLat) )  )
            {
                
                numberNode++;
                if (numberNode <= AnntionMaxNum && numberNode > 0) {
                    
                    [self.arrAnnotationFiltered addObject:annotation];
                    if (numberNode == AnntionMaxNum) {
                        numberNode = 0;
                        break;
                    }
                }
            }
        }
    }

    dispatch_async(dispatch_get_main_queue(), ^{
        
         [self.mapView addAnnotations:self.arrAnnotationFiltered];
    });
   

}

@end
