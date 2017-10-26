//
//  HeatMapDemo.h
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface HeatMapDemo :  UIViewController <BMKMapViewDelegate>{
    IBOutlet BMKMapView* mapView;
    IBOutlet UIButton* addHeatMapBtn;
    IBOutlet UIButton* removeHeatMapBtn;
}


@end
