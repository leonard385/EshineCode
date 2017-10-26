//
//  OfflineDemoMapViewController.m
//  BaiduMapSdkSrc
//
//  Created by BaiduMapAPI on 13-7-22.
//  Copyright (c) 2013年 baidu. All rights reserved.
//

#import "OfflineDemoMapViewController.h"

@implementation OfflineDemoMapViewController
@synthesize cityId;
@synthesize offlineServiceOfMapview;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //适配ios7
    if( ([[[UIDevice currentDevice] systemVersion] doubleValue]>=7.0))
    {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
        self.navigationController.navigationBar.translucent = NO;
    }
    //初始化右边的更新按钮
    UIBarButtonItem *customRightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"更新" style:UIBarButtonItemStyleBordered target:self action:@selector(update)];
    customRightBarButtonItem.title = @"更新";
    self.navigationItem.rightBarButtonItem = customRightBarButtonItem;
    
    //显示当前某地的离线地图
    _mapView = [[BMKMapView alloc]init];
    _mapView.frame = CGRectMake(0, 0, 320, 480);
    [self.view addSubview:_mapView];
    BMKOLUpdateElement* localMapInfo;
    localMapInfo = [offlineServiceOfMapview getUpdateInfo:cityId];
    [_mapView setCenterCoordinate:localMapInfo.pt];
    
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


-(void)viewWillAppear:(BOOL)animated {
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
}

-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
}

- (void)dealloc {
    if (_mapView) {
        _mapView = nil;
    }
}
- (void)update
{
    [offlineServiceOfMapview update:cityId];
    NSLog(@"离线地图更新");
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
