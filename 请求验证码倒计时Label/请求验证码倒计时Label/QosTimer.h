//
//  QosTimer.h
//  qosIos
//
//  Created by 逸信Mac on 15/12/30.
//  Copyright © 2015年 eshine. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface QosTimer : NSObject
+(void)TimeCountDown :(int)time handleDis:(void (^)(NSString * str))Display complete:(void (^)())complete;
@end
