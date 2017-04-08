//
//  MMEmployStatisticModel.h
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MMEmployStatisticModel : NSObject
@property(nonatomic,strong)NSString *district;//区域
@property(nonatomic,strong)NSNumber *totalNum;//总人数
@property(nonatomic,strong)NSNumber *leaveNum;//离职人数
@property(nonatomic,strong)NSNumber *addNum;//新增人数
@property(nonatomic,strong)NSNumber *leavePercent;//离职率


@end
