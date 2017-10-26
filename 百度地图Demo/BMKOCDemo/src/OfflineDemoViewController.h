//
//  OfflineDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-4-16.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface OfflineDemoViewController :UIViewController<BMKMapViewDelegate,BMKOfflineMapDelegate>
{
    IBOutlet BMKMapView* _mapView;//.xib里要有BMKMapView类用于初始化数据驱动
    BMKOfflineMap* _offlineMap;
    IBOutlet UIButton* downLoadBtn;
    IBOutlet UIButton* scanBtn;
    IBOutlet UIButton* stopBtn;
    IBOutlet UIButton* removeBtn;
    IBOutlet UIButton* searchBtn;
    IBOutlet UITextField* cityName;
    IBOutlet UILabel* cityId;
    IBOutlet UILabel* downloadratio;
    IBOutlet UISegmentedControl* tableviewChangeCtrl;
    IBOutlet UITableView* groupTableView;
    IBOutlet UITableView* plainTableView;

    NSArray* _arrayHotCityData;//热门城市
    NSArray* _arrayOfflineCityData;//全国支持离线地图的城市
    NSMutableArray * _arraylocalDownLoadMapInfo;//本地下载的离线地图
}
-(IBAction)start:(id)sender;
-(IBAction)stop:(id)sender;
-(IBAction)search:(id)sender;
-(IBAction)remove:(id)sender;
-(IBAction)textFiledReturnEditing:(id)sender;
-(IBAction)segmentChanged:(id)sender;
@end
