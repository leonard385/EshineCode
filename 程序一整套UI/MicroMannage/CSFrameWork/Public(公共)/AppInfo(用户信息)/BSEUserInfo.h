//
//  BSEUserInfo.h
//  BSEM
//
//  Created by 逸信Mac on 16/3/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface BSEUserInfo : NSObject
//用户名称
@property(nonatomic,strong)NSString *userName;
//密码
@property(nonatomic,strong)NSString *PassWord;
//用户名
@property(nonatomic,strong)NSString *userCode;
//sessionID
@property(nonatomic,strong)NSString *sessionID;

//定位地址
@property(nonatomic,strong)NSString *Location;
@property(nonatomic,strong)NSNumber *Lat;
@property(nonatomic,strong)NSNumber *log;
@property(nonatomic,assign)CLLocationCoordinate2D Coordinate;
@property(nonatomic,assign)CLLocationCoordinate2D CompanyCoor;
@property(nonatomic,strong)NSString *City;

//网络连接状态

@property(nonatomic,assign)AFNetworkReachabilityStatus NetworkStatus;

+(instancetype)shareMannager;
-(instancetype)initWithDic:(NSDictionary *)Dic;

@end
