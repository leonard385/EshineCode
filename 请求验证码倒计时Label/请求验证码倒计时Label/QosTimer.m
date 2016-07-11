//
//  QosTimer.m
//  qosIos
//
//  Created by 逸信Mac on 15/12/30.
//  Copyright © 2015年 eshine. All rights reserved.
//

#import "QosTimer.h"

@implementation QosTimer

+(void)TimeCountDown :(int)time handleDis:(void (^)(NSString * str))Display complete:(void (^)())complete
{

    //倒计时总时间
__block int timeout = time;
    //全局队列
dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    
dispatch_source_set_event_handler(_timer, ^{
    if(timeout<=0){ //倒计时结束，关闭
        dispatch_source_cancel(_timer);
        dispatch_release(_timer);
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置界面的按钮显示 根据自己需求设置
            complete();
        });
    }else{
//        int minutes = timeout / 60;
        int seconds = timeout % 60;
        NSString *strTime = [NSString stringWithFormat:@"%d秒后重新获取",seconds];
        dispatch_async(dispatch_get_main_queue(), ^{
            //设置界面的按钮显示 根据自己需求设置
            Display(strTime);
        });
        timeout--;
    }
});
dispatch_resume(_timer);
}
@end
