//
//  BSELoginViewController.m
//  BSEM
//
//  Created by 逸信Mac on 16/3/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "BSELoginViewController.h"
#import "AccountPasswordMannger.h"
#import "AppDelegate.h"
#import "MBProgressHUD+LLX.h"
@interface BSELoginViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *LoginInBtn;
@property (weak, nonatomic) IBOutlet UIView *AcountPwView;
@property (weak, nonatomic) IBOutlet UITextField *AcountTextFild;
@property (weak, nonatomic) IBOutlet UITextField *PassWordTextFild;
@end

@implementation BSELoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
}


#pragma mark -  读取保存在本地的账号密码
-(void)LVReadStoreAcount
{
    NSDictionary *AcountPass = [AccountPasswordMannger GetAccountAndPassword];
    NSLog(@"读取值：%@",AcountPass);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登陆
- (IBAction)LVLoginInbtnClick:(id)sender {
    NSString *UserName = _AcountTextFild.text;
    NSString *PassWord = _PassWordTextFild.text;
    [AccountPasswordMannger SaveAccount:UserName andPassword:PassWord];
    [MBProgressHUD showSuccess:@"保存成功"];
}
- (IBAction)ReadPass:(id)sender {
    [self LVReadStoreAcount];
    [MBProgressHUD showSuccess:@"读取成功"];
}

- (IBAction)ClearPassClick:(id)sender {
    _AcountTextFild.text = @"";
    _PassWordTextFild.text = @"";
    [AccountPasswordMannger ClearPassWord];
    
}





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
