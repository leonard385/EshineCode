//
//  RadarNearbyViewController.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/5/7.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "RadarNearbyViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
#import "RadarUploadViewController.h"

@interface RadarNearbyViewController ()<UITableViewDataSource, UITableViewDelegate, BMKMapViewDelegate, BMKRadarManagerDelegate> {
    UITableView *_tableView;
    BMKMapView *_mapView;
    BMKRadarManager *_radarManager;
    CLLocationCoordinate2D _myCoor;
}

@property (nonatomic, strong) NSMutableArray *nearbyInfos;
@property (nonatomic) NSInteger curPageIndex;

@end

@implementation RadarNearbyViewController
@synthesize nearbyInfos = _nearbyInfos;
@synthesize curPageIndex = _curPageIndex;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"周边雷达-检索";
    self.tabBarItem.title = @"检索周边";
    
    CGRect rect = _scrollView.frame;
    _scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * 2, _scrollView.frame.size.height);
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height - 30)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.scrollEnabled = YES;
    _tableView.clipsToBounds = YES;
    [_scrollView addSubview:_tableView];
    _mapView = [[BMKMapView alloc] initWithFrame:CGRectMake(rect.size.width, 0, rect.size.width, rect.size.height)];
    _mapView.showsUserLocation = YES;
    [_scrollView addSubview:_mapView];
    _preButton.enabled = NO;
    _nextButton.enabled = NO;
    _curPageLabel.hidden = NO;
    
    _radarManager = [BMKRadarManager getRadarManagerInstance];
    _curPageIndex = 0;
    
    _nearbyInfos = [NSMutableArray array];
    
    ///我的位置改变通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateMyLocation:) name:MY_LOCATION_UPDATE_NOTIFICATION object:nil];
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [_mapView viewWillAppear];
    _mapView.delegate = self;
    [_radarManager addRadarManagerDelegate:self];//添加radar delegate
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_mapView viewWillDisappear];
    _mapView.delegate = nil;
    [_radarManager removeRadarManagerDelegate:self];//不用需移除，否则影响内存释放
}

- (void)viewDidLayoutSubviews {
    CGRect rect = _scrollView.frame;
    _tableView.frame = CGRectMake(0, 0, rect.size.width, rect.size.height - 30);
    _mapView.frame = CGRectMake(rect.size.width, 0, rect.size.width, rect.size.height);
}

- (void) dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    _radarManager = nil;
    [BMKRadarManager releaseRadarManagerInstance];
    _mapView = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

///更新缓存附近信息数据并刷新地图显示
- (void)setNearbyInfos:(NSMutableArray *)nearbyInfos {
    [_nearbyInfos removeAllObjects];
    [_nearbyInfos addObjectsFromArray:nearbyInfos];
    [_tableView reloadData];
    [_mapView removeAnnotations:_mapView.annotations];
    NSMutableArray *annotations = [NSMutableArray array];
    for (BMKRadarNearbyInfo *info in _nearbyInfos) {
        BMKPointAnnotation *annotation = [[BMKPointAnnotation alloc] init];
        annotation.coordinate = info.pt;
        annotation.title = info.userId;
        annotation.subtitle = info.extInfo;
        [annotations addObject:annotation];
    }
    [_mapView addAnnotations:annotations];
    [_mapView showAnnotations:annotations animated:YES];
}

///更新我的位置
- (void)updateMyLocation:(NSNotification *) notification {
    BMKUserLocation *location = [notification.userInfo objectForKey:@"loc"];
    _myCoor = location.location.coordinate;
    [_mapView updateLocationData:location];
}

///获取周边信息
- (IBAction)nearbyAction:(id)sender {
    [self nearbySearchWithPageIndex:0];
}

///清除本地缓存
- (IBAction)clearAction:(id)sender {
    self.nearbyInfos = [NSMutableArray array];
    _preButton.enabled = NO;
    _nextButton.enabled = NO;
    _curPageLabel.text = @"";
}

///切换附近信息显示方式
- (IBAction)switchResShowAction:(id)sender {
    [_scrollView setContentOffset:CGPointMake(_scrollView.frame.size.width * _segControl.selectedSegmentIndex, 0) animated:YES];
}

///上一页
- (IBAction)prePageAction:(id)sender {
    [self nearbySearchWithPageIndex:_curPageIndex - 1];
}
///下一页
- (IBAction)nextPageAction:(id)sender {
    [self nearbySearchWithPageIndex:_curPageIndex + 1];
}

- (void)nearbySearchWithPageIndex:(NSInteger) pageIndex {
    BMKRadarNearbySearchOption *option = [[BMKRadarNearbySearchOption alloc] init]
    ;
    option.radius = 8000;
    option.sortType = BMK_RADAR_SORT_TYPE_DISTANCE_FROM_NEAR_TO_FAR;
    option.centerPt = _myCoor;
    option.pageIndex = pageIndex;
//    option.pageCapacity = 2;
    //    NSDate *eDate = [NSDate date];
    //    //    eDate = [NSDate dateWithTimeInterval:-3600 * 3 sinceDate:eDate];
    //    NSDate *date = [NSDate dateWithTimeInterval:-3600 * 4 sinceDate:eDate];
    //    BMKDateRange *dateRange = [[BMKDateRange alloc] init];
    //    dateRange.startDate = date;
    //    dateRange.endDate = eDate;
    //    NSLog(@"%@ ,  %@", date, eDate);
    //    option.dateRange = dateRange;
    
    BOOL res = [_radarManager getRadarNearbySearchRequest:option];
    if (res) {
        NSLog(@"get 成功");
    } else {
        NSLog(@"get 失败");
    }

}

#pragma mark - UITableView

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _nearbyInfos.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"BaiduMapRadarDemoCell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    BMKRadarNearbyInfo *info = [_nearbyInfos objectAtIndex:indexPath.row];
    cell.textLabel.text = info.userId;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d米   %@", (int)info.distance, info.extInfo];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    BMKPointAnnotation *annotation = [_mapView.annotations objectAtIndex:indexPath.row];
    [_mapView setCenterCoordinate:annotation.coordinate];
    [_mapView selectAnnotation:annotation animated:NO];
    
    _segControl.selectedSegmentIndex = 1;
    [self switchResShowAction:_segControl];
}


#pragma mark - BMKRadarManagerDelegate
/**
 *返回雷达 查询周边的用户信息结果
 *@param result 结果，类型为@see BMKRadarNearbyResult
 *@param error 错误号，@see BMKRadarErrorCode
 */
- (void)onGetRadarNearbySearchResult:(BMKRadarNearbyResult *)result error:(BMKRadarErrorCode)error {
    NSLog(@"onGetRadarNearbySearchResult  %d", error);
    if (error == BMK_RADAR_NO_ERROR) {
        NSLog(@"result.infoList.count:  %d", (int)result.infoList.count);
        self.nearbyInfos = (NSMutableArray *)result.infoList;
        _curPageIndex = result.pageIndex;
        _curPageLabel.text = [NSString stringWithFormat:@"%d", (int)_curPageIndex + 1];
        _nextButton.enabled = (_curPageIndex + 1 != result.pageNum);
        _preButton.enabled = _curPageIndex != 0;
    }
}

#pragma mark - BMKMapViewDelegate

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"RadarMark";
    
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
        ((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
        // 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
    
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
    annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}

@end
