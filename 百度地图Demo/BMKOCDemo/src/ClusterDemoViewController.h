//
//  ClusterDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/9/18.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#ifndef ClusterDemoViewController_h
#define ClusterDemoViewController_h

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface ClusterDemoViewController : UIViewController<BMKMapViewDelegate>

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@end

#endif /* ClusterDemoViewController_h */
