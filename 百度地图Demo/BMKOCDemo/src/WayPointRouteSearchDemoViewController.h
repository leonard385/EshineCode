//
//  WayPointRouteSearchDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by baidu on 13-7-14.
//  Copyright (c) 2013年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface WayPointRouteSearchDemoViewController : UIViewController <BMKMapViewDelegate, BMKRouteSearchDelegate> {
    IBOutlet UITextField* _startAddrText;
    IBOutlet UITextField* _wayPointAddrText;
    IBOutlet UITextField* _endAddrText;
    IBOutlet BMKMapView* _mapView;
    BMKRouteSearch* _routesearch;

}

-(IBAction)onDriveSearch;
- (IBAction)textFiledReturnEditing:(id)sender;

@end
