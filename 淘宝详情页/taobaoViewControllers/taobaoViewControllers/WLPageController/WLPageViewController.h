//
//  MainViewController.h
//  HeaderViewAndPageView
//
//  Created by su on 16/8/8.
//  Copyright © 2016年 susu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WLPageMacros.h"
#import "WLPageViewConfigModel.h"
@interface WLPageViewController : UIViewController
/**
 *  子控制器
 */
@property (nonatomic, nullable, copy) NSArray<UIViewController *> *viewControllers;

/**
 *  各个控制器标题
 *  Titles of view controllers in page controller.
 */
@property (nonatomic, nullable, copy) NSArray<NSString *> *titles;

//头视图
@property(nonatomic,strong)UIView *headView;

@property(nonatomic,strong)WLPageViewConfigModel *configModel;

- (instancetype)initWithControllers:(NSArray *)viewControlers titles:(NSArray *)titles config:(WLPageViewConfigModel*)config;
@end
