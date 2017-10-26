//
//  BusLineSearchViewController.h
//  BaiduMapApiDemoSrc
//
//  Created by baidu on 12-6-20.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface BusLineSearchViewController : UIViewController<BMKMapViewDelegate, BMKBusLineSearchDelegate,BMKPoiSearchDelegate> {
	IBOutlet BMKMapView* _mapView;
	IBOutlet UITextField* _cityText;
	IBOutlet UITextField* _busLineText;
	
    NSMutableArray* _busPoiArray;
    int currentIndex;
    BMKPoiSearch* _poisearch;
	BMKBusLineSearch* _buslinesearch;
    BMKPointAnnotation* _annotation;
}

-(IBAction)onClickBusLineSearch;
-(IBAction)onClickNextSearch;

- (IBAction)textFiledReturnEditing:(id)sender;
@end
