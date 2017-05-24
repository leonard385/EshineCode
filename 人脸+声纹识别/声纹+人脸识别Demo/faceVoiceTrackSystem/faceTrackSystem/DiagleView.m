//
//  DiagleView.m
//  MSCDemo_UI
//
//  Created by wangdan on 14-12-22.
//
//

#import "DiagleView.h"


@implementation DiagleView


-(instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if( self )
    {
        CGRect screenSize=[[UIScreen mainScreen]bounds];
        int height=screenSize.size.height;
        int width=screenSize.size.width;
        
        self.whiteView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, width,height)];
        self.whiteView.backgroundColor=[UIColor whiteColor];//整个view的白板

        self.viewTitle=[[UILabel alloc]initWithFrame:CGRectMake(width/2-100, 30, 200, 20)];
        self.viewTitle.text=@"";//训练模型
        self.viewTitle.textAlignment=NSTextAlignmentCenter;
        self.viewTitle.textColor=[UIColor blackColor];
        self.viewTitle.backgroundColor = [UIColor clearColor];
        self.viewTitle.font = [UIFont boldSystemFontOfSize:17];
        [self.whiteView addSubview:self.viewTitle];      //整个view 的title
        
        self.backGroundView = [[UIImageView alloc]initWithFrame:CGRectMake(width/2-140.5, 50, 281, 211)];
        self.backGroundView.userInteractionEnabled=YES; //录音小窗口背景白色背景
        self.backGroundView.backgroundColor=[UIColor clearColor];
//
        self.recognitionView = [[UIImageView alloc]initWithFrame:CGRectMake(86, 55, 108, 51)];
        self.recognitionView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"Recognition1"],[UIImage imageNamed:@"Recognition2"],[UIImage imageNamed:@"Recognition3"],[UIImage imageNamed:@"Recognition4"],[UIImage imageNamed:@"Recognition5"],[UIImage imageNamed:@"Recognition6"],[UIImage imageNamed:@"Recognition7"], nil];
        [self.recognitionView setAnimationDuration:1.0f];
        [self.recognitionView setAnimationRepeatCount:0];
        [self.backGroundView addSubview:self.recognitionView];//正在识别中
//
//
        self.recordTitleLable = [[UILabel alloc]initWithFrame:CGRectMake(40, 17, 200, 18)];
        self.recordTitleLable.textAlignment=NSTextAlignmentCenter;
        self.recordTitleLable.textColor = [UIColor colorWithRed:98/255.0 green:98/255.0 blue:98/255.0 alpha:1.0];
        self.recordTitleLable.backgroundColor = [UIColor clearColor];
        self.recordTitleLable.font = [UIFont systemFontOfSize:18];
        self.recordTitleLable.textColor=[UIColor colorWithRed:56/255 green:83/255 blue:172/255 alpha:1];
        [self.backGroundView addSubview:self.recordTitleLable];//录音小窗口标题
//
//
        self.recordView = [[UIImageView alloc]initWithFrame:CGRectMake(86, 55, 108, 51)];
        self.recordView.image = [UIImage imageNamed:@"recordNormal"];
        self.recordView.backgroundColor=[UIColor clearColor];
        [self.backGroundView addSubview:self.recordView];//正常状态的小喇叭
        
        UIView *startButtonView=[[UIView alloc]initWithFrame:CGRectMake(4, 161, 135.5, 43.5)];
        startButtonView.backgroundColor=[UIColor grayColor];
        self.startRecButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [self.startRecButton setBackgroundImage:[UIImage imageNamed:@"speekNormal"] forState:UIControlStateNormal];
        [self.startRecButton setBackgroundImage:[UIImage imageNamed:@"speekDone"] forState:UIControlStateHighlighted];
        [self.startRecButton setBackgroundImage:[UIImage imageNamed:@"cancelDone"] forState:UIControlStateDisabled];
        [self.startRecButton setFrame:CGRectMake(0.5 , 0, 135, 43)];
        [self.startRecButton setTitle:@"开始录音" forState:UIControlStateNormal];
        [self.startRecButton setTitleColor:[UIColor colorWithRed:44/255.0 green:114/255.0 blue:243/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.startRecButton setTitleColor:[UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1] forState:UIControlStateHighlighted];
        [self.startRecButton setTitleColor:[UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1] forState:UIControlStateDisabled];
        self.startRecButton.exclusiveTouch=YES;
        [startButtonView addSubview:self.startRecButton];
        [self.backGroundView addSubview:startButtonView];//开始录音button
        
        
        UIView *stopButtonView=[[UIView alloc]initWithFrame:CGRectMake(141, 161, 136, 43.5)];
        stopButtonView.backgroundColor=[UIColor grayColor];
        self.stopRecButton= [UIButton buttonWithType:UIButtonTypeCustom];
        [self.stopRecButton setBackgroundImage:[UIImage imageNamed:@"cancelNormal"] forState:UIControlStateNormal];
        [self.stopRecButton setBackgroundImage:[UIImage imageNamed:@"cancelDone"] forState:UIControlStateHighlighted];
        [self.stopRecButton setBackgroundImage:[UIImage imageNamed:@"cancelDone"] forState:UIControlStateDisabled];
        [self.stopRecButton setFrame:CGRectMake(0.5, 0, 135, 43)];
        [self.stopRecButton setTitle:@"停止录音" forState:UIControlStateNormal];
        [self.stopRecButton setTitleColor:[UIColor colorWithRed:44/255.0 green:114/255.0 blue:243/255.0 alpha:1.0] forState:UIControlStateNormal];
        [self.stopRecButton setTitleColor:[UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1] forState:UIControlStateHighlighted];
        [self.stopRecButton setTitleColor:[UIColor colorWithRed:172/255.0 green:172/255.0 blue:172/255.0 alpha:1] forState:UIControlStateDisabled];
        self.stopRecButton.tag=2;
        self.stopRecButton.exclusiveTouch=YES;
        
        [stopButtonView addSubview:self.stopRecButton];
        [self.backGroundView addSubview:stopButtonView];//停止录音 button
        
        [self.whiteView addSubview:self.backGroundView];
        
    
        self.resultLabel=[[UILabel alloc]initWithFrame:CGRectMake(width/2-150, 300, 300, 40)];
        self.resultLabel.textAlignment = NSTextAlignmentCenter;
        self.resultLabel.font = [UIFont boldSystemFontOfSize:30];
        self.resultLabel.backgroundColor = [UIColor clearColor];
        self.resultLabel.text = @"";
        [self.whiteView addSubview:self.resultLabel];    //声纹结果lable
        
        self.cancelButton=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [self.cancelButton setTitle:@"返回" forState:UIControlStateNormal];
        self.cancelButton.frame=CGRectMake(width-60, 25, 50, 35);
        [self.cancelButton setTitleColor:[UIColor colorWithRed:44/255.0 green:114/255.0 blue:243/255.0 alpha:1.0] forState:UIControlStateNormal];
        
        [self.whiteView addSubview: self.cancelButton];
        
        [self addSubview:self.whiteView];
        
        return self ;
        
    }
    
    return nil;
}



//供viewcontroller调用，刷新识别图案
-(void)recordViewChangeWithVolume:(int)volume
{

    int index=(volume+1)/8;
    if( index == 0 ){
        [self freshImgwithName:@"record1"];
    }else if( index == 1 ){
        [self freshImgwithName:@"record2"];
    }else if( index == 2 ){
        [self freshImgwithName:@"record3"];
    }else if( index == 3 ){
        [self freshImgwithName:@"record4"];
    }
}



//刷新图案方法
-(void)freshImgwithName:(NSString *)name
{
    self.recordView.image = [UIImage imageNamed:name];
}

//录音小窗口，未录音状态
-(void)recordViewInit
{
    self.recordView.image = [UIImage imageNamed:@"recordNormal"];
    [self.recordView setHidden:NO];    
}



@end
