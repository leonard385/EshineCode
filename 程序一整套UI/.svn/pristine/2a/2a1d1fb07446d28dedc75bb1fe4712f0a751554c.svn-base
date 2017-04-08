//
//  HZQDatePickerView.h
//  HZQDatePickerView
//
//  Created by 1 on 15/10/26.
//  Copyright © 2015年 HZQ. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    
    // 开始日期
    DateTypeOfStart = 0,
    
    // 结束日期
    DateTypeOfEnd,
    
}DateType;

typedef NS_ENUM(NSUInteger, DPFormatType) {
    DateFormatType = 1,
    TimeFormatType,
    DateAndTimeType
};

typedef void(^getSelectDateAndType)(NSDate *date,NSString *dateStr,DateType type);

@protocol HZQDatePickerViewDelegate <NSObject>

@optional
- (void)getSelectDate:(NSString *)date type:(DateType)type;

-(void)getSelectDateStr:(NSString *)datestr addDate:(NSDate *)date type:(DateType)type;

@end

@interface HZQDatePickerView : UIView

+ (HZQDatePickerView *)instanceDatePickerView;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerView;

@property (nonatomic, weak) id<HZQDatePickerViewDelegate> delegate;

@property (nonatomic, assign) DateType type;

@property(nonatomic,assign)DPFormatType DateFormat;

@property(nonatomic,copy)getSelectDateAndType getSelectDateAndTypeBlock;

-(void)setGetSelectDateAndTypeBlock:(getSelectDateAndType)getSelectDateAndTypeBlock;
@end
