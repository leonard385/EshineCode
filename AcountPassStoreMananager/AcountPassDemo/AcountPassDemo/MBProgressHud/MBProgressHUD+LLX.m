//
//  MBProgressHUD+LLX.m
//  qosIos
//
//  Created by liaolx on 15/12/17.
//  Copyright © 2015年 eshine. All rights reserved.
//

#import "MBProgressHUD+LLX.h"

@implementation MBProgressHUD (LLX)

#pragma mark 显示信息
+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    // 设置图片
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"MBProgressHUD.bundle/%@", icon]]];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    
    // 1秒之后再消失
    [hud hide:YES afterDelay:1.0];
}


#pragma mark 显示正确信息
+ (void)showSuccess:(NSString *)success
{
    [self showSuccess:success toView:nil];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"success.png" view:view];
}


#pragma mark 显示错误信息
+ (void)showError:(NSString *)error
{
    [self showError:error toView:nil];
}

+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"error.png" view:view];
}

#pragma mark 显示一些信息
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    return hud;
}

#pragma mark 显示一些信息延时后消失

+ (MBProgressHUD *)showMessage:(NSString *)message
{
    return [self showMessage:message toView:nil];
}

+ (MBProgressHUD *)showMessage:(NSString *)message toViewAfterDelay:(UIView *)view{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
    
    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    // YES代表需要蒙版效果
    hud.dimBackground = NO;
    // 1秒之后再消失
    [hud hide:YES afterDelay:0.8];
    return hud;
}


+ (MBProgressHUD *)showMessageAutoDismiss:(NSString *)message
{
    return [self showMessage:message toViewAfterDelay:nil];
}

+ (void)toastMessage:(NSString *)message
{
    UIWindow        *window = [[UIApplication sharedApplication].windows lastObject];
    MBProgressHUD   *hud = [MBProgressHUD showHUDAddedTo:window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.labelText = message;
    hud.labelFont = [UIFont systemFontOfSize:13];
    hud.margin = 10.f;
    hud.yOffset = (window.frame.size.height/2)*0.8;
    hud.removeFromSuperViewOnHide = YES;
    [hud hide:YES afterDelay:1.0];
    
    [window bringSubviewToFront:hud];
}

#pragma mark 显示一些信息
+ (void)hideHUDForView:(UIView *)view
{
    if (view == nil) view = [[UIApplication sharedApplication].windows lastObject];
    [self hideHUDForView:view animated:YES];
}

+ (void)hideHUD
{
    [self hideHUDForView:nil];
}

@end
