//
//  TileLayerDemoViewController.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/10/10.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#import "TileLayerDemoViewController.h"

//通过同步方法获取瓦片数据
@interface LocalTileLayer : BMKSyncTileLayer

@end


@implementation LocalTileLayer

- (UIImage *)tileForX:(NSInteger)x y:(NSInteger)y zoom:(NSInteger)zoom {
    NSString *imageName = [NSString stringWithFormat:@"%ld_%ld_%ld.jpg", zoom, x, y];
    UIImage *image = [UIImage imageNamed:imageName];
    return image;
}

@end

@implementation TileLayerDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0)) {
        self.navigationController.navigationBar.translucent = NO;
    }
    _mapView.zoomLevel = 16;
    _mapView.centerCoordinate = CLLocationCoordinate2DMake(39.924, 116.403);
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (IBAction)segmentAction:(id)sender {
    UISegmentedControl *segmented = (UISegmentedControl*)sender;
    [_mapView removeOverlays:_mapView.overlays];
    if (segmented.selectedSegmentIndex == 1) {//本地
        [self addLocalTile];
    } else if (segmented.selectedSegmentIndex == 2) {//在线
        [self addUrlTile];
    } else {
        _mapView.mapType = BMKMapTypeStandard;
    }
}

//添加本地瓦片图
- (void)addLocalTile {
    //限制地图显示范围
    _mapView.maxZoomLevel = 17.4;
    _mapView.minZoomLevel = 16;
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.923018, 116.404440);
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.013142, 0.011678);
    _mapView.limitMapRegion = BMKCoordinateRegionMake(center, span);
    _mapView.overlookEnabled = NO;
    _mapView.rotateEnabled = NO;//禁用旋转手势
    _mapView.mapType = BMKMapTypeNone;
    
    
    LocalTileLayer *localTileLayer = [[LocalTileLayer alloc] init];
    localTileLayer.visibleMapRect = BMKMapRectMake(32995300, 35855667, 1300, 1900);
    localTileLayer.maxZoom = 18;
    localTileLayer.minZoom = 16;
    [_mapView addOverlay:localTileLayer];
}

//添加在线瓦片图
- (void)addUrlTile {
    //限制地图显示范围
    _mapView.maxZoomLevel = 18;
    _mapView.minZoomLevel = 16;
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.924257, 116.403263);
    BMKCoordinateSpan span = BMKCoordinateSpanMake(0.038325, 0.028045);
    _mapView.limitMapRegion = BMKCoordinateRegionMake(center, span);////限制地图显示范围
    _mapView.overlookEnabled = NO;
    _mapView.rotateEnabled = NO;//禁用旋转手势
    _mapView.mapType = BMKMapTypeNone;
    
    BMKURLTileLayer *urlTileLayer = [[BMKURLTileLayer alloc] initWithURLTemplate:@"http://api0.map.bdimg.com/customimage/tile?&x={x}&y={y}&z={z}&udt=20150601&customid=light"];
    urlTileLayer.visibleMapRect = BMKMapRectMake(32994258, 35853667, 3122, 5541);
    urlTileLayer.maxZoom = 18;
    urlTileLayer.minZoom = 16;
    [_mapView addOverlay:urlTileLayer];
}

#pragma mark - BMKMapViewDelegate

/**
 *根据overlay生成对应的View
 *@param mapView 地图View
 *@param overlay 指定的overlay
 *@return 生成的覆盖物View
 */
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay {
    if ([overlay isKindOfClass:[BMKTileLayer class]]) {
        BMKTileLayerView *view = [[BMKTileLayerView alloc] initWithTileLayer:overlay];
        return view;
    }
    return nil;
}

/**
 *地图区域改变完成后会调用此接口
 *@param mapview 地图View
 *@param animated 是否动画
 */
- (void)mapView:(BMKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    NSLog(@"zoom level: %lf", mapView.zoomLevel);
}

@end