//
//  DiagleView.h
//  MSCDemo_UI
//
//  Created by wangdan on 14-12-22.
//
//

#import <UIKit/UIKit.h>


@interface DiagleView : UIView

@property(nonatomic) UIButton       *startRecButton;   //开始录音button

@property(nonatomic) UIButton       *stopRecButton;    //停止录音button

@property(nonatomic) UIButton       *settingButton;    //设置固定密码种类按钮

@property(nonatomic) UIButton       *cancelButton;    //取消训练按钮

@property(nonatomic) UIImageView    *recognitionView;   //正在识别中的动画

@property(nonatomic) UIImageView    *recordView;    //录音小窗口中的小喇叭

@property(nonatomic) UILabel        *recordTitleLable;  //录音小窗口title

@property(nonatomic) UILabel        *viewTitle;  //整个view的title

@property(nonatomic) UILabel        *resultLabel; //录音结果label

@property(nonatomic) UIImageView    *backGroundView;  //录音小窗口

@property(nonatomic) UIView         *whiteView; //整个界面的白色背景



-(void)recordViewInit; //revordView 初始化为小喇叭图案

-(void)recordViewChangeWithVolume:(int)volume;  //revordView 刷新音量动画


@end

