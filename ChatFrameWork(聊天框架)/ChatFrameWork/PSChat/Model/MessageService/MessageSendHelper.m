//
//  ChatSendHelper.m
//  KeyBoardView
//
//  Created by 余强 on 16/3/22.
//  Copyright © 2016年 你好，我是余强，一位来自上海的ios开发者，现就职于bdcluster(上海大数聚科技有限公司)。这个工程致力于完成一个优雅的IM实现方案，如果您有兴趣，请来到项目交流群：533793277. All rights reserved.
//

#import "MessageSendHelper.h"
#import "ZHUseFDModel.h"

#import "NSDate+Helper.h"
#import "ZHUseFDModel+UIModel.h"
#import "ZHCMessage+ServiceModel.h"

@implementation MessageSendHelper


+ (instancetype)helper
{
    static dispatch_once_t onceToken;
    static MessageSendHelper * helper = nil;
    dispatch_once(&onceToken, ^{
        helper = [[self alloc]init];
    });
    return helper;
}



#pragma mark - 获取未读消息
//获取未读信息
-(void)getUnReadMessageCommplete:(void(^)())CommpleteBlock
{
    //读取最后一条信息ID 值
    NSNumber *value = [BSEUserInfo shareMannager].curLastMsgId;
    if(IsNilOrNull(value)){ //初始值
        value = @(0);
    }
    
    //获取最新ID
    NSMutableDictionary *Params = [NSMutableDictionary new];
    Params[@"requestType"] = @"app";
    Params[@"curLastMsgId"] = value;//最后一条信息
    
    [BSEHttpTool postWithURL:kUnReadMessageList
                      params:Params
                     success:^(id json) {
                         NSDictionary *jsonDic = json;
                         if(NotNilAndNull(jsonDic)){
                             NSNumber * codeNum = jsonDic[@"code"];
                
                             //最新数据消息ID 值
                             NSNumber *curLastMsgId = jsonDic[@"result"][@"curLastMsgId"];
                             if(NotNilAndNull(curLastMsgId)){
                                 [BSEUserInfo shareMannager].curLastMsgId = curLastMsgId;
                             }
                             if([codeNum intValue] == 200){
                                 NSArray *datetemp = jsonDic[@"result"][@"msgList"];
                                 
                                 __block NSMutableArray *DataArray = [NSMutableArray new];
                                 [datetemp enumerateObjectsUsingBlock:^(NSDictionary*  _Nonnull dic, NSUInteger idx, BOOL * _Nonnull stop) {
                                     ZHUseFDModel *model = [[ZHUseFDModel alloc]initWithDictionary:dic];
                                     [model saveToDB];//数据保存数据库
                                     
                                     ZHCMessage *UIModel = [ZHCMessage UIModelFromZHUseFDModel:model];
                                     [DataArray addObject:UIModel];
                                 }];
                                 
                                 if(DataArray.count != 0){
                                 //数据处理 发送通知
                                 [[NSNotificationCenter defaultCenter]postNotificationName:kDidReceiveNotification object:nil];
                                 
                                 if([self.delegate respondsToSelector:@selector(didReceiveMessages:)])
                                 {
                                     //发送委托方法，方法的参数为用户的输入
                                     [self.delegate didReceiveMessages:DataArray];
                                 }}

                                 CommpleteBlock ? CommpleteBlock():nil;
                                 
                             }
                         }
                         
                     } failure:^(NSError *error) {
                
    }];
}




#pragma mark - 发送消息给个人
//消息发送网络业务操作
- (void)sendMessage:(ZHCMessage *)message
         completion:(void (^)(ZHCMessage *))completionBlock
{
    //网络数据
    
      ZHUseFDModel *ServiceModel = [ZHUseFDModel ZHUseFDModelFromUIModel:message];
      bool state =  [ServiceModel saveToDB];//保存本地
    
       double timestamp = (double)[message.date utcTimeStamp]*1000;
        NSMutableDictionary *Params = [NSMutableDictionary new];
        Params[@"requestType"] = @"app";
        Params[@"fId"] = message.senderId;//好友ID 号
        Params[@"contents"] = message.text;
        Params[@"clientTime"] = @(timestamp);//时间
        Params[@"fName"] = message.senderDisplayName;

        [BSEHttpTool postWithURL:kSendMessageFrind
                          params:Params
                         success:^(id json) {
                            
                             NSDictionary *JsonDic = json;
                             NSNumber *CodeNum = JsonDic[@"code"];
                             if([CodeNum intValue] == 200){//成功
                                 message.DeliveState = ZhMessageDeliveSuccess;
                                 [message updateToDB];
                             }else{
                                 message.DeliveState = ZhMessageDeliveFailure;
                                 [message updateToDB];
                             }
                             //Blcok回调
                             completionBlock ? completionBlock(message): nil;
                             
                         } failure:^(NSError *error) {
                             message.DeliveState = ZhMessageDeliveFailure;
                             [message updateToDB];
                             //Blcok回调
                             completionBlock ? completionBlock(message): nil;
                         }];

    
}

//#pragma mark - 发送消息给群
//-(void)sendMessageToGrounp:(MessageServiceModel *)message
//                completion:(void(^)(MessageServiceModel *))completionBlock
//{
//    
//        
//        NSMutableDictionary *Params = [NSMutableDictionary new];
//        Params[@"requestType"] = @"app";
//        Params[@"gId"] = message.toUserId;//好友ID 号
//        Params[@"contents"] = message.messageBody;
//        Params[@"clientTime"] = message.timeStamp;//时间
//        Params[@"gName"] = message.toUserName;
//        
//        
//        [BSEHttpTool postWithURL:kSendMessageGroup
//                          params:Params
//                         success:^(id json) {
//                             NSDictionary *JsonDic = json;
//                             NSNumber *CodeNum = JsonDic[@"code"];
//                             if([CodeNum intValue] == 200){//成功
//                                 message.deliveryState = MessageDeliveryStateDelivered;
//                                 [message updateToDB];
//                             }else{
//                                 message.deliveryState = MessageDeliveryStateFailure;
//                                 [message updateToDB];
//                             }
//                             //Blcok回调
//                             completionBlock ? completionBlock(message): nil;
//                             
//                         } failure:^(NSError *error) {
//                             message.deliveryState = MessageDeliveryStateFailure;
//                             [message updateToDB];
//                             //Blcok回调
//                             completionBlock ? completionBlock(message): nil;
//                         }];
//
//}













@end
