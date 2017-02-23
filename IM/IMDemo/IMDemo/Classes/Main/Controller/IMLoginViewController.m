//
//  IMLoginViewController.m
//  IMDemo
//
//  Created by 倪望龙 on 2017/2/22.
//  Copyright © 2017年 XunYiJia. All rights reserved.
//

#import "IMLoginViewController.h"
#import "UIButton+BackgroundColor.h"
#import "IMClientManage.h"
#import "IMMessageViewController.h"
#import "BSEHttpTool.h"
@interface IMLoginViewController ()
@property (weak, nonatomic) IBOutlet UITextField *userNameInput;
@property (weak, nonatomic) IBOutlet UITextField *passWordInput;
@property (weak, nonatomic) IBOutlet UIButton *btnLoginIn;
@property (weak, nonatomic) IBOutlet UITextView *textViewResult;

@end

@implementation IMLoginViewController

-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
   self =  [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self){
        self.title = @"登录";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self LVSetUpSubviews];
    [self LVInit];
    // Do any additional setup after loading the view from its nib.
}

-(void)LVSetUpSubviews{
    _userNameInput.layer.cornerRadius = 5.0f;
    _userNameInput.layer.borderColor = HEXCOLOR(0xeeeeee).CGColor;
    _userNameInput.layer.borderWidth = 1.0f;
    _userNameInput.layer.masksToBounds = YES;
    
    _passWordInput.layer.cornerRadius = 5.0f;
    _passWordInput.layer.borderColor = HEXCOLOR(0xeeeeee).CGColor;
    _passWordInput.layer.borderWidth = 1.0f;
    _passWordInput.layer.masksToBounds = YES;
    
    
    _btnLoginIn.layer.cornerRadius = 5.0f;
    _btnLoginIn.layer.masksToBounds = YES;
    [_btnLoginIn setBackgroundColor:HEXCOLOR(0x00dddd) forState:UIControlStateNormal];
    [_btnLoginIn setBackgroundColor:HEXCOLOR(0xeeeeee) forState:UIControlStateHighlighted];
}

-(void)LVInit{
}

#pragma mark - 登录按钮点击
- (IBAction)btnLoginInClick:(id)sender {
    
    NSString *userName = _userNameInput.text;
    NSString *passWord = _passWordInput.text;
    _textViewResult.hidden = YES;

    [[IMClientManage shareMannager] connectWithLogin:userName
                    passcode:passWord
           completionHandler:^(STOMPFrame *connectedFrame, NSError *error) {
               dispatch_async(dispatch_get_main_queue(), ^{
               if ([connectedFrame.command isEqualToString:@"CONNECTED"]) {
                   //登录成功
                   IMMessageViewController *Vc = [[IMMessageViewController alloc]initWithNibName:@"IMMessageViewController" bundle:nil];
                   [self.navigationController pushViewController:Vc animated:YES];
                   
               }else{
        
                   NSLog(@"%@", error);
                   
                       _textViewResult.hidden = NO;
                       _textViewResult.text = [NSString stringWithFormat:@"%@",error];
                 
               }});
           }];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
