//
//  WLPageViewConfigModel.h
//  taobaoViewControllers
//
//  Created by 倪望龙 on 2017/3/11.
//  Copyright © 2017年 xunyijia. All rights reserved.
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "WLPageMacros.h"
@interface WLPageViewConfigModel : NSObject
@property (nonatomic, assign) CGFloat titleSizeSelected;//选中时的标题尺寸
@property (nonatomic, assign) CGFloat titleSizeNormal;//非选中时的标题尺寸
@property (nonatomic, strong) UIColor *titleColorSelected;//标题选中时的颜色
@property (nonatomic, strong) UIColor *titleColorNormal;//标题非选择时的颜色
@property (nonatomic, nullable, strong) UIColor *progressColor;//进度条的颜色
@property (nonatomic, assign) CGFloat progressWidth;//进度条的长度
@property (nonatomic, assign) CGFloat progressHeight;//进度条的高度
@property (nonatomic, assign) CGFloat menuHeight;//菜单栏高度

@end
