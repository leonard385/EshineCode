//
//  BSELocationTool.h
//  BSEM
//
//  Created by 逸信Mac on 16/3/25.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "INTULocationManager.h"
typedef void(^getCityBlock)(NSString *city);
typedef void(^getLocationBlock)(NSString *location);
typedef void(^getCoordinateBlock)(CLLocationCoordinate2D Coordinate);
@interface BSELocationTool : NSObject

+ (instancetype)shareLocation;
+(void)TransCLLocationTo:(CLLocation *)loc City:(getCityBlock)CityBlock Location:(getLocationBlock)LocationBlock Coordinate:(getCoordinateBlock)CoordinateBlock;
@end
