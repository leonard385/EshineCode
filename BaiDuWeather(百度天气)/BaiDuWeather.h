//
//  BaiDuWeather.h
//  BSEM
//
//  Created by 逸信Mac on 16/3/9.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^DWSuccessBlock)(id json);
typedef void(^DWerrorBlock)(id error);
@interface BaiDuWeather : NSObject
+(void)GetWeatherInfoForCity:(NSString*)CityName Success:(DWSuccessBlock)successblock error:(DWerrorBlock)errorblock;

+(void)GetWeekWeatherInfoForCity:(NSString*)CityName Success:(DWSuccessBlock)successblock error:(DWerrorBlock)errorblock;
@end
