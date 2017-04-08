//
//  BSELocationTool.m
//  BSEM
//
//  Created by 逸信Mac on 16/3/25.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "BSELocationTool.h"

@implementation BSELocationTool
static BSELocationTool *_instance;
+ (instancetype)shareLocation{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[self alloc] init];
    });
    return _instance;
}


+(void)TransCLLocationTo:(CLLocation *)loc City:(getCityBlock)CityBlock Location:(getLocationBlock)LocationBlock Coordinate:(getCoordinateBlock)CoordinateBlock//反地理编码
{
CLGeocoder *geocoder = [[CLGeocoder alloc] init];
[geocoder reverseGeocodeLocation:loc completionHandler:^(NSArray *placemarks, NSError *error) {
    if (placemarks.count) {
        //获取当前城市
        CLPlacemark *mark = placemarks.firstObject;
        NSDictionary *dict = [mark addressDictionary];
        NSString *city = [dict objectForKey:@"City"];
        //城市
        if (CityBlock) {
            CityBlock(city);
        }
        
        //坐标
        if(CoordinateBlock){
            CoordinateBlock(mark.location.coordinate);
        }
        
        //位置信息
        if (LocationBlock) {
            LocationBlock(mark.name);
        }
    }
}];
}

@end
