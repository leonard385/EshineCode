//
//  VoiceMannageViewController.m
//  faceTrackSystem
//
//  Created by 倪望龙 on 2017/5/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "VoiceMannageViewController.h"
#import "iflyMSC/iFlyISVRecognizer.h"
#import "iflyMSC/IFlySpeechError.h"
#import "Reachability.h"
#import "TrainViewController.h"
@interface VoiceMannageViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textViewTip;
@property (nonatomic,strong)IFlyISVRecognizer *isvRecognizer;

@property (weak, nonatomic) IBOutlet UILabel *labelTip;

@property(nonatomic,strong)NSArray *numCodeArray;
@end

@implementation VoiceMannageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.textViewTip.text = @"1.点击右上角\"设置\"按钮选择声纹类型\n\n2.点击\"训练模型\"按钮，通过训练向服务器注册声纹模型\n\n3.在训练模型界面，如果是固定密码或者是数字密码类型，点击\"开始录音\"按钮并朗读麦克风图标上方文字，朗读完等待1秒后点击\"停止录音\"，重复直到下方显示的数字为5\n\n4.训练成功后，可以点击\"识别声纹\"按钮进行验证\n\n5.可以点击\"删除模型\"或者是\"查询模型\"进行删除或是查询声纹模型操作";
    self.isvRecognizer = [IFlyISVRecognizer sharedInstance];
    // Do any additional setup after loading the view from its nib.
}

/* 判断网络是否连接 */
-(BOOL)netConnectAble
{
    if ( [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable ){
        return NO;
    }
    return YES;
}

- (IBAction)btnTrainClick:(id)sender {
    if( [self netConnectAble] == NO ){
        NSLog(@"无网络连接");
        return;
    }
    [self.isvRecognizer cancel];
    [self.isvRecognizer setParameter:TRAIN_SST forKey:KEY_SST];
    [self trainOrVerifyNumCode:TRAIN_SST];
}

- (IBAction)btnVerifyClick:(id)sender {
    if( [self netConnectAble] == NO ){
        NSLog(@"无网络连接");
        return;
    }
    [self.isvRecognizer cancel];
    [self trainOrVerifyNumCode:VERIFY_SST];
}

- (IBAction)btnDeleteClick:(id)sender {
    if( [self netConnectAble] == NO ){
        NSLog(@"无网络连接");
        return;
    }
    [self startRequestNumCode:DEL];
}

- (IBAction)btnLookUpClick:(id)sender {
    if( [self netConnectAble] == NO ){
        NSLog(@"无网络连接");
        return;
    }
    [self startRequestNumCode:QUERY];
}

//训练或者验证 数字密码
-(void)trainOrVerifyNumCode:(NSString *)sst
{
    if( ![sst isEqualToString:VERIFY_SST] && ![sst isEqualToString:TRAIN_SST] ){
        NSLog(@"in %s,sst 参数错误",__func__);
        return;
    }
    
    int passType = PWDT_NUM_CODE;
    _numCodeArray = [self downloadPassworld:passType];
    
    if( _numCodeArray == nil ){
        NSLog(@"获取密码失败");
        return;
    }
    
    if([sst isEqualToString:VERIFY_SST] ){
        if( _numCodeArray != nil && _numCodeArray.count > 0 ){
            NSString *ptString = [_numCodeArray objectAtIndex:0];
            [self defaultSetparam:_authID withpdwt: PWDT_NUM_CODE withptxt:ptString trainorverify:VERIFY_SST];
            TrainViewController *trainController = [[TrainViewController alloc]init];
            trainController.numCodeArray = self.numCodeArray;
            trainController.pwdt = PWDT_NUM_CODE;
            trainController.sst = VERIFY_SST;
            [self presentViewController:trainController animated:YES completion:nil];
        }
        
    }else{
        if( _numCodeArray != nil && _numCodeArray.count > 0 ){
            NSString *ptString = [self numArrayToString:self.numCodeArray];
            [self defaultSetparam:_authID withpdwt: PWDT_NUM_CODE withptxt:ptString trainorverify:TRAIN_SST];
            TrainViewController *trainController=[[TrainViewController alloc]init];
            trainController.numCodeArray = _numCodeArray;
            trainController.pwdt=PWDT_NUM_CODE;
            trainController.sst=TRAIN_SST;
            [self presentViewController:trainController animated:YES completion:nil];
        }
    }
}

#pragma mark other function
//下载密码
-(NSArray*)downloadPassworld:(int)pwdtParam
{
    
    if( pwdtParam != PWDT_FIXED_CODE && pwdtParam != PWDT_NUM_CODE ){
        NSLog(@"in %s,pwdtParam 参数错误",__func__);
        return nil;
    }
    NSArray* tmpArray = [_isvRecognizer getPasswordList:pwdtParam];  // attention isv +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
    
    if( tmpArray == nil ){
        NSLog(@"in %s,请求数据有误",__func__);
        return nil;
    }
    
    return tmpArray;   //返回下载
    
}

//数字密码 把array里面的数字 串起来,ISV 固定规则
-(NSString*)numArrayToString:(NSArray *)numArrayParam
{
    if( numArrayParam == nil ){
        NSLog(@"在%s中，numArrayParam is nil",__func__);
        return nil;
    }
    
    NSMutableString *ptxtString = [NSMutableString stringWithCapacity:1];
    [ptxtString appendString:[numArrayParam objectAtIndex:0]];
    
    for (int i = 1;i < [numArrayParam count] ; i++ ){
        NSString *str = [numArrayParam objectAtIndex:i];
        [ptxtString appendString:[NSString stringWithFormat:@"-%@",str]];
        
    }
    return  ptxtString;
}

#pragma mark train or verify model
//声纹默认参数设置
- (void)defaultSetparam:(NSString *)auth_id withpdwt:(int) pwdt withptxt:(NSString *) ptxt trainorverify:(NSString*)sst
{
    if( _isvRecognizer != nil ){
        [_isvRecognizer setParameter:@"ivp" forKey:KEY_SUB];
        [_isvRecognizer setParameter:[NSString stringWithFormat:@"%d",pwdt] forKey:KEY_PWDT];
        [_isvRecognizer setParameter:@"50" forKey:KEY_TSD];
        [_isvRecognizer setParameter:@"3000" forKey:KEY_VADTIMEOUT];
        [_isvRecognizer setParameter:@"700" forKey:KEY_TAIL];
        [_isvRecognizer setParameter:ptxt forKey:KEY_PTXT];
        [_isvRecognizer setParameter:auth_id forKey:KEY_AUTHID];
        [_isvRecognizer setParameter:sst forKey:KEY_SST];            /* train or test */
        [_isvRecognizer setParameter:@"180000" forKey:KEY_KEYTIMEOUT];
        if( pwdt == PWDT_FIXED_CODE || pwdt == PWDT_NUM_CODE ){
            [_isvRecognizer setParameter:@"5" forKey:KEY_RGN];
        }else{
            [_isvRecognizer setParameter:@"1" forKey:KEY_RGN];
        }
    }else{
        NSLog(@"isvRec is nil\n");
    }
    
}

//数字密码查询或者删除
-(void)startRequestNumCode:(NSString *)queryMode
{
    if( ![queryMode isEqualToString: QUERY] && ![queryMode isEqualToString:DEL] ){
        NSLog(@"in %s,queryMode 参数错误",__func__);
        return;
    }
    int err;
    BOOL ret;
    ret = [self.isvRecognizer sendRequest:queryMode authid:_authID pwdt:PWDT_NUM_CODE ptxt:nil vid:nil err:&err];// attention isv +++++++++++++++++++++
    [self processRequestResult:queryMode ret:ret err:err];
}



//查询或者时删除返回的结果处理
-(void)processRequestResult:(NSString*)requestMode ret:(BOOL)ret err:(int)err
{
    if( ![requestMode isEqualToString:DEL] && ![requestMode isEqualToString:QUERY]){
        NSLog(@"在%s中，queryMode参数错误",__func__);
        return;
    }
    
    if( [requestMode isEqualToString:QUERY] ){
        if( err != 0 ){
            NSLog(@"查询错误，错误码：%d",err);
            _labelTip.text = [NSString stringWithFormat:@"查询错误，错误码：%d",err];
        }else{
            if( ret == NO ){
                NSLog(@"模型不存在");
                _labelTip.text = @"模型不存在";
            }else{
                NSLog(@"查询成功");
                _labelTip.text = @"查询成功";
            }
        }
    }else if(  [requestMode isEqualToString:DEL]){
        if( err != 0 ){
            NSLog(@"删除错误，错误码：%d",err);
            _labelTip.text = [NSString stringWithFormat:@"查询错误，错误码：%d",err];
        }else{
            if( ret == NO ){
                NSLog(@"模型不存在");
                _labelTip.text = @"模型不存在";
            }else{
                NSLog(@"删除成功");
                _labelTip.text = @"删除成功";
            }
        }
    }
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
