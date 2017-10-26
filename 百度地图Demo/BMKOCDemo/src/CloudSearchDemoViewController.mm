
/*
 * CloudSearchDemoViewController.mm
 * BaiduMapApiDemo
 * 本示例代码使用了测试ak和测试数据，开发者在检索自己LBS数据之前，需替换 cloudLocalSearch.ak和cloudLocalSearch.geoTableId的值
 *
 * 1、替换cloudLocalSearch.ak的值：
 * （1）请访问http://lbsyun.baidu.com/apiconsole/key申请一个“服务端”的ak，其他类型的ak无效；
 * （2）将申请的ak替换cloudLocalSearch.ak的值；
 *
 * 2、替换cloudLocalSearch.geoTableId值：
 * （1）申请完服务端ak后访问http://lbsyun.baidu.com/datamanager/datamanage创建一张表；
 * （2）在“表名称”处自由填写表的名称，如MyData，点击保存；
 * （3）“创建”按钮右方将会出现形如“MyData(34195)”字样，其中的“34195”即为geoTableId的值；
 * （4）添加或修改字段：点击“字段”标签修改和添加字段；
 * （5）添加数据：
 *  a、标注模式：“数据” ->“标注模式”，输入要添加的地址然后“百度一下”，点击地图蓝色图标，再点击保存即可；
 *  b、批量模式： “数据” ->“批量模式”，可上传文件导入，具体文件格式要求请参见当页的“批量导入指南”；
 * （6）选择左边“设置”标签，“是否发布到检索”选择“是”，然后"保存";
 * （7）数据发布后，替换cloudLocalSearch.geoTableId的值即可；
 * 备注：切记添加、删除或修改数据后要再次发布到检索，否则将会出现检索不到修改后数据的情况
 * Copyright 2011 Baidu Inc. All rights reserved.
 */

#import "CloudSearchDemoViewController.h"

@implementation CloudSearchDemoViewController


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    //初始化右边的更新按钮
    UIBarButtonItem *customRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"说明" style:UIBarButtonItemStyleBordered target:self action:@selector(showGuide)];
    self.navigationItem.rightBarButtonItem = customRightBarButtonItem;
    //初始化云检索服务
    _search = [[BMKCloudSearch alloc]init];
    // 设置地图级别
    [_mapView setZoomLevel:13];
    _mapView.isSelectedAnnotationViewFront = YES;
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _search.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _search.delegate = nil; // 不用时，置nil
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (void)dealloc {
    if (_search != nil) {
        _search = nil;
    }
    if (_mapView) {
        _mapView = nil;
    }
}
//显示说明
-(void)showGuide
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"LBS.云检索－说明" message:@"本示例使用了测试ak,开发者若需使用自有LBS数据,请留意代码中相关注释。" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}
//发起本地云检索
-(IBAction)onClickLocalSearch

{
    BMKCloudLocalSearchInfo *cloudLocalSearch = [[BMKCloudLocalSearchInfo alloc]init];
    cloudLocalSearch.ak = @"B266f735e43ab207ec152deff44fec8b";
    cloudLocalSearch.geoTableId = 31869;
    cloudLocalSearch.pageIndex = 0;
    cloudLocalSearch.pageSize = 10;
    cloudLocalSearch.region = @"北京市";
    cloudLocalSearch.keyword = @"天安门";
    BOOL flag = [_search localSearchWithSearchInfo:cloudLocalSearch];
    if(flag)
    {
        NSLog(@"本地云检索发送成功");
    }
    else
    {
        NSLog(@"本地云检索发送失败");
    }
}
//发起周边云检索
-(IBAction)onClickNearbySearch
{
    BMKCloudNearbySearchInfo *cloudNearbySearch = [[BMKCloudNearbySearchInfo alloc]init];
    cloudNearbySearch.ak = @"B266f735e43ab207ec152deff44fec8b";
    cloudNearbySearch.geoTableId = 31869;
    cloudNearbySearch.pageIndex = 0;
    cloudNearbySearch.pageSize = 10;
    cloudNearbySearch.location = @"116.403402,39.915067";
    cloudNearbySearch.radius = 5;
    cloudNearbySearch.keyword = @"天安门";
    BOOL flag = [_search nearbySearchWithSearchInfo:cloudNearbySearch];
    if(flag)
    {
        NSLog(@"周边云检索发送成功");
    }
    else
    {
        NSLog(@"周边云检索发送失败");
    }
    
}
//发起矩形云检索
-(IBAction)onClickBoundSearch
{
    BMKCloudBoundSearchInfo *cloudBoundSearch = [[BMKCloudBoundSearchInfo alloc]init];
    cloudBoundSearch.ak = @"B266f735e43ab207ec152deff44fec8b";
    cloudBoundSearch.geoTableId = 31869;
    cloudBoundSearch.pageIndex = 0;
    cloudBoundSearch.pageSize = 10;
    cloudBoundSearch.bounds = @"116.30,36.20;118.30,40.20";
    cloudBoundSearch.keyword = @"天安门";
    BOOL flag = [_search boundSearchWithSearchInfo:cloudBoundSearch];
    if(flag)
    {
        NSLog(@"矩形云检索发送成功");
    }
    else
    {
        NSLog(@"矩形云检索发送失败");
    }
    
}
//发起详情云检索
-(IBAction)onClickDetailSearch
{
    BMKCloudDetailSearchInfo *cloudDetailSearch = [[BMKCloudDetailSearchInfo alloc]init];
    cloudDetailSearch.ak = @"B266f735e43ab207ec152deff44fec8b";
    cloudDetailSearch.geoTableId = 31869;
    cloudDetailSearch.uid = @"19150264";
    BOOL flag = [_search detailSearchWithSearchInfo:cloudDetailSearch];
    if(flag)
    {
        NSLog(@"详情云检索发送成功");
    }
    else
    {
        NSLog(@"详情云检索发送失败");
    }
    
}
#pragma mark -
#pragma mark implement BMKMapViewDelegate

/**
 *根据anntation生成对应的View
 *@param mapView 地图View
 *@param annotation 指定的标注
 *@return 生成的标注View
 */
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"xidanMark";
	
    // 检查是否有重用的缓存
    BMKAnnotationView* annotationView = [view dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
    
    // 缓存没有命中，自己构造一个，一般首次添加annotation代码会运行到此处
    if (annotationView == nil) {
        annotationView = [[BMKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
		((BMKPinAnnotationView*)annotationView).pinColor = BMKPinAnnotationColorRed;
		// 设置重天上掉下的效果(annotation)
        ((BMKPinAnnotationView*)annotationView).animatesDrop = YES;
    }
	
    // 设置位置
	annotationView.centerOffset = CGPointMake(0, -(annotationView.frame.size.height * 0.5));
    annotationView.annotation = annotation;
    // 单击弹出泡泡，弹出泡泡前提annotation必须实现title属性
	annotationView.canShowCallout = YES;
    // 设置是否可以拖拽
    annotationView.draggable = NO;
    
    return annotationView;
}
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view
{
    [mapView bringSubviewToFront:view];
    [mapView setNeedsDisplay];
}
- (void)mapView:(BMKMapView *)mapView didAddAnnotationViews:(NSArray *)views
{
    NSLog(@"didAddAnnotationViews");
}

#pragma mark -
#pragma mark implement BMKSearchDelegate

- (void)onGetCloudPoiResult:(NSArray*)poiResultList searchType:(int)type errorCode:(int)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
    
    if (error == BMKErrorOk) {
		BMKCloudPOIList* result = [poiResultList objectAtIndex:0];
		for (int i = 0; i < result.POIs.count; i++) {
            BMKCloudPOIInfo* poi = [result.POIs objectAtIndex:i];
            //自定义字段
            if(poi.customDict!=nil&&poi.customDict.count>1)
            {
                NSString* customStringField = [poi.customDict objectForKey:@"custom"];
                NSLog(@"customFieldOutput=%@",customStringField);
                NSNumber* customDoubleField = [poi.customDict objectForKey:@"double"];
                NSLog(@"customDoubleFieldOutput=%f",customDoubleField.doubleValue);
                
            }
            
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            CLLocationCoordinate2D pt = (CLLocationCoordinate2D){ poi.longitude,poi.latitude};
            item.coordinate = pt;
            item.title = poi.title;
            [_mapView addAnnotation:item];
            if(i == 0)
            {
                //将第一个点的坐标移到屏幕中央
                _mapView.centerCoordinate = pt;
            }
		}
	} else {
        NSLog(@"error ==%d",error);
    }
}
- (void)onGetCloudPoiDetailResult:(BMKCloudPOIInfo*)poiDetailResult searchType:(int)type errorCode:(int)error
{
    // 清楚屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
    
    if (error == BMKErrorOk) {
		BMKCloudPOIInfo* poi = poiDetailResult;
        BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
        CLLocationCoordinate2D pt = (CLLocationCoordinate2D){ poi.longitude,poi.latitude};
        item.coordinate = pt;
        item.title = poi.title;
        [_mapView addAnnotation:item];
        //将第一个点的坐标移到屏幕中央
        _mapView.centerCoordinate = pt;
	} else {
        NSLog(@"error ==%d",error);
    }
}

@end
