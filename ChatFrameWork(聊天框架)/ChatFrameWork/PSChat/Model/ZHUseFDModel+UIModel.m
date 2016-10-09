//
//  ZHUseFDModel+UIModel.m
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/6.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "ZHUseFDModel+UIModel.h"
#import "NSDate+Helper.h"

@implementation ZHUseFDModel (UIModel)
+(ZHUseFDModel *)ZHUseFDModelFromUIModel:(ZHCMessage *)Model
{
    long int MessageSendTime = [Model.date utcTimeStamp];
    
    ZHUseFDModel *ServiceModel = [ZHUseFDModel new];
    ServiceModel.MessageID = @(MessageSendTime);
    ServiceModel.produce_name = [BSEUserInfo shareMannager].userName;
    ServiceModel.produce_id = [BSEUserInfo shareMannager].StudentID;
    ServiceModel.receiver_name = Model.senderDisplayName;
    ServiceModel.receiver_id = @([Model.senderId intValue]);
    ServiceModel.send_time = @(MessageSendTime);
    ServiceModel.send_date = Model.date;
    ServiceModel.contents = Model.text;
    return ServiceModel;
}
@end
