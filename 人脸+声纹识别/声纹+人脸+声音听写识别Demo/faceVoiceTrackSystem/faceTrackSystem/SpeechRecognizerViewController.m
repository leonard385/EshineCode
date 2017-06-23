//
//  SpeechRecognizerViewController.m
//  faceTrackSystem
//
//  Created by 倪望龙 on 2017/6/22.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "SpeechRecognizerViewController.h"
#import <iflyMSC/IFlyMSC.h>
#import <QuartzCore/QuartzCore.h>
#import "IATConfig.h"
#import "ISRDataHelper.h"
#import "UIButton+BackgroundColor.h"
//人脸验证
#import "faceDetectController.h"
#import <iflyMSC/IFlyFaceSDK.h>
#import "UIImage+Extensions.h"
#import "UIImage+compress.h"
#import "IFlyFaceResultKeys.h"


@interface SpeechRecognizerViewController ()<IFlySpeechRecognizerDelegate,IFlyFaceRequestDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textViewResult;
@property (weak, nonatomic) IBOutlet UILabel *labelVoiceLevel;
@property (weak, nonatomic) IBOutlet UIButton *btnStart;
@property (weak, nonatomic) IBOutlet UILabel *labelStateTip;
@property (weak, nonatomic) IBOutlet UIButton *btnStop;


@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;//语音听写
@property (nonatomic, strong) IFlyDataUploader *wordUploader;//数据上传对象

@property (nonatomic,strong)NSMutableArray *dataArray;
@property (nonatomic,strong)NSMutableDictionary *nameKeysDic;
@property (nonatomic,strong)NSString * result;
//人脸数据验证
@property (nonatomic,strong) IFlyFaceRequest * iFlySpFaceRequest;
@property (nonatomic,strong) NSString *resultStings;
@end

@implementation SpeechRecognizerViewController

-(NSMutableArray *)dataArray{
    if(_dataArray == nil){
        _dataArray = [NSMutableArray new];
    }
    return _dataArray;
}

-(NSMutableDictionary *)nameKeysDic{
    if(_nameKeysDic == nil){
        _nameKeysDic = [NSMutableDictionary new];
    }
    return _nameKeysDic;
}

-(IFlySpeechRecognizer *)iFlySpeechRecognizer{
    if(_iFlySpeechRecognizer == nil){
        _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
        //设置为听写模式
        [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        //设置音频来源为麦克风
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
        //设置听写结果格式为json
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        [_iFlySpeechRecognizer setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
        _iFlySpeechRecognizer.delegate = self;
    }
    return _iFlySpeechRecognizer;
}

-(IFlyDataUploader *)wordUploader{
    if(_wordUploader == nil){
        _wordUploader = [[IFlyDataUploader alloc]init];
        [_wordUploader setParameter:@"uup" forKey:[IFlySpeechConstant SUBJECT]];
        [_wordUploader setParameter:@"userword" forKey:[IFlySpeechConstant DATA_TYPE]];
    }
    return _wordUploader;
}

-(IFlyFaceRequest *)iFlySpFaceRequest{
    if(_iFlySpFaceRequest == nil){
        _iFlySpFaceRequest = [IFlyFaceRequest sharedInstance];
        _iFlySpFaceRequest.delegate = self;
    }
    return _iFlySpFaceRequest;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self SRDataInit];
    [self SRsetUpSubViews];
    // Do any additional setup after loading the view.
}

#pragma mark - 数据初始化
-(void)SRDataInit{
    NSString *plistPath = [[NSBundle mainBundle]pathForResource:@"nameList" ofType:@"plist"];
    NSDictionary *temp = [NSDictionary dictionaryWithContentsOfFile:plistPath];
    [self.nameKeysDic addEntriesFromDictionary:temp];
    [self.dataArray addObjectsFromArray:temp.allKeys];
    
    NSMutableString *showText = [NSMutableString new];
    [self.dataArray enumerateObjectsUsingBlock:^(NSString*  _Nonnull name, NSUInteger idx, BOOL * _Nonnull stop) {
        [showText appendFormat:@"%@\n",name];
    }];
    _textViewResult.text = showText;
    
    //词汇数据上传
    //词汇上传必须 实例化
    [self.iFlySpeechRecognizer stopListening];
    NSMutableDictionary *wordDic = [NSMutableDictionary new];
    wordDic[@"name"] = @"常用词";
    wordDic[@"words"] = temp.allKeys;
    NSMutableDictionary *words = [NSMutableDictionary new];
    words[@"userword"] = @[wordDic];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:words options:0 error:nil];
    NSString *jsonStr = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    IFlyUserWords *iFlyUserWords = [[IFlyUserWords alloc] initWithJson:jsonStr];
    [self.wordUploader uploadDataWithCompletionHandler:^(NSString *result, IFlySpeechError *error) {
        [self onUploadFinished:error];
    } name:@"userwords" data:[iFlyUserWords toString]];
}

-(void)SRsetUpSubViews{
    _textViewResult.layer.borderWidth = 1.0f;
    _textViewResult.layer.borderColor = [UIColor blackColor].CGColor;
    _textViewResult.layer.cornerRadius  = 7.0f;
    
    [_btnStart setBackgroundColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [_btnStop setBackgroundColor:[UIColor orangeColor] forState:UIControlStateNormal];
    
    [_btnStart setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [_btnStop setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
}

#pragma mark - 开始听写
- (IBAction)btnStartRecognizer:(id)sender {
    BOOL ret = [self.iFlySpeechRecognizer startListening];
    if(ret){
        _textViewResult.text = @"";
    }else{
        NSLog(@"启动识别服务失败，请稍后重试");
    }
}

#pragma mark - 停止听写
- (IBAction)btnStopClick:(id)sender {
    [self.iFlySpeechRecognizer stopListening];
}

#pragma mark - 验证
-(void)searchResult:(NSString *)key{
    _labelStateTip.text = @"正在搜索...";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS %@", key];
    NSArray *filterArray = [self.dataArray filteredArrayUsingPredicate:predicate];
    if(filterArray.count == 0){
        _labelStateTip.text = @"无匹配项";
    }else{
        //找数据
        NSString *key = filterArray.firstObject;
        NSString *gid = [self.nameKeysDic valueForKey:key];
        _labelStateTip.text = [NSString stringWithFormat:@"结果:%@",gid];
        //推入验证视图
        [self verifyFacePeople:gid];
    }
}

-(void)verifyFacePeople:(NSString *)gid{
    __weak __typeof(self) weakself = self;
    faceDetectController *faceVC = [faceDetectController new];
    [faceVC setGetFacePictureBlock:^(UIImage *faceImage) {
        [weakself.navigationController popToViewController:self animated:YES];
        [weakself.iFlySpFaceRequest setParameter:[IFlySpeechConstant FACE_VERIFY] forKey:[IFlySpeechConstant FACE_SST]];
        [weakself.iFlySpFaceRequest setParameter:USER_APPID forKey:[IFlySpeechConstant APPID]];
        [weakself.iFlySpFaceRequest setParameter:USER_APPID forKey:@"auth_id"];
        [weakself.iFlySpFaceRequest setParameter:@"2000" forKey:@"wait_time"];
        [weakself.iFlySpFaceRequest setParameter:gid forKey:[IFlySpeechConstant FACE_GID]];
        NSData* imgData = [faceImage compressedData];
        NSLog(@"reg image data length: %lu",(unsigned long)[imgData length]);
        [weakself.iFlySpFaceRequest sendRequest:imgData];
    }];
    [self.navigationController pushViewController:faceVC animated:YES];
}

#pragma mark - IFlySpeechRecognizerDelegate

#pragma mark - 音量回掉
/* volume 0－30*/
-(void)onVolumeChanged:(int)volume{
    self.labelVoiceLevel.text = [NSString stringWithFormat:@"音量: %d",volume];
}

#pragma mark - 开始录音
-(void)onBeginOfSpeech{
    _btnStop.enabled = YES;
    _btnStart.enabled = NO;
    _labelStateTip.text = @"状态: progressing..";
}

#pragma mark - 停止录音
-(void)onEndOfSpeech{
    _btnStop.enabled = NO;
    _btnStart.enabled = YES;
    _labelStateTip.text = @"状态: Stop";
    [self searchResult:_textViewResult.text];
}

#pragma mark - 识别错误
-(void)onError:(IFlySpeechError *)error{
    if(error.errorCode == 0){
    
    }else{
       
    }
}

#pragma mark - 结果回调
-(void)onResults:(NSArray *)results isLast:(BOOL)isLast{
    
    NSMutableString *resultString = [[NSMutableString alloc] init];
    NSDictionary *dic = results[0];
    for (NSString *key in dic) {
        [resultString appendFormat:@"%@",key];
    }
    _result = [NSString stringWithFormat:@"%@%@", _textViewResult.text,resultString];
    NSString * resultFromJson =  [ISRDataHelper stringFromJson:resultString];
    _textViewResult.text = [NSString stringWithFormat:@"%@%@", _textViewResult.text,resultFromJson];
    
    if (isLast){
        NSLog(@"听写结果(json)：%@测试",  self.result);
    }
    NSLog(@"_result=%@",_result);
    NSLog(@"resultFromJson=%@",resultFromJson);
    NSLog(@"isLast=%d,_textView.text=%@",isLast,_textViewResult.text);
}

#pragma mark - IFlyDataUploaderDelegate

/**
 上传联系人和词表的结果回调
 error ，错误码
 ****/
- (void)onUploadFinished:(IFlySpeechError *)error
{
    NSLog(@"%d",[error errorCode]);
    
    if ([error errorCode] == 0) {
        NSLog(@"上传成功");
    }
    else {
        NSLog(@"%@",[NSString stringWithFormat:@"上传失败，错误码:%d",error.errorCode]);
    }
}


#pragma mark - 人脸验证
#pragma mark - Perform results On UI

-(void)updateFaceImage:(NSString*)result{
    if(result == nil){
        return;
    }
    NSError* error;
    NSData* resultData = [result dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary* dic = [NSJSONSerialization JSONObjectWithData:resultData options:NSJSONReadingMutableContainers error:&error];
    if(dic){
        NSString* strSessionType = [dic objectForKey:KCIFlyFaceResultSST];
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
