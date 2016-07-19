//
//  WDScrollTableCell.h
//  新闻分类导航条
//
//  Created by eshine_33 on 16/7/15.
//  Copyright © 2016年 eshine. All rights reserved.

/*
 这个类是菜单下面 水平放置的tableView容器的Cell
 每一个cell上放置一个垂直滚动的tableview展示菜单对应的数据
 */

#import <UIKit/UIKit.h>

@interface WDScrollTableCell : UITableViewCell
//每一个菜单选项 对应的数据用tableView展示在 水平放置的tabeleView容器上
@property (nonatomic, strong) UITableView *tableViewOfOption;
@end
