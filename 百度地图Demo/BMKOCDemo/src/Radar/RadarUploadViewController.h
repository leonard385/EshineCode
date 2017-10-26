//
//  RadarUploadViewController.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/5/7.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MY_LOCATION_UPDATE_NOTIFICATION @"MY_LOCATION_UPDATE_NOTIFICATION"

@interface RadarUploadViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *userTextField;
@property (weak, nonatomic) IBOutlet UITextField *infoTextField;
@property (weak, nonatomic) IBOutlet UIButton *autoUploadButton;
@property (weak, nonatomic) IBOutlet UIButton *stopUploadButton;


- (IBAction)uploadAction:(id)sender;
- (IBAction)autoUploadAction:(id)sender;
- (IBAction)stopAutoUploadAction:(id)sender;
- (IBAction)clearAction:(id)sender;
- (IBAction)userIdTextEditEnd:(id)sender;

@end
