//
//  AnnotationDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface AnnotationDemoViewController : UIViewController <BMKMapViewDelegate>{
	IBOutlet BMKMapView* _mapView;
    IBOutlet UISegmentedControl* segment;
}

@end
