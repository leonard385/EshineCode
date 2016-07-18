//
//  WDSortShowController.h
//  新闻分类导航条
//
//  Created by eshine_33 on 16/7/15.
//  Copyright © 2016年 eshine. All rights reserved.

/*
 这个是最外部的接触类
 实现思路是：
 1.顶部是一个独立的scrollview展示菜单选项
 2.底部是一个水平放置的TableView 每一个cell显示不同菜单对应的控制器
 
 */

#import <UIKit/UIKit.h>
#import "WDTopMenu.h"
#import "WDScrollTableCell.h"


@interface WDSortShowController : UIViewController

//菜单选项数据源数组
@property (nonatomic, strong) NSMutableArray *arrMOptionsData;
//存储底部tableView的cell上 对应的菜单选项的tabelview
@property (nonatomic, strong) NSMutableArray *arrMTableViewsOfOption;

//菜单的frame
@property (nonatomic, assign) CGRect topMenuFrame;
//底部tablViewFrame
@property (nonatomic, assign) CGRect bottomTableViewFrame;
@end
