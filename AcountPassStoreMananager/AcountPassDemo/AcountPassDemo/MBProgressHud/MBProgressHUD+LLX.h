//
//  MBProgressHUD+LLX.h
//  qosIos
//
//  Created by liaolx on 15/12/17.
//  Copyright © 2015年 eshine. All rights reserved.
//

#import "MBProgressHUD.h"

@interface MBProgressHUD (LLX)
+ (void)showSuccess:(NSString *)success;
+ (void)showSuccess:(NSString *)success toView:(UIView *)view;
+ (void)showError:(NSString *)error;
+ (void)showError:(NSString *)error toView:(UIView *)view;
+ (MBProgressHUD *)showMessage:(NSString *)message;
+ (MBProgressHUD *)showMessage:(NSString *)message toView:(UIView *)view;
+ (void)hideHUD;
+ (void)hideHUDForView:(UIView *)view;


+ (void)toastMessage:(NSString *)message;
+ (MBProgressHUD *)showMessageAutoDismiss:(NSString *)message;

@end
