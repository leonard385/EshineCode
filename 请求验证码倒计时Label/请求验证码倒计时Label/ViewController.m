//
//  ViewController.m
//  请求验证码倒计时Label
//
//  Created by eshine_1233 on 16/7/8.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "ViewController.h"
#import "QosTimer.h"


#import "TimeDownView.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *btnObtainCheckNum;

@property (weak, nonatomic) IBOutlet UILabel *lblTime;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   /*
        1.添加文件夹 timeDown
        2. 导入 TimeDownView.h文件
        使用代码创建 获取验证码按钮
    */
    
   TimeDownView *btnView =   [[TimeDownView alloc]initWithFrame:CGRectMake(100, 100, 70, 30)];
    btnView.timeCount = 30;
    btnView.handBlock = ^(){
        
        NSLog(@"处理点击事件  发送网络请iu");
    };
    [self.view addSubview:btnView];
}



- (IBAction)btnObtainCheckNumDidClick {
    
//    NSLog(@"获取验证码");
    [QosTimer TimeCountDown:60 handleDis:^(NSString *str) {
        self.btnObtainCheckNum.hidden = YES;
        self.lblTime.text = str;
        self.lblTime.hidden = NO;
    } complete:^{
        self.btnObtainCheckNum.hidden = NO;
        self.lblTime.hidden = YES;
    }];
    
    
    
}


@end
