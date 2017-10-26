//  HeatMapDemo.m
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "HeatMapDemo.h"
#import "JSONKit.h"

@implementation HeatMapDemo
- (id)init
{
    self = [super init];
    if(self)
    {
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
    UIBarButtonItem *customRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"说明" style:UIBarButtonItemStyleBordered target:self action:@selector(showGuide)];
    self.navigationItem.rightBarButtonItem = customRightBarButtonItem;

    mapView.mapType = BMKMapTypeStandard;
    mapView.zoomLevel = 5;
    [mapView setCenterCoordinate:CLLocationCoordinate2DMake(35.718, 111.581)];
    
    [addHeatMapBtn addTarget:self action:@selector(addHeatMap) forControlEvents:UIControlEventTouchUpInside];
    [removeHeatMapBtn addTarget:self action:@selector(removeHeatMap) forControlEvents:UIControlEventTouchUpInside];
}
-(void)viewWillAppear:(BOOL)animated {
    [mapView viewWillAppear];
    mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    [self.view bringSubviewToFront:addHeatMapBtn];
    [self.view bringSubviewToFront:removeHeatMapBtn];
    
}

-(void)viewWillDisappear:(BOOL)animated {
    [mapView viewWillDisappear];
    mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidUnload {
    [super viewDidUnload];
}
- (void)dealloc {
    if (mapView) {
        mapView = nil;
    }
    
}
//添加热力图
-(void)addHeatMap{
    
    //创建热力图数据类
    BMKHeatMap* heatMap = [[BMKHeatMap alloc]init];
    //创建热力图数据数组
    NSMutableArray* data = [NSMutableArray array];
    
    //读取数据
    NSData *jsonData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"locations" ofType:@"json"]];
    if (jsonData) {
        NSArray *array = [jsonData objectFromJSONData];
        for (NSDictionary *dic in array) {
            //创建BMKHeatMapNode
            BMKHeatMapNode* heapmapnode_test = [[BMKHeatMapNode alloc]init];
            CLLocationCoordinate2D coor;
            coor.latitude = [dic[@"lat"] doubleValue];
            coor.longitude = [dic[@"lng"] doubleValue];
            heapmapnode_test.pt = coor;
            //随机生成点强度
            heapmapnode_test.intensity = arc4random()*900;
            //添加BMKHeatMapNode到数组
            [data addObject:heapmapnode_test];
        }
    }
    //将点数据赋值到热力图数据类
    heatMap.mData = data;
    //调用mapView中的方法根据热力图数据添加热力图
    [mapView addHeatMap:heatMap];
    
}
//删除热力图
-(void)removeHeatMap{
    [mapView removeHeatMap];
}

//显示说明
-(void)showGuide
{
    UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"说明" message:@"此处为热力图绘制功能，需要开发者传入空间位置数据，由SDK帮助实现本地的渲染绘制" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定",nil];
    [myAlertView show];
}


@end
