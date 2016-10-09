//
//  MessageStoreHelper.m
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "MessageStoreHelper.h"
#import "ZHUseFDModel.h"
#import "ZHCMessage+ServiceModel.h"


@implementation MessageStoreHelper
//单例
+ (instancetype)helper
{
    static dispatch_once_t onceToken;
    static MessageStoreHelper * helper = nil;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc]init];
    });
    return helper;
}




#pragma mark - 最近十条数据
-(NSMutableArray *)readLastTenMessageFrinedName:(NSString *)Friendname
{
    NSMutableArray* dateTemp = [self readHistoryMessageWithPage:0
                                                    PageSize:10.0f
                                                  FrinedName:Friendname];
    
    return dateTemp;
}


#pragma mark - 历史数据翻页查询
-(NSMutableArray *)readHistoryMessageWithPage:(NSUInteger)page PageSize:(NSUInteger)PageSize FrinedName:(NSString *)Friendname
{
    //page处理
    NSString * Str = [NSString stringWithFormat:@"produce_name = '%@' or receiver_name = '%@'",Friendname,Friendname];
    
    NSString *SelectSQL = [NSString stringWithFormat:@"limit %lu offset %lu",(unsigned long)(PageSize),(unsigned long)(page *PageSize)];
    
    NSMutableArray* array = [ZHUseFDModel searchWithSQL:[NSString stringWithFormat:@"select * from (select * from Message where %@ order by send_time DESC %@) order by send_time",Str,SelectSQL]];
    
    
    __block NSMutableArray *dateTemp = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(ZHUseFDModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //数据跟新
        obj.isRead = YES;
        [obj updateToDB];
        
        ZHCMessage *uimodel = [ZHCMessage UIModelFromZHUseFDModel:obj];
        [dateTemp addObject:uimodel];
    }];
    
    return dateTemp;
}


#pragma mark - 未读消息查询
-(NSMutableArray *)getUnreadMessageFrinedName:(NSString *)Friendname
{
    //本机用户名
    NSString *UserName = [BSEUserInfo shareMannager].userName;
    NSString *SelectSQL = [NSString stringWithFormat:@"produce_name = '%@'",UserName];
    
    
    NSMutableArray* array = [ZHUseFDModel searchWithSQL:[NSString stringWithFormat:@"select * from message where %@  and isRead = 0 order by send_time",SelectSQL]];
    
    
    __block NSMutableArray *dateTemp = [NSMutableArray new];
    [array enumerateObjectsUsingBlock:^(ZHUseFDModel *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        //数据跟新
        obj.isRead = YES;
        [obj updateToDB];
        
        ZHCMessage *uimodel = [ZHCMessage UIModelFromZHUseFDModel:obj];
        [dateTemp addObject:uimodel];
    }];
    
    return dateTemp;
}
@end
