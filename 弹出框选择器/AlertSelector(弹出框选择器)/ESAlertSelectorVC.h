//
//  ESAlertSelectorVC.h
//  弹出对话框选择器
//
//  Created by eshine_lsc on 16/4/5.
//  Copyright © 2016年 eshine_lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESAlertSelectorVCDelegate <NSObject>

/**
 *  ESAlertSelectorVCDelegate方法
 *
 *  @param button 点击弹出对话框的button
 *  @param row    选中的行
 */
-(void)selectorButton:(UIButton *)button selectWithRow:(NSInteger)row;

@end

@interface ESAlertSelectorVC : UIViewController

/**
 *  代理属性
 */
@property (nonatomic ,weak) id<ESAlertSelectorVCDelegate> delegate;

/**
 *  选择器标题
 */
@property (nonatomic ,copy) NSString * titleSelect;

/**
 *  选择内容数据源数组，只能是字符串数组
 */
@property (nonatomic ,strong) NSArray<NSString *> * arrData;
/**
 *  点击弹出对话框的button
 */
@property (nonatomic ,strong) UIButton * button;


/**
 *  创建弹出对话框选择器
 *
 *  @param button 点击弹出对话框的button
 *  @param title  选择器标题
 *
 *  @return 选择器
 */
-(instancetype)initWithButton:(UIButton *)button title:(NSString *)title;


/**
 *  类方法创建弹出对话框选择器
 *
 *  @param button 点击弹出对话框的button
 *  @param title  选择器标题
 *
 *  @return 选择器
 */
+(instancetype)selectorAddButton:(UIButton *)button title:(NSString *)title;

/**
 *  弹出选择器
 */
-(void)gogogo;

@end
