//
//  BSEBaseSQL.m
//  BSEM
//
//  Created by 逸信Mac on 16/3/15.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "BSEBaseSQL.h"
#import "DatabaseManager.h"
#import "BSEBaseStationModel.h"

#define KtableName @"Base"
#import "PathConstant.h"
#define Path [DatabaseDirectory() stringByAppendingPathComponent:kDatabaseFileName]

@interface BSEBaseSQL()

@end

@implementation BSEBaseSQL
+(instancetype)ShareMannger
{
    static BSEBaseSQL *Mannger = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Mannger = [[[self class]alloc]init];
    });
    return Mannger;
}
+ (void)createTablesNeeded{
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
        NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' (vipLevel TEXT, agent TEXT, site TEXT, manager TEXT,level TEXT, district TEXT, name TEXT,indoor TEXT,lon TEXT, lat TEXT, StationID TEXT PRIMARY KEY, status TEXT default 'alarm_kind0', netKind TEXT)",KtableName];
        BOOL res = [db executeUpdate:sqlCreateTable];
        if (!res) {
            NSLog(@"建表失败");
        } else {
            NSLog(@"建表成功");
            [db close];
        }}
        else {
            NSLog(@"error when open db");
        }
    
}

- (void)intsertStationData:(NSArray *)dataArray
{
    self.databaseQueue = [FMDatabaseQueue databaseQueueWithPath:Path];
    
    [self.databaseQueue inDatabase:^(FMDatabase *db) {
        
        [db open];
        [db setShouldCacheStatements:YES];
        
        NSString *  insertSql1= [NSString stringWithFormat:
                                 @"INSERT INTO '%@' (vipLevel, agent, site,level,manager,district,name,indoor,lon,lat,StationID,netKind) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
                                 KtableName];
        [db beginTransaction];
        
        for (NSDictionary *Basedic in dataArray) {
            
            double latModify =  [Basedic[@"lat"] doubleValue]+ 0.00328;
            double lonModify =  [Basedic[@"lon"] doubleValue]+ 0.01185;
            
            [db executeUpdate:insertSql1,
             Basedic[@"vipLevel"],
             Basedic[@"agent"],
             Basedic[@"site"],
             Basedic[@"level"],
             Basedic[@"manager"],
             Basedic[@"district"],
             Basedic[@"name"],
             Basedic[@"inDoor"],
             [NSString stringWithFormat:@"%f",lonModify],
             [NSString stringWithFormat:@"%f",latModify],
             Basedic[@"id"],
             Basedic[@"netKind"]
            ];
        }
        
        
        [db commit];
        [db close];
        
    }];
}

/**
 *  插入数据
 *
 *  @param model BSEBaseStationModel
 */
-(void)insertData:(BSEBaseStationModel *)model
{
    NSString *insertSql1 = [NSString new];
    if([self isContainKeyword:[NSString stringWithFormat:@"%u",[model.StationID unsignedIntValue]]]){//数据存在
        return;
    }else{
        insertSql1= [NSString stringWithFormat:
                     @"INSERT INTO '%@' (vipLevel, agent, site,level,manager,district,name,indoor,lon,lat,StationID,netKind) VALUES (?,?,?,?,?,?,?,?,?,?,?,?)",
                     KtableName];
    }
//    FMDatabase * db = [FMDatabase databaseWithPath:Path];
   FMDatabaseQueue *databaseQueue = [FMDatabaseQueue databaseQueueWithPath:Path];
    [databaseQueue inDatabase:^(FMDatabase *db) {
        if ([db open]) {
            
            BOOL res = [db executeUpdate:insertSql1,
                        model.vipLevel,
                        model.agent,
                        model.site,
                        model.level,
                        model.manager,
                        model.district,
                        model.name,
                        model.indoor,
                        [NSString stringWithFormat:@"%f",[model.lon doubleValue]],
                        [NSString stringWithFormat:@"%f",[model.lat doubleValue]],
                        [NSString stringWithFormat:@"%lu",(unsigned long)[model.StationID unsignedIntegerValue]],
                        model.netKind];
            
            if (!res) {
                NSLog(@"error when insert db table");
            } else {
                NSLog(@"success to insert db table");
            }
            [db close];
        }
    }];
    }

/**
 *  删除所有数据
 *
 *  @param model BSEBaseStationModel
 */
- (BOOL)deleteAllSearchKeywordsFromDB
{
    __block BOOL isSuccess;
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
        
        if([db open]){
        NSString *sql = [NSString stringWithFormat:@"delete from %@", KtableName];
        
        isSuccess = [db executeUpdate:sql];
        
            [db close];
        }
    }
    return isSuccess;
}

- (BOOL)deleteAllBaseStationDate
{
    __block BOOL isSuccess;
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
        
        if([db open]){
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where netkind = ?", KtableName];
            
            isSuccess = [db executeUpdate:sql,@"GSM"];
            
            [db close];
        }
    }
    return isSuccess;
}

- (BOOL)deleteAll4GStationDate
{
    __block BOOL isSuccess;
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
        
        if([db open]){
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where netkind = ?", KtableName];
            
            isSuccess = [db executeUpdate:sql,@"LTE"];
            
            [db close];
        }
    }
    return isSuccess;
}

- (NSMutableArray *)getAllKeywords
{
    __block NSMutableArray *dataTemp = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
            NSString * sql = [NSString stringWithFormat:
                              @"SELECT * FROM %@",KtableName];
            FMResultSet * resultSet = [db executeQuery:sql];
            while ([resultSet next]) {
                BSEBaseStationModel *model = [[BSEBaseStationModel alloc]init];
                model.vipLevel = [resultSet stringForColumn:@"vipLevel"];
                model.agent = [resultSet stringForColumn:@"agent"];
                model.site = [resultSet stringForColumn:@"site"];
                model.manager = [resultSet stringForColumn:@"manager"];
                model.level = [resultSet stringForColumn:@"level"];
                model.district = [resultSet stringForColumn:@"district"];
                model.name = [resultSet stringForColumn:@"name"];
                model.indoor = @([resultSet boolForColumn:@"indoor"]);
                model.lon = [NSNumber numberWithDouble:[resultSet doubleForColumn:@"lon"]];
                model.lat = [NSNumber numberWithDouble:[resultSet doubleForColumn:@"lat"]];
                model.netKind = [resultSet stringForColumn:@"netKind"];
                model.StationID = [NSNumber numberWithLong:[resultSet longForColumn:@"StationID"]];
                model.status = [resultSet stringForColumn:@"status"];
                [dataTemp addObject:model];
            }
            [db close];
        }
    return  dataTemp;
    
}

-(NSMutableArray *)getAllBaseStationDate
{
    __block NSMutableArray *dataTemp = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@ where netkind = ?",KtableName];
        FMResultSet * resultSet = [db executeQuery:sql,@"GSM"];
        while ([resultSet next]) {
            BSEBaseStationModel *model = [[BSEBaseStationModel alloc]init];
            model.vipLevel = [resultSet stringForColumn:@"vipLevel"];
            model.agent = [resultSet stringForColumn:@"agent"];
            model.site = [resultSet stringForColumn:@"site"];
            model.manager = [resultSet stringForColumn:@"manager"];
            model.level = [resultSet stringForColumn:@"level"];
            model.district = [resultSet stringForColumn:@"district"];
            model.name = [resultSet stringForColumn:@"name"];
            model.indoor = @([resultSet boolForColumn:@"indoor"]);
            model.lon = [NSNumber numberWithDouble:[resultSet doubleForColumn:@"lon"]];
            model.lat = [NSNumber numberWithDouble:[resultSet doubleForColumn:@"lat"]];
            model.netKind = [resultSet stringForColumn:@"netKind"];
            model.StationID = [NSNumber numberWithLong:[resultSet longForColumn:@"StationID"]];
            model.status = [resultSet stringForColumn:@"status"];
            [dataTemp addObject:model];
        }
        [db close];
    }
    return  dataTemp;
}

-(NSMutableArray *)getAll4GStationDate
{
    __block NSMutableArray *dataTemp = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@ where netkind = ?",KtableName];
        FMResultSet * resultSet = [db executeQuery:sql,@"LTE"];
        while ([resultSet next]) {
            BSEBaseStationModel *model = [[BSEBaseStationModel alloc]init];
            model.vipLevel = [resultSet stringForColumn:@"vipLevel"];
            model.agent = [resultSet stringForColumn:@"agent"];
            model.site = [resultSet stringForColumn:@"site"];
            model.manager = [resultSet stringForColumn:@"manager"];
            model.level = [resultSet stringForColumn:@"level"];
            model.district = [resultSet stringForColumn:@"district"];
            model.name = [resultSet stringForColumn:@"name"];
            model.indoor = @([resultSet boolForColumn:@"indoor"]);
            model.lon = [NSNumber numberWithDouble:[resultSet doubleForColumn:@"lon"]];
            model.lat = [NSNumber numberWithDouble:[resultSet doubleForColumn:@"lat"]];
            model.netKind = [resultSet stringForColumn:@"netKind"];
            model.StationID = [NSNumber numberWithLong:[resultSet longForColumn:@"StationID"]];
            model.status = [resultSet stringForColumn:@"status"];
            [dataTemp addObject:model];
        }
        [db close];
    }
    return  dataTemp;
}



- (BOOL)deleteKeywordFromDB:(NSString *)keyword
{
    if (IsNilOrNull(keyword)) {
        return NO;
    }
    
    __block BOOL isSuccess;
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
            NSString *sql = [NSString stringWithFormat:@"delete from %@ where StationID = ?",KtableName];
            
            isSuccess = [db executeUpdate:sql,keyword];
        }
        [db close];
    return isSuccess;
}

- (BOOL)isContainKeyword:(NSString *)keyword
{
    __block BOOL isContain = NO;
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
            
            NSString *sql = [NSString stringWithFormat:@"select * from %@ where StationID = ?",KtableName];
            
            FMResultSet *rs = [db executeQuery:sql, keyword];
            
            if (!rs) {
                [rs close];
                return 0;
            }
            while ([rs next]) {
                isContain = YES;
            }
            [rs close];
        }
        [db close];
    return isContain;
}

- (BSEBaseStationModel *)queryStationIDFromDB:(NSString *)stationId
{
    
    BSEBaseStationModel * model = [[BSEBaseStationModel alloc] init];
    
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
            NSString *sql = [NSString stringWithFormat:@"select * from %@ where StationID = ?",KtableName];
            
            FMResultSet *rs = [db executeQuery:sql, stationId];
            
            if (!rs) {
                [rs close];
                return 0;
            }

            while ([rs next]) {

//                model = [[BSEBaseStationModel alloc]init];
                model.vipLevel = [rs stringForColumn:@"vipLevel"];
                model.agent = [rs stringForColumn:@"agent"];
                model.site = [rs stringForColumn:@"site"];
                model.manager = [rs stringForColumn:@"manager"];
                model.level = [rs stringForColumn:@"level"];
                model.district = [rs stringForColumn:@"district"];
                model.name = [rs stringForColumn:@"name"];
                model.indoor = @([rs boolForColumn:@"indoor"]);
                model.lon = [NSNumber numberWithDouble:[rs doubleForColumn:@"lon"]];
                model.lat = [NSNumber numberWithDouble:[rs doubleForColumn:@"lat"]];
                model.netKind = [rs stringForColumn:@"netKind"];
                model.StationID = [NSNumber numberWithLong:[rs longForColumn:@"StationID"]];
                model.status = [rs stringForColumn:@"status"];
            }
            
            [rs close];
        }
    return model;
}

- (NSMutableArray *)queryDateWithStationName:(NSString *)stationName
{
    
    __block NSMutableArray*DBDateArray = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
            //模糊查询
            NSString *sql = [NSString stringWithFormat:@"select * from %@ where name like '%%%@%%'",KtableName, stationName];
            
            FMResultSet *rs = [db executeQuery:sql];
            
            if (!rs) {
                [rs close];
                return 0;
            }
            
            
            while ([rs next]) {
                BSEBaseStationModel *model = [[BSEBaseStationModel alloc]init];
                model.vipLevel = [rs stringForColumn:@"vipLevel"];
                model.agent = [rs stringForColumn:@"agent"];
                model.site = [rs stringForColumn:@"site"];
                model.manager = [rs stringForColumn:@"manager"];
                model.level = [rs stringForColumn:@"level"];
                model.district = [rs stringForColumn:@"district"];
                model.name = [rs stringForColumn:@"name"];
                model.indoor = @([rs boolForColumn:@"indoor"]);
                model.lon = [NSNumber numberWithDouble:[rs doubleForColumn:@"lon"]];
                model.lat = [NSNumber numberWithDouble:[rs doubleForColumn:@"lat"]];
                model.netKind = [rs stringForColumn:@"netKind"];
                model.StationID = [NSNumber numberWithLong:[rs longForColumn:@"StationID"]];
                model.status = [rs stringForColumn:@"status"];
                [DBDateArray addObject:model];
                
            }
            
            [rs close];
        }
    return DBDateArray;

}

#pragma  mark - 更新基站告警状态
-(void)UpdateState:(NSString*)state WhereId:(NSNumber *)IDNum
{
    NSString *insertSql1 = [NSString new];
    if([self isContainKeyword:[IDNum stringValue]]){
        insertSql1= [NSString stringWithFormat:
                     @"update '%@' set status = ? where StationID = ?",
                     KtableName];
        FMDatabase * db = [FMDatabase databaseWithPath:Path];
        if ([db open]) {
            BOOL res = [db executeUpdate:insertSql1,state,IDNum];
            
            if (!res) {
                NSLog(@"error when update db table");
            } else {
                NSLog(@"success to update db table");
            }
            [db close];
        }}else{
            NSLog(@"没有此ID:%@",[IDNum stringValue]);
        }
    
}

//将所有状态设置为正常
-(void)UpdateDefaultState
{
    NSString *insertSql1 = [NSString new];
    insertSql1= [NSString stringWithFormat:@"update '%@' set status = 'alarm_kind0'",KtableName];
    
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    
    if ([db open]) {
        BOOL res = [db executeUpdate:insertSql1];
        
        if (!res) {
            NSLog(@"error when update db table");
        } else {
            NSLog(@"success to update db table");
        }
        [db close];
    }
}


#pragma mark - 查询4G基站数据
- (NSMutableArray *)queryDateWithLTEStationName:(NSString *)stationName
{
    NSMutableArray *DBDateArray = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    
    if ([db open]) {
        //模糊查询
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where name like '%%%@%%' and netKind = ?",KtableName, stationName];
        
        FMResultSet *rs = [db executeQuery:sql,@"LTE"];
        
        while ([rs next]) {
            BSEBaseStationModel *model = [[BSEBaseStationModel alloc]init];
            model.vipLevel = [rs stringForColumn:@"vipLevel"];
            model.agent = [rs stringForColumn:@"agent"];
            model.site = [rs stringForColumn:@"site"];
            model.manager = [rs stringForColumn:@"manager"];
            model.level = [rs stringForColumn:@"level"];
            model.district = [rs stringForColumn:@"district"];
            model.name = [rs stringForColumn:@"name"];
            model.indoor = @([rs boolForColumn:@"indoor"]);
            model.lon = [NSNumber numberWithDouble:[rs doubleForColumn:@"lon"]];
            model.lat = [NSNumber numberWithDouble:[rs doubleForColumn:@"lat"]];
            model.netKind = [rs stringForColumn:@"netKind"];
            model.StationID = [NSNumber numberWithLong:[rs longForColumn:@"StationID"]];
            model.status = [rs stringForColumn:@"status"];
            [DBDateArray addObject:model];
        }
        
        [db close];
    }
    
    return DBDateArray;
}

#pragma mark - 查询2g的数据
- (NSMutableArray *)queryDateWithGSMStationName:(NSString *)stationName
{
    
    NSMutableArray *DBDateArray = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    
    if ([db open]) {
        //模糊查询
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where name like '%%%@%%' and netKind = ?",KtableName, stationName];
        
        FMResultSet *rs = [db executeQuery:sql,@"GSM"];
        
        while ([rs next]) {
            BSEBaseStationModel * model = [[BSEBaseStationModel alloc] init];
            model.vipLevel = [rs stringForColumn:@"vipLevel"];
            model.agent = [rs stringForColumn:@"agent"];
            model.site = [rs stringForColumn:@"site"];
            model.manager = [rs stringForColumn:@"manager"];
            model.level = [rs stringForColumn:@"level"];
            model.district = [rs stringForColumn:@"district"];
            model.name = [rs stringForColumn:@"name"];
            model.indoor = @([rs boolForColumn:@"indoor"]);
            model.lon = [NSNumber numberWithDouble:[rs doubleForColumn:@"lon"]];
            model.lat = [NSNumber numberWithDouble:[rs doubleForColumn:@"lat"]];
            model.netKind = [rs stringForColumn:@"netKind"];
            model.StationID = [NSNumber numberWithLong:[rs longForColumn:@"StationID"]];
            model.status = [rs stringForColumn:@"status"];
            [DBDateArray addObject:model];
        }
        
        [db close];
    }
    
    return DBDateArray;
    
}


-(NSMutableArray *)queryDateDoor:(NSString *)indoor district:(NSString*)districtname agent:(NSString *)agentname level:(NSString *)Levelname  manager:(NSString *)managerName
{
    
    NSMutableArray *DBDateArray = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    
    if ([db open]) {
        //模糊查询
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where indoor = ? and agent = ? and district = ? and level like '%%%@%%' and manager = ?",KtableName,Levelname];
        
        FMResultSet *rs = [db executeQuery:sql,indoor,agentname,districtname,managerName];
        
        while ([rs next]) {
            BSEBaseStationModel * model = [[BSEBaseStationModel alloc] init];
            model.vipLevel = [rs stringForColumn:@"vipLevel"];
            model.agent = [rs stringForColumn:@"agent"];
            model.site = [rs stringForColumn:@"site"];
            model.manager = [rs stringForColumn:@"manager"];
            model.level = [rs stringForColumn:@"level"];
            model.district = [rs stringForColumn:@"district"];
            model.name = [rs stringForColumn:@"name"];
            model.indoor = @([rs boolForColumn:@"indoor"]);
            model.lon = [NSNumber numberWithDouble:[rs doubleForColumn:@"lon"]];
            model.lat = [NSNumber numberWithDouble:[rs doubleForColumn:@"lat"]];
            model.netKind = [rs stringForColumn:@"netKind"];
            model.StationID = [NSNumber numberWithLong:[rs longForColumn:@"StationID"]];
            model.status = [rs stringForColumn:@"status"];
            [DBDateArray addObject:model];
        }
        
        [db close];
    }
    
    return DBDateArray;

    
}

//根据sql语句查询数据
- (NSMutableArray *)queryDateWithSQL:(NSString *)sql
{
    __block NSMutableArray*DBDateArray = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    if ([db open]) {
        
        sql = [NSString stringWithFormat:@"select * from %@ where %@",KtableName,sql];
        
        FMResultSet *rs = [db executeQuery:sql];
        
        if (!rs) {
            [rs close];
            return 0;
        }
        
        while ([rs next]) {
            BSEBaseStationModel * model = [[BSEBaseStationModel alloc] init];
            model.vipLevel = [rs stringForColumn:@"vipLevel"];
            model.agent = [rs stringForColumn:@"agent"];
            model.site = [rs stringForColumn:@"site"];
            model.manager = [rs stringForColumn:@"manager"];
            model.level = [rs stringForColumn:@"level"];
            model.district = [rs stringForColumn:@"district"];
            model.name = [rs stringForColumn:@"name"];
            model.indoor = @([rs boolForColumn:@"indoor"]);
            model.lon = [NSNumber numberWithDouble:[rs doubleForColumn:@"lon"]];
            model.lat = [NSNumber numberWithDouble:[rs doubleForColumn:@"lat"]];
            model.netKind = [rs stringForColumn:@"netKind"];
            model.StationID = [NSNumber numberWithLong:[rs longForColumn:@"StationID"]];
            model.status = [rs stringForColumn:@"status"];

            [DBDateArray addObject:model];
            
        }
        
        [rs close];
    }
    return DBDateArray;
    
}


-(NSMutableArray *)GetStationDateWithMinlon:(NSNumber *)Minlonstr maxlon:(NSNumber *)maxlonstr MinLat:(NSNumber *)MinLatstr MaxLat:(NSNumber *)MaxLatstr
{
    NSMutableArray *DBDateArray = [[NSMutableArray alloc]init];
    FMDatabase * db = [FMDatabase databaseWithPath:Path];
    
    if ([db open]) {
        //模糊查询
        NSString *sql = [NSString stringWithFormat:@"select * from %@ where lon BETWEEN '%@' and '%@' and lat BETWEEN '%@' and  '%@'",KtableName,[Minlonstr stringValue],[maxlonstr stringValue],[MinLatstr stringValue],[MaxLatstr stringValue]];
        FMResultSet *rs = [db executeQuery:sql];
        
        while ([rs next]) {
            BSEBaseStationModel * model = [[BSEBaseStationModel alloc] init];
            model.vipLevel = [rs stringForColumn:@"vipLevel"];
            model.agent = [rs stringForColumn:@"agent"];
            model.site = [rs stringForColumn:@"site"];
            model.manager = [rs stringForColumn:@"manager"];
            model.level = [rs stringForColumn:@"level"];
            model.district = [rs stringForColumn:@"district"];
            model.name = [rs stringForColumn:@"name"];
            model.indoor = @([rs boolForColumn:@"indoor"]);
            model.lon = [NSNumber numberWithDouble:[rs doubleForColumn:@"lon"]];
            model.lat = [NSNumber numberWithDouble:[rs doubleForColumn:@"lat"]];
            model.netKind = [rs stringForColumn:@"netKind"];
            model.StationID = [NSNumber numberWithLong:[rs longForColumn:@"StationID"]];
            model.status = [rs stringForColumn:@"status"];
            [DBDateArray addObject:model];
        }
        
        [db close];
    }
    
    return DBDateArray;
 
}

@end

