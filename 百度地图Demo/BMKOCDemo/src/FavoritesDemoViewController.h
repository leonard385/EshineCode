//
//  FavoritesDemoViewController.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/5/8.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>
#import <BaiduMapAPI_Map/BMKMapComponent.h>


@interface FavoritesDemoViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *coorLabel;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet BMKMapView *mapView;


@property (weak, nonatomic) IBOutlet UIControl *updateView;
@property (weak, nonatomic) IBOutlet UITextField *updateLatTextField;
@property (weak, nonatomic) IBOutlet UITextField *updateLonTextField;
@property (weak, nonatomic) IBOutlet UITextField *updateNameTextField;


- (IBAction)saveAction:(id)sender;
- (IBAction)getAllAction:(id)sender;
- (IBAction)deleteAllAction:(id)sender;
- (IBAction)updateCancelAction:(id)sender;
- (IBAction)updateSaveAction:(id)sender;

@end
