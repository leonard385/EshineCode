//
//  ShortUrlShareDemoViewController.h
//  BaiduMapApiDemo
//
//  Copyright 2011 Baidu Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMessageComposeViewController.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Search/BMKSearchComponent.h>

@interface ShortUrlShareDemoViewController : UIViewController<BMKMapViewDelegate, BMKShareURLSearchDelegate,BMKGeoCodeSearchDelegate,BMKPoiSearchDelegate,MFMessageComposeViewControllerDelegate> {
	IBOutlet BMKMapView* _mapView;
    IBOutlet UIButton* _poiShortUrlButton;
    IBOutlet UIButton* _reverseGeoShortUrlButton;
	BMKShareURLSearch* _shareurlsearch;
    BMKGeoCodeSearch* _geocodesearch;
    BMKPoiSearch* _poisearch;
    bool isPoiShortUrlShare;

}
-(IBAction)poiShortUrlShare;
-(IBAction)reverseGeoShortUrlShare;
- (IBAction)routePlanShortUrlShare:(UISegmentedControl *)sender;

@end
