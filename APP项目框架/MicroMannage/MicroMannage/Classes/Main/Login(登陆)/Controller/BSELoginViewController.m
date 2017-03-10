//
//  BSELoginViewController.m
//  BSEM
//
//  Created by 逸信Mac on 16/3/1.
//  Copyright © 2016年 逸信Mac. All rights reserved.
//

#import "BSELoginViewController.h"
#import "AccountPasswordMannger.h"
#import "CSRootViewController.h"
#import "UINavigationController+FDFullscreenPopGesture.h"
@interface BSELoginViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *LoginInBtn;
@property (weak, nonatomic) IBOutlet UIView *AcountPwView;
@property (weak, nonatomic) IBOutlet UITextField *AcountTextFild;
@property (weak, nonatomic) IBOutlet UITextField *PassWordTextFild;
@end

@implementation BSELoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LVReadStoreAcount];
    [self LVSetSubViews];
    [self ReactiveCocoaInit];
    // Do any additional setup after loading the view from its nib.
}

-(void)LVReadStoreAcount
{
    NSDictionary *AcountPass = [AccountPasswordMannger GetAccountAndPassword];
    self.AcountTextFild.text = AcountPass.allKeys[0];
    self.PassWordTextFild.text = AcountPass.allValues[0];
}

-(void)LVSetSubViews
{
    
    [self.AcountPwView cornerRadius:GlobalCornerRadius strokeSize:1.0f color:HEXCOLOR(LineColor)];
    
    [self.LoginInBtn cornerRadius:GlobalCornerRadius];
    
    [self.LoginInBtn setBackgroundColor:HEXCOLOR(GlobalBlueColor) forState:UIControlStateNormal];
    [self.LoginInBtn setBackgroundColor:HEXCOLOR(ButtonHighLightColor) forState:UIControlStateHighlighted];
    
    [self.LoginInBtn setBackgroundColor:HEXCOLOR(ButtonDisableColor) forState:UIControlStateDisabled];

}

-(void)ReactiveCocoaInit
{
    //账号输入判断
    RACSignal *VaildAcountInput = [[self.AcountTextFild.rac_textSignal
                                    map:^id(NSString * acountText) {
                                        return @(acountText.length > 0);
                                    }]distinctUntilChanged];
    
    //密码输入判断
    RACSignal *VaildPassWordInput = [[self.PassWordTextFild.rac_textSignal
                                     map:^id(NSString * passText) {
                                         return @(passText.length > 0);
                                     }]distinctUntilChanged];
    
    
    [[VaildAcountInput map:^id(NSNumber* acountVaild) {
        return ![acountVaild  boolValue]?[UIColor redColor]:[UIColor blackColor];
    }]subscribeNext:^(UIColor* color) {
        self.AcountTextFild.textColor = color;
    }];
    
    [[VaildPassWordInput map:^id(NSNumber* PassVaild) {
        return ![PassVaild  boolValue]?[UIColor redColor]:[UIColor blackColor];
    }]subscribeNext:^(UIColor* color) {
        self.PassWordTextFild.textColor = color;
    }];
    
    
    //密码账号都符合要求后使能btn
    
     [[RACSignal   combineLatest:@[VaildAcountInput,
                                                    VaildPassWordInput]
                                    reduce:^id(NSNumber* AcountVaild,NSNumber* PasswordVaild){
                                        return @([AcountVaild boolValue]&&[PasswordVaild boolValue]);
                                    }
                                    ]subscribeNext:^(NSNumber *result) {
        NSLog(@"%@",result);
     self.LoginInBtn.enabled = [result boolValue];
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 登陆
- (IBAction)LVLoginInbtnClick:(id)sender {
    
    /*
    NSMutableDictionary *paras = [NSMutableDictionary dictionary];
    paras[@"userCode"] = _AcountTextFild.text;
    paras[@"password"] = _PassWordTextFild.text;
    paras[@"mode"] = @"0";

    [MBProgressHUD showMessage:@"正在登录"];
    [BSEHttpTool postWithURL:HTTP_LOGIN
                      params:paras
                     success:^(NSDictionary* json) {
                         [MBProgressHUD hideHUD];
                         NSLog(@"%@",json);
                         if(NotNilAndNull(json)){//正确返回
                             NSString *LoginMsg = json[@"MSG"];
                            [MBProgressHUD showMessageAutoDismiss:json[@"MSG"]];
                             if(NotNilAndNull(LoginMsg)&&([LoginMsg isEqualToString:@"登录成功"])){
                                 [[BSEUserInfo shareMannager]initWithDic:json];
                                 [[BSEUserInfo shareMannager]setPassWord:paras[@"password"]];
                                 [AccountPasswordMannger SaveAccount:paras[@"userCode"] andPassword:paras[@"password"]];
                                 NSLog(@"%@",[BSEUserInfo shareMannager]);
                                 dispatch_async(dispatch_get_main_queue(), ^{
                                     [self.AcountTextFild resignFirstResponder];
                                     [self.PassWordTextFild resignFirstResponder];
                                     [self ReSetRootVC];
                                     
                                 });

                             }
                         }
                      } failure:^(NSError *error) {
                         [MBProgressHUD hideHUD];
                         [MBProgressHUD showError:@"网络超时"];
                     }];
     */
    
    // APP 用户信息单例KVC赋值
    //[[BSEUserInfo shareMannager]initWithDic:json];
    //keychain密码保存
    //[AccountPasswordMannger SaveAccount:paras[@"userCode"] andPassword:paras[@"password"]];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.AcountTextFild resignFirstResponder];
        [self.PassWordTextFild resignFirstResponder];
        
    });

    
}

- (IBAction)LvChangPassVisable:(UIButton*)sender {
    sender.selected = !sender.selected;
    if(sender.selected)//可见
    {
        [_PassWordTextFild setSecureTextEntry:NO];
        
    }else{
        [_PassWordTextFild setSecureTextEntry:YES];
    }
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
