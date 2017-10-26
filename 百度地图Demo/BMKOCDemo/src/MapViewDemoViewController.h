//
//  MapViewDemoController.h
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-3-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface MapViewDemoViewController :  UIViewController <BMKMapViewDelegate>{
    IBOutlet BMKMapView* _mapView;
    IBOutlet UISegmentedControl* segment;
    
}

@property (nonatomic, retain) IBOutlet UISegmentedControl* segment;
-(IBAction)changeMapType:(id)sender;


- (IBAction)switchValueChanged:(id)sender;

@end
