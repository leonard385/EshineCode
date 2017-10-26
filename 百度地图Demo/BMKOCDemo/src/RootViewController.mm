//
//  ViewController.m
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-3-21.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "RootViewController.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Cloud/BMKCloudSearchComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@implementation RootViewController

//自定义地图样式
- (void)customMapStyle {
    //设置自定义地图样式，会影响所有地图实例
    //注：必须在BMKMapView对象初始化之前调用
    NSString* path = [[NSBundle mainBundle] pathForResource:@"custom_config_清新蓝" ofType:@""];
    [BMKMapView customMapStyle:path];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    [self customMapStyle];//自定义地图样式
    
    NSLog(@"base     component version: %@", BMKGetMapApiBaseComponentVersion());
    NSLog(@"map      component version: %@", BMKGetMapApiMapComponentVersion());
    NSLog(@"location component version: %@", BMKGetMapApiLocationComponentVersion());
    NSLog(@"search   component version: %@", BMKGetMapApiSearchComponentVersion());
    NSLog(@"cloud    component version: %@", BMKGetMapApiCloudComponentVersion());
    NSLog(@"radar    component version: %@", BMKGetMapApiRadarComponentVersion());
    NSLog(@"utils    component version: %@", BMKGetMapApiUtilsComponentVersion());
    
    _demoNameArray = [[NSArray alloc]initWithObjects:
                      @"基本地图功能-MapViewBaseDemo",
                      @"多地图使用功能-MultiMapViewDemo",
					  @"图层展示功能-MapViewDemo",
                      @"地图操作功能-MapViewControlDemo",
                      @"UI控制功能-MapViewUISettingDemo",
					  @"定位功能-LocationDemo",
					  @"覆盖物功能-AnnotationDemo",
                      @"自定义绘制-CustomOverlayDemo",
					  @"POI搜索功能-PoiSearchDemo",
                      @"地理编码功能-GeocodeDemo",
					  @"路径规划功能-RouteSearchDemo",
                      @"公交线路查询-BusLineSearch",
                      @"行政区域检索功能-DistrictSearchDemo",
					  @"离线地图功能-OfflineDemo",
                      @"热力图功能-HeatMapDemo",
                      @"短串分享功能-ShortUrlShareDemo",
                      @"云检索功能-CloudSearchDemo",
                      @"调启地图客户端-OpenMapDemo",
                      @"OpenGL绘制功能-OpenGLDemo",
                      @"收藏夹功能-FavoritesDemo",
                      @"周边雷达功能-Radar",
                      @"点聚合功能-ClusterDemo",
                      @"tileLayer功能-TileLayerDemo",
					  nil];
    _viewControllerTitleArray = [[NSArray alloc]initWithObjects:
                                 @"基本地图功能",
                                 @"多地图使用功能",
                                 @"图层展示功能",
                                 @"地图操作功能",
                                 @"UI控制功能",
                                 @"定位功能",
                                 @"覆盖物功能",
                                 @"自定义绘制",
                                 @"POI搜索功能",
                                 @"地理编码功能",
                                 @"路径规划功能",
                                 @"公交线路查询",
                                 @"行政区域检索功能",
                                 @"离线地图功能",
                                 @"热力图功能",
                                 @"短串分享功能",
                                 @"云检索功能",
                                 @"调启百度地图客户端",
                                 @"OpenGL绘制功能",
                                 @"收藏夹功能",
                                 @"周边雷达功能",
                                 @"点聚合功能",
                                 @"tileLayer功能",
                                 nil];
    
    _viewControllerArray = [[NSArray alloc]initWithObjects:
                            @"MapViewBaseDemoViewController",
                            @"MultiMapViewDemo",
                            @"MapViewDemoViewController",
                            @"MapViewControlDemoViewController",
                            @"MapViewUISettingDemoViewController",
                            @"LocationDemoViewController",
                            @"AnnotationDemoViewController",
                            @"CustomOverlayDemoViewController",
                            @"PoiSearchDemoViewController",
                            @"GeocodeDemoViewController",
                            @"RouteSearchDemoViewController",
                            @"BusLineSearchViewController",
                            @"DistrictSearchDemoViewController",
                            @"OfflineDemoViewController",
                            @"HeatMapDemo",
                            @"ShortUrlShareDemoViewController",
                            @"CloudSearchDemoViewController",
                            @"OpenBaiduMapDemo",
                            @"OpenGLDemoViewController",
                            @"FavoritesDemoViewController",
                            @"RadarTabBarController",
                            @"ClusterDemoViewController",
                            @"TileLayerDemoViewController",
                            nil];
	self.title = [NSString stringWithFormat: @"欢迎使用百度地图iOS SDK %@", BMKGetMapApiVersion()];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.navigationController.navigationBar.translucent = NO;
    }
}

#pragma mark -
#pragma mark Table view data source


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _demoNameArray.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BaiduMapApiDemoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_demoNameArray objectAtIndex:indexPath.row];
    return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController* viewController = nil;
    if (indexPath.row < 19 && indexPath.row != 12) {
        viewController = [[NSClassFromString([_viewControllerArray objectAtIndex:indexPath.row]) alloc] init];
    } else {
        viewController = [[UIStoryboard storyboardWithName:@"Storyboard" bundle:nil] instantiateViewControllerWithIdentifier:[_viewControllerArray objectAtIndex:indexPath.row]];
    }
    viewController.title = [_viewControllerTitleArray objectAtIndex:indexPath.row];
    UIBarButtonItem *customLeftBarButtonItem = [[UIBarButtonItem alloc] init];
    customLeftBarButtonItem.title = @"返回";
    self.navigationItem.backBarButtonItem = customLeftBarButtonItem;
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

@end
