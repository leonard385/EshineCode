//
//  ESDatePickerView.h
//  ESDatePickerViewDemo
//
//  Created by eshine_lsc on 16/7/7.
//  Copyright © 2016年 eshine_lsc. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ESDatePickerViewDelegate <NSObject>

/**
 *  日期选择代理方法
 *
 *  @param date 日期字符串
 */
-(void)ESDPGetYear:(NSString *)year month:(NSString *)month day:(NSString *)day;

@end

@interface ESDatePickerView : UIView

@property(nonatomic,assign)id<ESDatePickerViewDelegate> delegate;

-(void)setDatePicker;

@end
