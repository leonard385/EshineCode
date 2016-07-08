//
//  ESAlertSelectorStringCell.h
//  弹出对话框选择器
//
//  Created by eshine_lsc on 16/4/5.
//  Copyright © 2016年 eshine_lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ESAlertSelectorStringCell : UITableViewCell
/**
 *  cell文本属性
 */
@property (nonatomic ,strong) UILabel * labelText;
/**
 *  下划线
 */
@property (nonatomic ,strong) UIView * bottomView;
@end
