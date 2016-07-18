//
//  WDTopMenu.h
//  新闻分类导航条
//
//  Created by eshine_33 on 16/7/15.
//  Copyright © 2016年 eshine. All rights reserved.

/*
 1.这个类是顶部菜单类
 使用scrollView实现
 */

#import <UIKit/UIKit.h>
@class WDTopMenu;
@protocol WDTopMenuDelegate <NSObject>
@optional;
- (void)wdTopMenu:(WDTopMenu *)topMenu curSelectedBtnOptionIndex:(NSInteger)index;
@end




@interface WDTopMenu : UIView

//顶部菜单选项数组
@property (nonatomic, strong) NSMutableArray *arrMTopMenuOptions;

//记录当前选中的菜单选项 (btn)
@property (nonatomic, strong) UIButton *btnCurSelected;

//代理对象
@property (nonatomic, weak) id<WDTopMenuDelegate> delegate;

/**
 *  根据小标索引选中指定的选项按钮
 *
 *  @param index 指定的索引
 */
- (void)selectBtnOptionWith:(NSInteger )index;
@end
