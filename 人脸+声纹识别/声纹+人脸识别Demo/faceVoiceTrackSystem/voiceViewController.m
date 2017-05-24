//
//  voiceViewController.m
//  faceTrackSystem
//
//  Created by 倪望龙 on 2017/5/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "voiceViewController.h"
#import "VoiceMannageViewController.h"
@interface voiceViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textFieldAccountInput;
@property (weak, nonatomic) IBOutlet UIButton *btnConfirm;
@property (weak, nonatomic) IBOutlet UILabel *lableTip;

@property(nonatomic,strong)NSString *authID;

@end

@implementation voiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"用户帐号";
    // Do any additional setup after loading the view from its nib.
}
- (IBAction)btnConfirmClick:(id)sender {
    if([self verifyContent]){
        VoiceMannageViewController *vc = [[VoiceMannageViewController alloc]initWithNibName:@"VoiceMannageViewController" bundle:nil];
        vc.authID = self.authID;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

-(BOOL)verifyContent{
    int  errorFlag=0;
    NSString *nameString = _textFieldAccountInput.text;
    
    if( nameString.length < 6 || nameString.length > 18 ){
        errorFlag=1;  // 长度不对
    }else{
        for( int i=0 ; i< nameString.length ; i++ ){
            char sigleChar=[nameString characterAtIndex:i];
            NSString *subString=[nameString substringWithRange:NSMakeRange(i, 1)];
            const char *u8string=[subString UTF8String];
            if( i ==0 ){
                if( strlen(u8string) < 3 ){
                    if( (( sigleChar > 64 && sigleChar < 91 ) || ( sigleChar > 96 && sigleChar <123))==0){
                        errorFlag=4;    ///* 首个不是字母 */
                        break;
                    }
                }else{
                    errorFlag=5;        //首个字符是中文或是其他类型字符
                    break;
                }
                continue;
            }
            
            if(strlen(u8string)==3){
                errorFlag=2;       /*  含有中文*/
                break;
            }else if((sigleChar>64 && sigleChar<91)|| (sigleChar>96 && sigleChar <123) || (sigleChar>47 && sigleChar<58) || sigleChar==95)
            {
                continue;
            }else{
                errorFlag=3;        /* 不满足要求的字符 */
                break;
            }
        }
        
    }
    
    if(errorFlag==1){
        _lableTip.text=@"用户名长度不符合要求";
    }else if(errorFlag==2 || errorFlag==3 ){
        _lableTip.text=@"用户名内部含有非法字符";
    }else if(errorFlag==4 || errorFlag==5){
        _lableTip.text=@"首字母不是英文字符";
    }else{
        self.authID = [[NSString alloc]initWithString:_textFieldAccountInput.text];
        return YES;
    }
    return NO;
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
