//
//  MapViewUISettingDemoViewController.h
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface MapViewUISettingDemoViewController :  UIViewController <BMKMapViewDelegate>{
    IBOutlet BMKMapView* _mapView;
        
    IBOutlet UISwitch *_zoomSwitch;
    IBOutlet UISwitch *_moveSwitch;    
    IBOutlet UISwitch *_scaleSwith;    
    IBOutlet UISegmentedControl *_compassSeg;
    
}
- (IBAction)zoomSwitchAction:(UISwitch *)sender;
- (IBAction)moveSwitchAction:(UISwitch *)sender;
- (IBAction)scaleSwitchAction:(UISwitch *)sender;
- (IBAction)allGestureEnableAction:(UISwitch *)sender;


- (IBAction)compassSegAction:(UISegmentedControl *)sender;

@end
