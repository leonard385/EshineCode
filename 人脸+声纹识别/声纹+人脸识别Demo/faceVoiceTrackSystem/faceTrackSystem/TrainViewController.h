//
//
//  DiagleView.m
//  MSCDemo_UI
//
//  Created by wangdan on 14-12-22.
//
//

#import <UIKit/UIKit.h>
#import "DiagleView.h"
#import "iflyMSC/IFlyISVDelegate.h"

@interface TrainViewController : UIViewController<IFlyISVDelegate>

@property(nonatomic)     int            screenWidth ;

@property(nonatomic)     int            screenHeight;

@property(nonatomic)    DiagleView      *diagView;  //录音界面

@property(nonatomic)    NSArray         *fixCodeArray; //固定密码类型的文本密码数组

@property(nonatomic)    NSArray         *numCodeArray;  //数字密码类型的文本密码数组

@property(nonatomic)     int            pwdt;      //密码类型

@property(nonatomic)    NSString        *titleString;  //录音界面title

@property(nonatomic)    NSString        *sst;      //服务种类，训练还是验证

@property(nonatomic)    UIAlertView     *trainVerifyAlert;

@end
