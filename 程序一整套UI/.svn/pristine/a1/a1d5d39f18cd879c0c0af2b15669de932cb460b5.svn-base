//
//  BSEBMKLocationMannager.h
//  BSEM
//
//  Created by 逸信Mac on 16/6/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaiDuKitHeader.h"

typedef void(^BMKgetCityBlock)(NSString *city);
typedef void(^BMKgetLocationBlock)(NSString *location);
typedef void(^BMKgetCoordinateBlock)(CLLocationCoordinate2D Coordinate);

@interface BSEBMKLocationMannager : NSObject
@property(nonatomic,strong)BMKLocationService *LocationMannager;

@property(nonatomic,strong)BMKGeoCodeSearch *GeoCodeSearch;

@property(nonatomic,copy)BMKgetCoordinateBlock GetCoordinate;
@property(nonatomic,copy)BMKgetCityBlock getCity;
@property(nonatomic,copy)BMKgetLocationBlock getLocation;
+(instancetype)shareMannager;

-(void)setGetCoordinate:(BMKgetCoordinateBlock)GetCoordinate;
-(void)setGetCity:(BMKgetCityBlock)getCity;
-(void)setGetLocation:(BMKgetLocationBlock)getLocation;


-(void)setGetCoordinate:(BMKgetCoordinateBlock)GetCoordinate GetCity:(BMKgetCityBlock)getCity GetLocation:(BMKgetLocationBlock)getLocation;

-(void)setGetCity:(BMKgetCityBlock)getCity GetLocation:(BMKgetLocationBlock)getLocation withLocation:(CLLocationCoordinate2D)Coordinate;
@end
