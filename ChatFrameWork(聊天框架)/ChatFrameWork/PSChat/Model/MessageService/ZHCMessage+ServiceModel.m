//
//  ZHCMessage+ServiceModel.m
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/6.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "ZHCMessage+ServiceModel.h"
#import "NSString+Emoji.h"
@implementation ZHCMessage (ServiceModel)
+(ZHCMessage *)UIModelFromZHUseFDModel:(ZHUseFDModel *)Model
{
//    NSString *Str = [ Model.contents stringByReplacingEmojiUnicodeWithCheatCodes];
    ZHCMessage *UIModel = [[ZHCMessage alloc] initWithSenderId:[Model.receiver_id stringValue]
                                             senderDisplayName:Model.receiver_name
                                                          date:Model.send_date
                                                          text:Model.contents
                           ];
    return UIModel;
}
@end
