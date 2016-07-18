//
//  WDScrollTableCell.m
//  新闻分类导航条
//
//  Created by eshine_33 on 16/7/15.
//  Copyright © 2016年 eshine. All rights reserved.
//

#import "WDScrollTableCell.h"

@implementation WDScrollTableCell

/**
 *  重写cell上tableView属性的set方法
 *
 *  @param tableViewOfOption 形参tableview
 */
- (void)setTableViewOfOption:(UITableView *)tableViewOfOption
{
    //先移除当前tableView
    [_tableViewOfOption removeFromSuperview];
    _tableViewOfOption = tableViewOfOption;
    
    [self.contentView addSubview:tableViewOfOption];
    
    //调整角度
    tableViewOfOption.transform = CGAffineTransformMakeRotation(90 * M_PI / 180);
}

- (void)layoutSubviews
{
    //让cell上tableView的frame和cell一样大小
    self.tableViewOfOption.frame = self.contentView.bounds;
}



- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
