//
//  RouteSearchDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface RouteSearchDemoViewController : UIViewController<BMKMapViewDelegate, BMKRouteSearchDelegate> {
	IBOutlet BMKMapView* _mapView;
	IBOutlet UITextField* _startCityText;
	IBOutlet UITextField* _startAddrText;
	IBOutlet UITextField* _endCityText;
	IBOutlet UITextField* _endAddrText;
    BMKRouteSearch* _routesearch;
}

-(IBAction)onClickBusSearch;
-(IBAction)onClickDriveSearch;
-(IBAction)onClickWalkSearch;
- (IBAction)onClickRidingSearch:(id)sender;
- (IBAction)textFiledReturnEditing:(id)sender;


@end