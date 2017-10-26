//
//  CustomOverlayDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-5-21.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface CustomOverlayDemoViewController : UIViewController<BMKMapViewDelegate>
{
    IBOutlet BMKMapView* _mapView;
}

@end
