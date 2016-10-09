//
//  MessageReceiveProtocol.h
//  PracticeSaftSystem
//
//  Created by 逸信Mac on 16/9/6.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//


@protocol MessageReceiveProtocol <NSObject>
-(void)didReceiveMessages:(NSMutableArray *)Array;
@end