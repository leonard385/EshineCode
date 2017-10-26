//
//  DistrictSearchDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 16/1/13.
//  Copyright © 2016年 Baidu. All rights reserved.
//

#ifndef DistrictSearchDemoViewController_h
#define DistrictSearchDemoViewController_h

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface DistrictSearchDemoViewController : UIViewController<BMKMapViewDelegate>


@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

@end

#endif /* DistrictSearchDemoViewController_h */
