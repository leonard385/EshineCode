//
//  BSEBaseSQL.h
//  BSEM
//
//  Created by 逸信Mac on 16/3/15.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "BSEBaseStationModel.h"
@interface BSEBaseSQL : NSObject
@end


@interface BSEBaseSQL()

@property (nonatomic,strong) FMDatabaseQueue *databaseQueue;

+ (void)createTablesNeeded;
+(instancetype)ShareMannger;
-(void)insertData:(BSEBaseStationModel *)model;
- (void)intsertStationData:(NSArray *)dataArray;
- (NSMutableArray *)getAllKeywords;
-(NSMutableArray *)getAll4GStationDate;
-(NSMutableArray *)getAllBaseStationDate;

- (BOOL)deleteKeywordFromDB:(NSString *)keyword;
- (BOOL)deleteAllSearchKeywordsFromDB;
- (BOOL)deleteAll4GStationDate;
- (BOOL)deleteAllBaseStationDate;

- (BOOL)isContainKeyword:(NSString *)keyword;
- (BSEBaseStationModel *)queryStationIDFromDB:(NSString *)stationId;
////////更新基站告警状态
-(void)UpdateState:(NSString*)state WhereId:(NSNumber *)IDNum;
-(void)UpdateDefaultState;

- (NSMutableArray *)queryDateWithStationName:(NSString *)stationName;
- (NSMutableArray *)queryDateWithGSMStationName:(NSString *)stationName;
- (NSMutableArray *)queryDateWithLTEStationName:(NSString *)stationName;
- (NSMutableArray *)queryDateWithSQL:(NSString *)sql;
//数据查询语句
-(NSMutableArray *)queryDateDoor:(NSString *)indoor district:(NSString*)districtname agent:(NSString *)agentname level:(NSString *)Levelname  manager:(NSString *)managerName;

//获取范围内的数据
-(NSMutableArray *)GetStationDateWithMinlon:(NSNumber *)Minlonstr maxlon:(NSNumber *)maxlonstr MinLat:(NSNumber *)MinLatstr MaxLat:(NSNumber *)MaxLatstr;

@end

