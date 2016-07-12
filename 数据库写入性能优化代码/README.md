#SQL数据库写入性能优化
##简述
当数据库，插入数据较多时.

1. 使用sqlite的事务处理方法
2. 打开数据库缓存
3. 不用model直接从字典数组里获取
   （平时做法：Model赋值的时候要开辟内存空间再从字典数组拿出相应字段赋值初始化，写入数据库又要读取出相应的字段，数据量一多时间耗时就会比较长）

通过上面三步可以极高的提快数据库写入速度。

实测数据：
5000条Model数据  1~2内

参考资料：[Fastest way to insert many rows into sqlite db on iPhone](http://stackoverflow.com/questions/11784143/fastest-way-to-insert-many-rows-into-sqlite-db-on-iphone)

##核心代码

```objectivec
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
```

##使用方法

```objectivec
 NSArray *BaseStation = date[@"stationList"];
                             if(NotNilAndNull(BaseStation)){
                                 [[BSEBaseSQL ShareMannger]deleteAllSearchKeywordsFromDB];
                                 [[BSEBaseSQL ShareMannger] intsertStationData:BaseStation];
                                 
//一般的写法（性能较差）
//                                 for(NSDictionary *Basedic in BaseStation){
//                                     BSEBaseStationModel *model = [[BSEBaseStationModel alloc]initWithDict:Basedic];
//                                     double latModify =  [model.lat doubleValue]+ 0.00328;
//                                     double lonModify =  [model.lon doubleValue]+ 0.01185;
//                                     model.lat = [NSNumber numberWithDouble:latModify];
//                                     model.lon = [NSNumber numberWithDouble:lonModify];
//                                     [[BSEBaseSQL ShareMannger]insertData:model];
//                                 }
                             }

```
