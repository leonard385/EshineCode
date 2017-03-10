//
//  HZQDatePickerView.m
//  HZQDatePickerView
//
//  Created by 1 on 15/10/26.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import "HZQDatePickerView.h"
#import "UIColor+HexString.h"
//屏幕的宽度
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
//屏幕的高度
#define ScreenHeight [UIScreen mainScreen].bounds.size.height

#define kDateFormat @"yyyy-MM-dd"
#define kTimeFormat @"HH:mm:ss"
#define kDateTimeFormat @"yyyy-MM-dd HH:mm:ss"

@interface HZQDatePickerView ()

@property (nonatomic, strong) NSString *selectDate;

@property (weak, nonatomic) IBOutlet UIButton *cannelBtn;
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;
@property (weak, nonatomic) IBOutlet UIView *backgVIew;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *rightPadding;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftPadding;

@property(nonatomic,strong)NSDate *DTselectDate;

@property(nonatomic,strong)NSString *TimeFormatString;
@end

@implementation HZQDatePickerView

+ (HZQDatePickerView *)instanceDatePickerView
{
    NSArray* nibView =  [[NSBundle mainBundle] loadNibNamed:@"HZQDatePickerView" owner:nil options:nil];
    return [nibView objectAtIndex:0];
}

- (void)awakeFromNib
{
    self.backgVIew.layer.cornerRadius = 5;
    self.backgVIew.layer.borderWidth = 1;
    self.backgVIew.layer.borderColor = [[UIColor clearColor] CGColor];
    self.backgVIew.layer.masksToBounds = YES;
    
    /** 确定 */
    self.sureBtn.layer.cornerRadius = 4;
    self.sureBtn.layer.borderWidth = 1;
    [self.sureBtn setTitleColor:[UIColor colorwithHexString:@"37C3A9"] forState:0];
    self.sureBtn.layer.borderColor = [[UIColor colorwithHexString:@"37C3A9"] CGColor];
    self.sureBtn.layer.masksToBounds = YES;
    
    /** 取消按钮 */
    self.cannelBtn.layer.cornerRadius = 4;
    self.cannelBtn.layer.borderWidth = 1;
    self.cannelBtn.layer.borderColor = [[UIColor colorwithHexString:@"BAB9B9"] CGColor];
    self.cannelBtn.layer.masksToBounds = YES;
    
    if (ScreenWidth > 320) {
        // IPHONE 6
        self.leftPadding.constant += 20;
        self.rightPadding.constant += 20;
        if (ScreenWidth > 400) {
            // IPHONE 6 PLUS
            self.leftPadding.constant += 20;
            self.rightPadding.constant += 20;
        }
    }
    
    [_datePickerView addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged];
    
    [_datePickerView setTimeZone:[NSTimeZone defaultTimeZone]];
}

- (NSString *)timeFormat
{
    NSDate *selected = _DTselectDate;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:_TimeFormatString];//修改时区为东8区
    NSString *currentOlderOneDateStr = [dateFormatter stringFromDate:selected];
    return currentOlderOneDateStr;
}

- (void)animationbegin:(UIView *)view {
    /* 放大缩小 */
    
    // 设定为缩放
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    
    // 动画选项设定
    animation.duration = 0.1; // 动画持续时间
    animation.repeatCount = -1; // 重复次数
    animation.autoreverses = YES; // 动画结束时执行逆动画
    
    // 缩放倍数
    animation.fromValue = [NSNumber numberWithFloat:1.0]; // 开始时的倍率
    animation.toValue = [NSNumber numberWithFloat:0.9]; // 结束时的倍率
    
    // 添加动画
    [view.layer addAnimation:animation forKey:@"scale-layer"];
    
}

// 退出键盘
- (IBAction)blackBtnClick:(id)sender {
    [self.superview endEditing:YES];
}

// 取消
- (IBAction)removeBtnClick:(id)sender {
    // 开始动画
    [self animationbegin:sender];
    
    [UIView animateWithDuration:0.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

// 确定
- (IBAction)sureBtnClick:(id)sender {
    // 开始动画
    [self animationbegin:sender];
    _DTselectDate = self.datePickerView.date;
    
    self.selectDate = [self timeFormat];
    
    
    //delegate
    if([_delegate respondsToSelector:@selector(getSelectDateStr:addDate:type:)]){
        [self.delegate getSelectDateStr:self.selectDate addDate:_DTselectDate type:self.type];
    }
    
    if(_getSelectDateAndTypeBlock){
        _getSelectDateAndTypeBlock(self.datePickerView.date,_selectDate,self.type);
    }
    
    [self removeBtnClick:nil];
}

-(void)dateChanged:(UIControl *)Sender
{
    UIDatePicker* control = (UIDatePicker*)Sender;
    _DTselectDate = control.date;
}

-(void)setDateFormat:(DPFormatType)DateFormat
{
    _DateFormat = DateFormat;
    switch (DateFormat) {
        case DateFormatType:
        {
            [_datePickerView setDatePickerMode:UIDatePickerModeDate];
            _TimeFormatString = kDateFormat;
        }
            break;
            
        case TimeFormatType:
        {
            [_datePickerView setDatePickerMode:UIDatePickerModeTime];
            _TimeFormatString = kTimeFormat;
        }
            break;
            
        case DateAndTimeType:
        {
            [_datePickerView setDatePickerMode:UIDatePickerModeDateAndTime];
             _TimeFormatString = kDateTimeFormat;
        }
            break;
            
            
        default:
            break;
    }
}

@end


