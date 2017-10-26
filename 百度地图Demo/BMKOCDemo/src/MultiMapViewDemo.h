//
//  MapViewBaseDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
@interface MultiMapViewDemo :  UIViewController <BMKMapViewDelegate>{
    BMKMapView* mapView1;
    BMKMapView* mapView2;
    BMKMapView* mapView3;
    BMKMapView* mapView4;
    BMKPointAnnotation* pointAnnotation;
    BMKPointAnnotation* pointAnnotation2;
    BMKAnnotationView* newAnnotation;
    NSMutableArray* muarray1;
    NSMutableArray* muarray2;
    NSMutableArray* muarray3;
    NSMutableArray* muarray4;
    UIButton* okButton;
    UIButton* okButton2;
}
@end
