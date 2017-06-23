//
//  DiagleView.m
//  MSCDemo_UI
//
//  Created by wangdan on 14-12-22.
//
//

#import "TrainViewController.h"
#import "iflyMSC/iFlyISVRecognizer.h"
#import "iflyMSC/IFlySpeechError.h"
#import "Reachability.h"

#pragma  mark  result_dic key
#define  SUC_KEY           @"suc"
#define  RGN_KEY           @"rgn"


#pragma pwdt type
#define PWDT_FIXED_CODE    1
#define PWDT_NUM_CODE      3
#define PWDT_FREE_CODE     2

#pragma mark value of key
#define  TRAIN_SST          @"train"
#define  VERIFY_SST         @"verify"
#define  DCS                @"dcs"
#define  SUCCESS            @"success"
#define  FAIL               @"fail"

@interface TrainViewController ()
{
    
    IFlyISVRecognizer *isvRec; //声纹单例
    
    UIButton *startRecButton;  //开始录音
    
    UIButton *stopRecButton;   //停止录音
}

@end

@implementation TrainViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    CGRect rect=[[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    

    isvRec=[IFlyISVRecognizer sharedInstance];
    isvRec.delegate =self;
    self.screenWidth = size.width;
    self.screenHeight=size.height;
    
    
    self.diagView=[[DiagleView alloc]initWithFrame:CGRectMake(0, 0, self.screenWidth, self.screenHeight)];//录音界面
    [self.diagView.startRecButton addTarget:self action:@selector(startButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.diagView.stopRecButton  addTarget:self action:@selector(stopButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    [self.diagView.cancelButton  addTarget:self action:@selector(cancelButtonHandler:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self initialDiagViewRecordTtile];//初始化录音界面的titile
    
    [self.view addSubview:self.diagView];
    
    self.trainVerifyAlert=[[UIAlertView alloc]initWithTitle:@"nihao"
                                                    message:nil
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil, nil];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



#pragma  mark button Handler
-(void)startButtonHandler:(id)sender
{
    if( [self netConnectAble] == NO )
    {
        [self.trainVerifyAlert setTitle:@"网络连接异常"];
        [self.trainVerifyAlert show];
        return;
    }
    
    self.diagView.startRecButton.enabled=NO;
    [isvRec startListening];//开始录音
}

-(void)stopButtonHandler:(id)sender
{
    [isvRec stopListening];//停止录音
}


-(void)cancelButtonHandler:(id)sender
{
    [isvRec cancel];//结束会话
    [self dismissViewControllerAnimated:YES completion:nil];
}



#pragma  mark iFlyISVDelegate

//正常结果返回回调
-(void)onResult:(NSDictionary *)dic
{
    
    [self.diagView.recognitionView stopAnimating];
    [self.diagView recordViewInit];
    
    [self resultProcess:dic];
    self.diagView.startRecButton.enabled=YES;
}



//发生错误
-(void) onError:(IFlySpeechError *) errorCode
{
    [self.diagView.recognitionView stopAnimating];
    [self.diagView recordViewInit];
    
    if( errorCode.errorCode != 0 )
    {
        self.diagView.startRecButton.enabled=YES;
        self.diagView.resultLabel.textColor=[UIColor redColor];
        self.diagView.resultLabel.text=[NSString stringWithFormat:@"错误码:%d",errorCode.errorCode];
    }
    
    self.diagView.startRecButton.enabled=YES;
    
}


//音量回调
-(void)onVolumeChanged:(int)volume
{
    [self.diagView recordViewChangeWithVolume:volume];
}

//识别中回调
-(void)onRecognition
{
    NSLog(@"正在识别中");
    [self performSelectorOnMainThread:@selector(hideRecordView) withObject:nil waitUntilDone:YES];
//    [self.diagView.recordView removeFromSuperview];//替代方法
    [self.diagView.recognitionView startAnimating];
    
}


#pragma  mark initial recordTitle

-(void)initialDiagViewRecordTtile //录音小窗口标题设置
{
    if( self.pwdt == PWDT_FIXED_CODE ){
        if( self.fixCodeArray != nil  && self.fixCodeArray.count > 0)
            self.diagView.recordTitleLable.text=[self.fixCodeArray objectAtIndex:0];
    }else if( self.pwdt == PWDT_NUM_CODE ){
        if( self.numCodeArray != nil && self.numCodeArray.count !=0 )
            self.diagView.recordTitleLable.text=[self.numCodeArray objectAtIndex:0];
    }
}

#pragma mark result process

//对声纹回调结果进行处理
-(void)resultProcess:(NSDictionary *)dic
{
    if( dic == nil ){
        NSLog(@"in %s,dic is nil",__func__);
        return;
    }

    if( [self.sst isEqualToString:TRAIN_SST] ){  //训练结果
        
        NSNumber *suc=[dic objectForKey:SUC_KEY] ;
        self.diagView.resultLabel.textColor=[UIColor blackColor];
        self.diagView.resultLabel.text=[NSString stringWithFormat:@"%d",[suc intValue]];
        NSNumber *rgn=[dic objectForKey:RGN_KEY];
        
        if( [suc intValue] >= [rgn intValue] ){
            [self.trainVerifyAlert setTitle:@"训练成功"];
            [self.trainVerifyAlert show];
        }
        
        if( self.pwdt == PWDT_NUM_CODE ){  //数字密码需要更新显示
            if( [suc intValue] < [rgn intValue] ){
                self.diagView.recordTitleLable.text=[self.numCodeArray objectAtIndex:[suc intValue]];
            }
        }
        
    }else if( [self.sst isEqualToString:VERIFY_SST] ){ //验证结果
        
        self.diagView.resultLabel.text=@""; //结果label不显示
        NSString *successStr=@"";
        
        if( [[dic objectForKey:DCS] isEqualToString:SUCCESS] ){
            successStr=@"验证成功";
        }else{
            successStr=@"验证失败";
        }
        [self.trainVerifyAlert setTitle:successStr];
        [self.trainVerifyAlert show];
    }

}


#pragma  mark  net detect
//网络连接判断
-(BOOL)netConnectAble
{
    if ( [[Reachability reachabilityForInternetConnection] currentReachabilityStatus] == NotReachable ){
        return NO;
    }
    return YES;
}


-(void)hideRecordView
{
   [self.diagView.recordView setHidden:YES];
}
@end
