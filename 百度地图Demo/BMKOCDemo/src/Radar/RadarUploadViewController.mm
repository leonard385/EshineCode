//
//  RadarUploadViewController.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 15/5/7.
//  Copyright (c) 2015年 Baidu. All rights reserved.
//

#import "RadarUploadViewController.h"
#import <BaiduMapAPI_Map/BMKMapComponent.h>
#import <BaiduMapAPI_Location/BMKLocationComponent.h>
#import <BaiduMapAPI_Radar/BMKRadarComponent.h>
#import "PromptInfo.h"

@interface RadarUploadViewController ()<BMKLocationServiceDelegate, BMKRadarManagerDelegate> {
    BMKLocationService *_locServer;
    BMKRadarManager *_radarManager;
    CLLocationCoordinate2D _curLocation;
    BOOL isAutoUploading;
    NSLock *lock;
}

@end

@implementation RadarUploadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = @"周边雷达-上传";
    self.tabBarItem.title = @"上传位置";
    lock = [[NSLock alloc] init];
    
    _radarManager = [BMKRadarManager getRadarManagerInstance];
    _locServer = [[BMKLocationService alloc] init];
    _locServer.delegate = self;
    [_locServer startUserLocationService];
    _autoUploadButton.enabled = YES;
    _stopUploadButton.enabled = NO;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hiddenKeyBoard)];
    [self.view addGestureRecognizer:tap];
    
}

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_radarManager addRadarManagerDelegate:self];//添加radar delegate
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_radarManager removeRadarManagerDelegate:self];//不用需移除，否则影响内存释放
}

- (void) dealloc {
    _radarManager = nil;
    [BMKRadarManager releaseRadarManagerInstance];
    _locServer.delegate = nil;
    _locServer = nil;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)hiddenKeyBoard {
    [_userTextField resignFirstResponder];
    [_infoTextField resignFirstResponder];
}

///上传我的位置信息
- (IBAction)uploadAction:(id)sender {
    [self hiddenKeyBoard];
    BOOL res = [_radarManager uploadInfoRequest:[self getCurrInfo]];
    if (res) {
        NSLog(@"upload 成功");
    } else {
        NSLog(@"upload 失败");
    }
}

///启动自动上传
- (IBAction)autoUploadAction:(id)sender {
    [self hiddenKeyBoard];
    [_radarManager startAutoUpload:5];
    isAutoUploading = YES;
    _autoUploadButton.enabled = NO;
    _stopUploadButton.enabled = YES;

}

///停止自动上传
- (IBAction)stopAutoUploadAction:(id)sender {
    [self hiddenKeyBoard];
    [_radarManager stopAutoUpload];
    isAutoUploading = NO;
    _autoUploadButton.enabled = YES;
    _stopUploadButton.enabled = NO;
}

///清除我的位置信息
- (IBAction)clearAction:(id)sender {
    [self hiddenKeyBoard];
    BOOL res = [_radarManager clearMyInfoRequest];
    if (res) {
        NSLog(@"clear 成功");
    } else {
        NSLog(@"clear 失败");
    }
}

///userId编辑完毕
- (IBAction)userIdTextEditEnd:(id)sender {
    if (_userTextField.text && _userTextField.text.length > 0) {
        if (![_radarManager.userId isEqualToString:_userTextField.text]) {
            _radarManager.userId = _userTextField.text;
        }
    }
}

///获取当前的信息
- (BMKRadarUploadInfo *)getCurrInfo {
    BMKRadarUploadInfo *info = [[BMKRadarUploadInfo alloc] init];
    info.extInfo = _infoTextField.text;
    [lock lock];
    info.pt = _curLocation;
    [lock unlock];
    return info;
}

#pragma mark - BMKRadarManagerDelegate

/*
 *开启自动上传，需实现该回调
 */
- (BMKRadarUploadInfo *)getRadarAutoUploadInfo {
    return [self getCurrInfo];
}

/**
 *返回雷达 上传结果
 *@param error 错误号，@see BMKRadarErrorCode
 */
- (void)onGetRadarUploadResult:(BMKRadarErrorCode) error {
    NSLog(@"onGetRadarUploadResult  %d", error);
    if (error == BMK_RADAR_NO_ERROR) {
        [PromptInfo showText:@"成功上传我的位置"];
    }
}

/**
 *返回雷达 清除我的信息结果
 *@param error 错误号，@see BMKRadarErrorCode
 */
- (void)onGetRadarClearMyInfoResult:(BMKRadarErrorCode) error {
    NSLog(@"onGetRadarClearMyInfoResult  %d", error);
    if (error == BMK_RADAR_NO_ERROR) {
        [PromptInfo showText:@"成功清除我的位置"];
    }
}

#pragma mark - BMKLocationServiceDelegate

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
//    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    [[NSNotificationCenter defaultCenter] postNotificationName:MY_LOCATION_UPDATE_NOTIFICATION object:nil userInfo:@{@"loc" : userLocation}];
    [lock lock];
    _curLocation.latitude = userLocation.location.coordinate.latitude;
    _curLocation.longitude = userLocation.location.coordinate.longitude;
    [lock unlock];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


@end
