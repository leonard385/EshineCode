//
//  GeocodeDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface GeocodeDemoViewController : UIViewController<BMKMapViewDelegate, BMKGeoCodeSearchDelegate> {
	IBOutlet BMKMapView* _mapView;
	IBOutlet UITextField* _coordinateXText;
	IBOutlet UITextField* _coordinateYText;
	IBOutlet UITextField* _cityText;
	IBOutlet UITextField* _addrText;
	BMKGeoCodeSearch* _geocodesearch;
}
-(IBAction)onClickGeocode;
-(IBAction)onClickReverseGeocode;
- (IBAction)textFiledReturnEditing:(id)sender;
@end
