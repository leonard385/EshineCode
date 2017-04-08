//
//  CXDBHandle.m
//  搜索页面的封装
//
//  Created by 蔡翔 on 16/7/28.
//  Copyright © 2016年 蔡翔. All rights reserved.
//

#import "CXDBHandle.h"
#import "FMDatabase.h"

@implementation CXDBHandle
static FMDatabase *_db;

+ (void)initialize
{
    // 1.打开数据库
    NSString *path = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"searchModel.sqlite"];
    _db = [FMDatabase databaseWithPath:path];
    [_db open];
    
    // 2.创表
    [_db executeUpdate:@"CREATE TABLE IF NOT EXISTS t_searchModel (id integer PRIMARY KEY, searchModel blob NOT NULL, searchModel_idstr varchar NOT NULL);"];
}


+ (NSDictionary *)statusesWithParams:(NSDictionary *)params
{
    // 根据请求参数生成对应的查询SQL语句
    NSString *sql = nil;
    if (params[@"category"]) {
        sql = [NSString stringWithFormat:@"SELECT * FROM t_searchModel WHERE searchModel_idstr = %@ ;", params[@"category"]];
    }else{
        sql = @"SELECT * FROM t_searchModel;";
    }
    // 执行SQL
    FMResultSet *set = [_db executeQuery:sql];
    while (set.next) {
        NSData *statusData = [set objectForColumnName:@"searchModel"];
        NSDictionary *status = [NSKeyedUnarchiver unarchiveObjectWithData:statusData];
        return status;
    }
    return @{};
}


+ (void)saveStatuses:(NSDictionary *)statuses andParam:(NSDictionary *)ParamDict
{
    NSString *category = ParamDict[@"category"];
    
    [CXDBHandle delect:ParamDict[@"category"]];
    
    NSData *statusData = [NSKeyedArchiver archivedDataWithRootObject:statuses];
    [_db executeUpdateWithFormat:@"INSERT INTO t_searchModel(searchModel, searchModel_idstr) VALUES (%@, %@);", statusData, category];
}

+ (BOOL)delect:(NSString *)searchModel_idstr
{
    BOOL success = YES ;
    NSString * newSql = [NSString stringWithFormat:@"DELETE  FROM t_searchModel WHERE searchModel_idstr = ?"];
    BOOL isCan =  [_db executeUpdate:newSql,searchModel_idstr];
    if (!isCan) {
        success = NO;
    }
    return success;
}


@end
