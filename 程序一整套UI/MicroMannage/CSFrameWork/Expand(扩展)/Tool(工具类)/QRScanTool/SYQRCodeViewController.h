//
//  SYQRCodeViewController.h
//  SYQRCodeDemo
//
//  Created by sunbb on 15-1-9.
//  Copyright (c) 2015年 SY. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SYQRCodeViewController : UIViewController

@property (nonatomic, copy) void (^SYQRCodeCancleBlock) (SYQRCodeViewController *);//扫描取消
@property (nonatomic, copy) void (^SYQRCodeSuncessBlock) (SYQRCodeViewController *,NSString *);//扫描结果
@property (nonatomic, copy) void (^SYQRCodeFailBlock) (SYQRCodeViewController *);//扫描失败

@end
