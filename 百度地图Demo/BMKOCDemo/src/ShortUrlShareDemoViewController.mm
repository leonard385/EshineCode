//
//  ShortUrlShareDemoViewController.m
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import "ShortUrlShareDemoViewController.h"

@interface ShortUrlShareDemoViewController ()
{
    //名称
    NSString* geoName;
    //地址
    NSString* addr;
    //坐标
    CLLocationCoordinate2D pt;
    //短串
    NSString* shortUrl;
    //分享字符串
    NSString* showmeg;
}
@end
@implementation ShortUrlShareDemoViewController


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

    UIBarButtonItem *customRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"说明" style:UIBarButtonItemStyleBordered target:self action:@selector(showGuide)];
    self.navigationItem.rightBarButtonItem = customRightBarButtonItem;
    //初始化搜索服务
	_shareurlsearch = [[BMKShareURLSearch alloc]init];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _poisearch = [[BMKPoiSearch alloc]init];
    // 设置地图级别
    [_mapView setZoomLevel:13];
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _shareurlsearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self;
    _poisearch.delegate = self;
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _shareurlsearch.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil;
    _poisearch.delegate = nil;
}


- (void)viewDidUnload {
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;

}

- (void)dealloc {
    if (_shareurlsearch != nil) {
        _shareurlsearch = nil;
    }
    if (_geocodesearch != nil) {
        _geocodesearch = nil;
    }
    if (_poisearch != nil) {
        _poisearch = nil;
    }

    if (_mapView) {
        _mapView = nil;
    }
    if(showmeg!=nil)
    {
        showmeg = nil;
    }
    if (addr) {
        addr = nil;
    }

}
//显示说明
-(void)showGuide
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"短串分享－说明" message:@"短串分享是将POI点、反Geo点、路线规划，生成短链接串，此链接可通过短信等形式分享给好友，好友在终端设备点击此链接可快速打开Web地图、百度地图客户端进行信息展示" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}

#pragma mark - poiShortUrlShare

//1.点击［poi搜索结果分享］先发起poi搜索
-(IBAction)poiShortUrlShare
{
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = 0;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= @"北京";
    citySearchOption.keyword = @"故宫博物院";
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        NSLog(@"城市内检索发送失败");
    }

}
//2.搜索成功后在回调中根据uid发起poi短串搜索
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清除屏幕中所有的annotation
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
    
    if (error == 0) {
        if(result.poiInfoList.count>0)
        {
            //获取第一个poi点的数据
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:0];
            //将数据保存到图标上
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [_mapView addAnnotation:item];
            _mapView.centerCoordinate = poi.pt;
            //保存数据用于分享
            //名字
            geoName = poi.name;
            //地址
            addr = [[NSString alloc] initWithString:poi.address];
            //发起短串搜索获取poi分享url
            BMKPoiDetailShareURLOption *detailShareUrlSearchOption = [[BMKPoiDetailShareURLOption alloc]init];
            detailShareUrlSearchOption.uid=poi.uid;
            BOOL flag = [_shareurlsearch requestPoiDetailShareURL:detailShareUrlSearchOption];
            if(flag)
            {
                NSLog(@"详情url检索发送成功");
            }
            else
            {
                NSLog(@"详情url检索发送失败");
            }
        }
	} 
}


//3.返回短串分享url
- (void)onGetPoiDetailShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error
{
    shortUrl = result.url;
    if (error == BMK_SEARCH_NO_ERROR)
    {
        if(showmeg!=nil)
        {
            showmeg = nil;
        }
        showmeg = [NSString stringWithFormat:@"这里是:%@\r\n%@\r\n%@",geoName,addr,shortUrl];
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"短串分享" message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"分享",@"取消",nil];
        myAlertView.tag = 1000;
        [myAlertView show];
    }
}

#pragma mark - reverseGeoShortUrlShare

//1.点击［反向地理编码结果分享］先发起反geo搜索
-(IBAction)reverseGeoShortUrlShare
{    
    //坐标
    NSString* _coordinateXText = @"116.403981";
    NSString* _coordinateYText = @"39.915101";
	pt = (CLLocationCoordinate2D){[_coordinateYText floatValue], [_coordinateXText floatValue]};
    
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }


}

//2.搜索成功后在回调中根据参数发起geo短串搜索
- (void)onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{
    NSArray* array = [NSArray arrayWithArray:_mapView.annotations];
	[_mapView removeAnnotations:array];
	array = [NSArray arrayWithArray:_mapView.overlays];
	[_mapView removeOverlays:array];
    
	if (error == BMK_SEARCH_NO_ERROR) {
		BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
		item.coordinate = result.location;
		item.title = result.address;
		[_mapView addAnnotation:item];
        _mapView.centerCoordinate = result.location;
        //保存数据用于分享用
        //名字－－泡泡上显示的名字，可以自定义
        geoName = @"自定义泡泡名字";
        //地址
        addr = result.address;
        //发起短串搜索获取反geo分享url
        BMKLocationShareURLOption *option = [[BMKLocationShareURLOption alloc]init];
        option.snippet = addr;
        option.name = geoName;
        option.location = pt;
        BOOL flag = [_shareurlsearch requestLocationShareURL:option];
        if(flag)
        {
            NSLog(@"反geourl检索发送成功");
        }
        else
        {
            NSLog(@"反geourl检索发送失败");
        }

    }
}

- (void)onGetLocationShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error
{
    shortUrl = result.url;
    if (error == BMK_SEARCH_NO_ERROR)
    {
        if(showmeg!=nil)
        {
            showmeg = nil;
        }
        showmeg = [NSString stringWithFormat:@"这里是:%@\r\n%@\r\n%@",geoName,addr,shortUrl];
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"短串分享" message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"分享",@"取消",nil];
        myAlertView.tag = 1000;
        [myAlertView show];
    }
}

#pragma mark - routePlanShortUrlShare
//路线规划短串分享url
- (IBAction)routePlanShortUrlShare:(UISegmentedControl *)sender {
    BMKRoutePlanShareURLOption *option = [[BMKRoutePlanShareURLOption alloc] init];
    
    switch (sender.selectedSegmentIndex) {
        case 0://驾车
            option.routePlanType = BMK_ROUTE_PLAN_SHARE_URL_TYPE_DRIVE;
            break;
            
        case 1://步行
            option.routePlanType = BMK_ROUTE_PLAN_SHARE_URL_TYPE_WALK;
            break;
            
        case 2://骑行
            option.routePlanType = BMK_ROUTE_PLAN_SHARE_URL_TYPE_RIDE;
            break;
            
        case 3://公交
            option.routePlanType = BMK_ROUTE_PLAN_SHARE_URL_TYPE_TRANSIT;
            option.cityID = 131;//当进行公交路线规划短串分享且起终点通过关键字指定时，必须指定
            option.routeIndex = 0;//公交路线规划短串分享时使用，分享的是第几条线路
            break;
            
        default:
            break;
    }
    
    BMKPlanNode *fromNode = [[BMKPlanNode alloc] init];
    fromNode.name = @"百度大厦";
    fromNode.cityID = 131;
    option.from = fromNode;
    
    BMKPlanNode *toNode = [[BMKPlanNode alloc] init];
    toNode.name = @"天安门";
    toNode.cityID = 131;
    option.to = toNode;
    
    BOOL flag = [_shareurlsearch requestRoutePlanShareURL:option];
    if (flag) {
        NSLog(@"routePlanShortUrlShare检索发送成功");
    } else {
        NSLog(@"routePlanShortUrlShare检索发送失败");
    }
}

/**
 *返回路线规划分享url
 *@param searcher 搜索对象
 *@param result 返回结果
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetRoutePlanShareURLResult:(BMKShareURLSearch *)searcher result:(BMKShareURLResult *)result errorCode:(BMKSearchErrorCode)error {
    NSLog(@"onGetRoutePlanShareURLResult error:%d", (int)error);
    if (error == BMK_SEARCH_NO_ERROR) {
        shortUrl = result.url;
        showmeg = [NSString stringWithFormat:@"分享的路线规划短串为：\r\n%@",shortUrl];
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"短串分享" message:showmeg delegate:self cancelButtonTitle:nil otherButtonTitles:@"分享",@"取消",nil];
        myAlertView.tag = 1000;
        [myAlertView show];
    }
}

#pragma mark - UIAlertView delegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag ==1000 )
    {
        switch (buttonIndex)
        {
            case 0://确定
            {
                Class messageClass = (NSClassFromString(@"MFMessageComposeViewController"));
                if (messageClass != nil) {
                    if ([messageClass canSendText]) {
                        MFMessageComposeViewController *picker = [[MFMessageComposeViewController alloc] init];
                        picker.messageComposeDelegate = self;
                        picker.body = [NSString stringWithFormat:@"%@",showmeg];
                        [self presentViewController:picker animated:YES completion:nil];
                    } else {
                        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"当前设备暂时没有办法发送短信" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
                        [myAlertView show];
                    }
                }
                
            }
            case 1://取消
            {
            }
                break;
            default:
            {
                
            }
                break;
        }
    }

}

#pragma mark MFMessageComposeViewControllerDelegate

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller
				 didFinishWithResult:(MessageComposeResult)result
{
	// Notifies users about errors associated with the interface
	switch (result) {
		case MessageComposeResultCancelled:
			//用户自己取消，不用提醒
			break;
		case MessageComposeResultSent:
			//后续可能不能够成功发送，所以暂时不提醒
			break;
		case MessageComposeResultFailed:
            NSLog(@"短信发送失败");
			break;
		default:
            NSLog(@"短信没有发送");
			break;
	}
    [self dismissViewControllerAnimated:YES completion:nil];
}
//根据anntation生成对应的标注View
- (BMKAnnotationView *)mapView:(BMKMapView *)view viewForAnnotation:(id <BMKAnnotation>)annotation
{
    // 生成重用标示identifier
    NSString *AnnotationViewID = @"testMark";
	
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

@end
