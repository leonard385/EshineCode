//
//  TileLayerDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/10/10.
//  Copyright © 2015年 Baidu. All rights reserved.
//

#ifndef TileLayerDemoViewController_h
#define TileLayerDemoViewController_h

#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface TileLayerDemoViewController : UIViewController<BMKMapViewDelegate>

@property (weak, nonatomic) IBOutlet BMKMapView *mapView;

- (IBAction)segmentAction:(id)sender;

@end

#endif /* TileLayerDemoViewController_h */
