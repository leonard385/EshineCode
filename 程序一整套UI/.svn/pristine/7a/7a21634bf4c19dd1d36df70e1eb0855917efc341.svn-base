//
//  BSEBMKLocationMannager.m
//  BSEM
//
//  Created by 逸信Mac on 16/6/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "BSEBMKLocationMannager.h"
@interface BSEBMKLocationMannager()<BMKLocationServiceDelegate,BMKGeoCodeSearchDelegate>
@property(nonatomic,assign)bool deferringUpdates;
@end
@implementation BSEBMKLocationMannager

+(instancetype)shareMannager
{
    static BSEBMKLocationMannager *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[[self class]alloc]init];
    });
    return share;
}
-(instancetype)init
{
    self = [super init];
    if(self != nil){
        _LocationMannager = [[BMKLocationService alloc]init];
        [_LocationMannager setDistanceFilter:5];//设置更新频率
        [_LocationMannager setDesiredAccuracy:kCLLocationAccuracyBestForNavigation];
        
        _LocationMannager.delegate = self;
        
        _GeoCodeSearch =[[BMKGeoCodeSearch alloc]init];
        _GeoCodeSearch.delegate = self;
        
  
    }
    return self;
}


-(void)setGetCoordinate:(BMKgetCoordinateBlock)GetCoordinate
                GetCity:(BMKgetCityBlock)getCity
            GetLocation:(BMKgetLocationBlock)getLocation
{
    self.getCity = getCity;
    self.getLocation = getLocation;
    self.GetCoordinate = GetCoordinate;
    //启动LocationService

    [_LocationMannager startUserLocationService];
}


-(void)setGetCoordinate:(BMKgetCoordinateBlock)GetCoordinate
{
    _GetCoordinate = GetCoordinate;
    //启动LocationService
    [_LocationMannager startUserLocationService];
}

-(void)setGetCity:(BMKgetCityBlock)getCity GetLocation:(BMKgetLocationBlock)getLocation withLocation:(CLLocationCoordinate2D)Coordinate
{
    _getCity = getCity;
    _getLocation = getLocation;
    
    //发起反向地理编码检索
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = Coordinate;
    BOOL flag = [_GeoCodeSearch reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }

}


//实现相关delegate 处理位置信息更新
//处理方向变更信息
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //NSLog(@"heading is %@",userLocation.heading);
}

-(void)didFailToLocateUserWithError:(NSError *)error
{
    
}

//处理位置坐标更新
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    
    if(_GetCoordinate){
        self.GetCoordinate(userLocation.location.coordinate);
    }
    
    //发起反向地理编码检索
    BMKReverseGeoCodeOption *reverseGeoCodeSearchOption = [[
                                                            BMKReverseGeoCodeOption alloc]init];
    reverseGeoCodeSearchOption.reverseGeoPoint = userLocation.location.coordinate;
    BOOL flag = [_GeoCodeSearch reverseGeoCode:reverseGeoCodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
     [_LocationMannager stopUserLocationService];
}


//定位数据问题

//接收反向地理编码结果
-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher
                           result:(BMKReverseGeoCodeResult *)result
                        errorCode:(BMKSearchErrorCode)error
{
  if (error == BMK_SEARCH_NO_ERROR) {
      //在此处理正常结果
      
      if(_getCity){
          self.getCity(result.addressDetail.city);
      }
    
      if(_getLocation){
          self.getLocation(result.address);
      }
    
      
  }
  else {
      NSLog(@"抱歉，未找到结果");
  }
}
@end
