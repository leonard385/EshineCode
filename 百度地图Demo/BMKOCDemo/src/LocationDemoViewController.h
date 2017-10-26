//
//  LocationDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by baidu on 13-4-15.
//  Copyright (c) 2013年 baidu. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>

@interface LocationDemoViewController :  UIViewController <BMKMapViewDelegate,BMKLocationServiceDelegate>{
    IBOutlet BMKMapView* _mapView;
    IBOutlet UIButton* startBtn;
    IBOutlet UIButton* stopBtn;
    IBOutlet UIButton* followingBtn;
    IBOutlet UIButton* followHeadBtn;
    BMKLocationService* _locService;
}
-(IBAction)startLocation:(id)sender;
-(IBAction)stopLocation:(id)sender;
-(IBAction)startFollowing:(id)sender;
-(IBAction)startFollowHeading:(id)sender;
@end

