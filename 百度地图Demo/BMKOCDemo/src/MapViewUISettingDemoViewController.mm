//
//  MapViewUISettingDemoViewController.m
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-24.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "MapViewUISettingDemoViewController.h"

@implementation MapViewUISettingDemoViewController
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    _mapView.showMapScaleBar = NO;
    _scaleSwith.on = NO;
    _mapView.overlooking = -30;
    _mapView.frame = CGRectMake(0, _mapView.frame.origin.y, _mapView.frame.size.width, self.view.frame.size.height - _mapView.frame.origin.y);
    [self setMapPadding];
}

-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}

- (void)setMapPadding {
    ///地图预留边界，默认：UIEdgeInsetsZero。设置后，会根据mapPadding调整logo、比例尺、指南针的位置，以及targetScreenPt(BMKMapStatus.targetScreenPt)
    _mapView.mapPadding = UIEdgeInsetsMake(0, 0, 28, 0);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, _mapView.frame.origin.y + _mapView.frame.size.height - 92, self.view.frame.size.width, 28)];
    label.text = @"已设置mapPadding为(0, 0, 28, 0)";
    label.font = [UIFont systemFontOfSize:13];
    label.textAlignment = NSTextAlignmentCenter;
    label.backgroundColor = [UIColor whiteColor];
    label.alpha = 0.7;
    [self.view addSubview:label];
    [self.view bringSubviewToFront:label];
}

#pragma mark 底图手势开关

- (IBAction)zoomSwitchAction:(UISwitch *)sender {
    UISwitch *tempSwitch = (UISwitch *)sender;
    _mapView.zoomEnabled = [tempSwitch isOn];
}

- (IBAction)moveSwitchAction:(UISwitch *)sender {
    UISwitch *tempSwitch = (UISwitch *)sender;
    _mapView.scrollEnabled = [tempSwitch isOn];
}

- (IBAction)scaleSwitchAction:(UISwitch *)sender {
    UISwitch *tempSwitch = (UISwitch *)sender;
    _mapView.showMapScaleBar = [tempSwitch isOn];
    //自定义比例尺的位置
    _mapView.mapScaleBarPosition = CGPointMake(_mapView.frame.size.width - 70, _mapView.frame.size.height - 68);
}

- (IBAction)allGestureEnableAction:(UISwitch *)sender {
    _mapView.gesturesEnabled = [sender isOn];
}

#pragma mark - 指南针位置

- (IBAction)compassSegAction:(UISegmentedControl *)sender {
    UISegmentedControl *tempSeg = (UISegmentedControl *)sender;
    CGPoint pt;
    if(tempSeg.selectedSegmentIndex==0)
    {
        pt = CGPointMake(10,10);
    }
    else
    {
        pt = CGPointMake(273,10);
    }
    [_mapView setCompassPosition:pt];

}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
@end
