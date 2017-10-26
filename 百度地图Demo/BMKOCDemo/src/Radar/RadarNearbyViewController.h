//
//  RadarNearbyViewController.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/5/7.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadarNearbyViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segControl;
@property (weak, nonatomic) IBOutlet UILabel *curPageLabel;
@property (weak, nonatomic) IBOutlet UIButton *preButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;


- (IBAction)nearbyAction:(id)sender;
- (IBAction)clearAction:(id)sender;
- (IBAction)switchResShowAction:(id)sender;
- (IBAction)prePageAction:(id)sender;
- (IBAction)nextPageAction:(id)sender;

@end
