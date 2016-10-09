//
//  ZHUseFDModel.m
//  testAutoCalculateCellHeight
//
//  Created by aimoke on 16/8/3.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHUseFDModel.h"

@implementation ZHUseFDModel

#pragma mark  - 数据库操作
+(LKDBHelper *)getUsingLKDBHelper
{
    return [SQLHelper getUsingLKDBHelper];
}

+(NSString *)getTableName
{
    return @"Message";
}

+(NSString *)getPrimaryKey
{
    return @"messageId";
}

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
            [self setValuesForKeysWithDictionary:dictionary];
        
        _send_date = [NSDate dateWithTimeIntervalSince1970:[_send_time doubleValue]/1000];
    }
    return self;
}


-(void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if([key isEqualToString:@"id"]){
        _MessageID = value;
    }
}

-(void)setNilValueForKey:(NSString *)key
{
    
}




@end
