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
#import "WLPageViewController.h"
#import "WLTouchTableTableView.h"
@interface WLPageViewController : UIViewController
@property (nonatomic ,strong) WLTouchTableTableView * mainTableView;
@property (nonatomic, nullable, copy) NSArray<UIViewController *> *viewControllers;
@property (nonatomic, nullable, copy) NSArray<NSString *> *titles;
@property(nonatomic,strong)UIView *WLtableHeadView; //头视图
@property(nonatomic,strong)WLPageViewConfigModel *configModel;

- (instancetype)initWithControllers:(NSArray *)viewControlers titles:(NSArray *)titles config:(WLPageViewConfigModel*)config;

- (instancetype)initWithControllers:(NSArray *)viewControlers titles:(NSArray *)titles;
@end
