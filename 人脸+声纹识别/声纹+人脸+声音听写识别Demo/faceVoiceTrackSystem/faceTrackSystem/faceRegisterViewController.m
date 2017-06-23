//
//  faceRegisterViewController.m
//  faceTrackSystem
//
//  Created by 倪望龙 on 2017/5/23.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "faceRegisterViewController.h"
#import "faceDetectController.h"
#import <iflyMSC/IFlyFaceSDK.h>
#import "UIImage+Extensions.h"
#import "UIImage+compress.h"
#import "IFlyFaceResultKeys.h"
@interface faceRegisterViewController ()<IFlyFaceRequestDelegate>
@property (weak, nonatomic) IBOutlet UILabel *lableTitle;
@property (weak, nonatomic) IBOutlet UIImageView *faceImagePreView;
@property (nonatomic,strong) IFlyFaceRequest * iFlySpFaceRequest;
@property (nonatomic,strong) NSString *resultStings;
@end

@implementation faceRegisterViewController
- (void)viewDidLoad {
    self.title = @"人脸识别";
    [super viewDidLoad];
    [self FRSetUpSubviews];
    // Do any additional setup after loading the view.
}

-(void)FRSetUpSubviews{
    self.iFlySpFaceRequest=[IFlyFaceRequest sharedInstance];
    [self.iFlySpFaceRequest setDelegate:self];
   
}
- (IBAction)btnRegistClick:(id)sender {
  __weak __typeof(self) weakself = self;
  faceDetectController *faceVC = [faceDetectController new];
  [faceVC setGetFacePictureBlock:^(UIImage *faceImage) {
      [weakself.navigationController popToViewController:self animated:YES];
      [weakself.iFlySpFaceRequest setParameter:[IFlySpeechConstant FACE_REG] forKey:[IFlySpeechConstant FACE_SST]];
      [weakself.iFlySpFaceRequest setParameter:USER_APPID forKey:[IFlySpeechConstant APPID]];
      [weakself.iFlySpFaceRequest setParameter:USER_APPID forKey:@"auth_id"];
      [weakself.iFlySpFaceRequest setParameter:@"del" forKey:@"property"];
      weakself.faceImagePreView.image = faceImage;
      NSData* imgData = [faceImage compressedData];
      NSLog(@"reg image data length: %lu",(unsigned long)[imgData length]);
      [weakself.iFlySpFaceRequest sendRequest:imgData];
  }];
  [self.navigationController pushViewController:faceVC animated:YES];
}
- (IBAction)btnVerifyClick:(id)sender {
    __weak __typeof(self) weakself = self;
    faceDetectController *faceVC = [faceDetectController new];
    [faceVC setGetFacePictureBlock:^(UIImage *faceImage) {
        [weakself.navigationController popToViewController:self animated:YES];
        [weakself.iFlySpFaceRequest setParameter:[IFlySpeechConstant FACE_VERIFY] forKey:[IFlySpeechConstant FACE_SST]];
        [weakself.iFlySpFaceRequest setParameter:USER_APPID forKey:[IFlySpeechConstant APPID]];
        [weakself.iFlySpFaceRequest setParameter:USER_APPID forKey:@"auth_id"];
        NSUserDefaults* userDefaults=[NSUserDefaults standardUserDefaults];
        NSString* gid = [userDefaults objectForKey:KCIFlyFaceResultGID];
        if(!gid){
            UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"结果" message:@"请先注册，或在设置中输入已注册的gid" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
            alert = nil;
            return;
        }
        [weakself.iFlySpFaceRequest setParameter:gid forKey:[IFlySpeechConstant FACE_GID]];
        [weakself.iFlySpFaceRequest setParameter:@"2000" forKey:@"wait_time"];
        weakself.faceImagePreView.image = faceImage;
        NSData* imgData=[faceImage compressedData];
        NSLog(@"reg image data length: %lu",(unsigned long)[imgData length]);
        [weakself.iFlySpFaceRequest sendRequest:imgData];
    }];
    [self.navigationController pushViewController:faceVC animated:YES];

}

#pragma mark - Perform results On UI

-(void)updateFaceImage:(NSString*)result{
    if(result == nil){
        return;
    }
    NSError* error;
    NSData* resultData = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
    if(dic){
        NSString* strSessionType=[dic objectForKey:KCIFlyFaceResultSST];
        
        //注册
        if([strSessionType isEqualToString:KCIFlyFaceResultReg]){
            [self praseRegResult:result];
        }
        
        //验证
        if([strSessionType isEqualToString:KCIFlyFaceResultVerify]){
            [self praseVerifyResult:result];
        }
        
        
    }
}


#pragma mark - IFlyFaceRequestDelegate
-(void)onEvent:(int)eventType WithBundle:(NSString*)params{
    NSLog(@"onEvent | params:%@",params);
}

-(void)onData:(NSData* )data{
    NSLog(@"onData | ");
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"result:%@",result);
    
    if (result) {
        self.resultStings = result;
    }
    
}

-(void)onCompleted:(IFlySpeechError*) error{
    NSLog(@"onCompleted | error:%@",[error errorDesc]);
    NSString* errorInfo = [NSString stringWithFormat:@"错误码：%d\n 错误描述：%@",[error errorCode] , [error errorDesc]];
    if(0 != [error errorCode]){
        [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:errorInfo waitUntilDone:NO];
    }
    else{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateFaceImage:self.resultStings];
        });
    }
}

#pragma mark - Data Parser

-(void)praseRegResult:(NSString*)result{
    NSString *resultInfo = @"";
    NSString *resultInfoForLabel = @"";
    
    @try {
        NSError* error;
        NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
        
        if(dic){
            NSString* strSessionType = [dic objectForKey:KCIFlyFaceResultSST];
            
            //注册
            if([strSessionType isEqualToString:KCIFlyFaceResultReg]){
                NSString* rst =[dic objectForKey:KCIFlyFaceResultRST];
                NSString* ret=[dic objectForKey:KCIFlyFaceResultRet];
                if([ret integerValue]!=0){
                    resultInfo=[resultInfo stringByAppendingFormat:@"注册错误\n错误码：%@",ret];
                }else{
                    if(rst && [rst isEqualToString:KCIFlyFaceResultSuccess]){
                        NSString* gid = [dic objectForKey:KCIFlyFaceResultGID];
                        resultInfo=[resultInfo stringByAppendingString:@"检测到人脸\n注册成功！"];
                        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                        [defaults setObject:gid forKey:KCIFlyFaceResultGID];
                        resultInfoForLabel = [resultInfoForLabel stringByAppendingFormat:@"gid:%@",gid];
                        self.lableTitle.text = resultInfoForLabel;
                    }else{
                        resultInfo=[resultInfo stringByAppendingString:@"未检测到人脸\n注册失败！"];
                    }
                }
            }
            [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:resultInfo waitUntilDone:NO];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
    }
    
    
}

-(void)praseVerifyResult:(NSString*)result{
    NSString *resultInfo = @"";
    NSString *resultInfoForLabel = @"";
    
    @try {
        NSError* error;
        NSData* resultData=[result dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary* dic=[NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
        
        if(dic){
            NSString* strSessionType = [dic objectForKey:KCIFlyFaceResultSST];
            
            if([strSessionType isEqualToString:KCIFlyFaceResultVerify]){
                NSString* rst=[dic objectForKey:KCIFlyFaceResultRST];
                NSString* ret=[dic objectForKey:KCIFlyFaceResultRet];
                if([ret integerValue]!=0){
                    resultInfo=[resultInfo stringByAppendingFormat:@"验证错误\n错误码：%@",ret];
                }else{
                    
                    if([rst isEqualToString:KCIFlyFaceResultSuccess]){
                        resultInfo=[resultInfo stringByAppendingString:@"检测到人脸\n"];
                    }else{
                        resultInfo=[resultInfo stringByAppendingString:@"未检测到人脸\n"];
                    }
                    NSString* verf=[dic objectForKey:KCIFlyFaceResultVerf];
                    NSString* score=[dic objectForKey:KCIFlyFaceResultScore];
                    if([verf boolValue]){
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"score:%@\n",score];
                        resultInfo = [resultInfo stringByAppendingString:@"验证结果:验证成功!"];
                    }else{
                        NSUserDefaults* defaults=[NSUserDefaults standardUserDefaults];
                        NSString* gid=[defaults objectForKey:KCIFlyFaceResultGID];
                        resultInfoForLabel=[resultInfoForLabel stringByAppendingFormat:@"last reg gid:%@\n",gid];
                        resultInfo=[resultInfo stringByAppendingString:@"验证结果:验证失败!"];
                    }
                }
                
            }
            
            if([resultInfo length] < 1){
                resultInfo=@"结果异常";
            }
            
            [self performSelectorOnMainThread:@selector(showResultInfo:) withObject:resultInfo waitUntilDone:NO];
        }
        
    }
    @catch (NSException *exception) {
        NSLog(@"prase exception:%@",exception.name);
    }
    @finally {
        
    }
    
    
}

-(void)showResultInfo:(NSString*)resultInfo{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"结果" message:resultInfo delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alert show];
    alert=nil;
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
