//
//  OpenGLDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 14-11-14.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>

@interface OpenGLDemoViewController : UIViewController <BMKMapViewDelegate>{
    IBOutlet BMKMapView* _mapView;
    
}


@end
