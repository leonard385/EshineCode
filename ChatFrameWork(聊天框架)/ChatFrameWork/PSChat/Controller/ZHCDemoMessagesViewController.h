//
//  ZHCDemoMessagesViewController.h
//  ZHChat
//
//  Created by aimoke on 16/8/23.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCMessages.h"
@interface ZHCDemoMessagesViewController : ZHCMessagesViewController

@property (assign, nonatomic) BOOL presentBool;
-(instancetype)initWithChatName:(NSString *)Name ID:(NSString*)IDCode;
@end
