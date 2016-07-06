//
//  BaiduWeekWeatherModel.h
//  BSEM
//
//  Created by 逸信Mac on 16/3/9.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaiduWeekWeatherModel : NSObject
//---------------原数据-------------------//
//日期
@property(nonatomic,copy)NSString * date;//示例："周三 03月09日 (实时：18℃)"
//早上上天气图片
@property (nonatomic, copy) NSString *dayPictureUrl;

//晚上天气图片
@property (nonatomic, copy) NSString *nightPictureUrl;

//天气
@property (nonatomic, copy) NSString *weather;

//风向
@property (nonatomic, copy) NSString *wind;

//温度
@property (nonatomic, copy) NSString *temperature;

//---------------增加的数据-------------------//
//最高温度
@property (nonatomic, copy) NSString *H_temp;

//最低温度
@property (nonatomic, copy) NSString *L_temp;

//当前温度
@property (nonatomic, copy) NSString *C_temp;

- (instancetype)initWithDict:(NSDictionary *)dict;

@end
