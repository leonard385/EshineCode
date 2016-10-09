//
//  ZHUseFDModel.h
//  testAutoCalculateCellHeight
//
//  Created by aimoke on 16/8/3.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SQLHelper.h"
@interface ZHUseFDModel : NSObject

@property(nonatomic,strong)NSNumber *MessageID;//消息ID
@property(nonatomic,strong)NSNumber *msg_type;//消息类型
@property (nonatomic, strong) NSString *produce_name;//发送人名称
@property (nonatomic, strong) NSNumber *produce_id;//发送人ID
@property (nonatomic, strong) NSString *receiver_name;//接收人名称
@property (nonatomic, strong) NSNumber *receiver_id;//接收人ID
@property (nonatomic, strong) NSNumber *send_time;//发送时间
@property (nonatomic, strong) NSString *contents;//消息内容
@property (nonatomic, strong) NSDate *send_date;//发送时间
@property(nonatomic,assign)bool isRead; //消息是否读取

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end
