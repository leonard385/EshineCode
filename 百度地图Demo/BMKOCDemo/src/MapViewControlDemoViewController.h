//
//  MapViewControlDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface MapViewControlDemoViewController :  UIViewController <BMKMapViewDelegate>{
    IBOutlet BMKMapView* _mapView;
    IBOutlet UIButton* _zoom;
    IBOutlet UIButton* _rotate;
    IBOutlet UIButton* _overlook;
    IBOutlet UITextField* _zoomdegree;
    IBOutlet UITextField* _rotatedegree;
    IBOutlet UITextField* _overlookdegree;
    IBOutlet UILabel* _showMsgLabel;
    
    IBOutlet UIButton* _closeButton;
    IBOutlet UIImageView* _imgView;
    IBOutlet UIView* _hiddenView;
    
    
    
}
- (IBAction)zoomButtonClicked:(id)sender;
- (IBAction)rotateButtonClicked:(id)sender;
- (IBAction)overlookButtonClicked:(id)sender;
- (IBAction)textFiledReturnEditing:(id)sender;
- (IBAction)closeButtonClicked:(id)sender;
@end
