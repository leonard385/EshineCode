//
//  MessageStoreHelper.h
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface MessageStoreHelper : NSObject
+ (instancetype)helper;

//读取最近十条消息
-(NSMutableArray *)readLastTenMessageFrinedName:(NSString *)Friendname;

//分页读取数据
-(NSMutableArray *)readHistoryMessageWithPage:(NSUInteger)page PageSize:(NSUInteger)PageSize FrinedName:(NSString *)Friendname;

//获取未读消息
-(NSMutableArray *)getUnreadMessageFrinedName:(NSString *)Friendname;

@end
