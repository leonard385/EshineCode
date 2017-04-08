//
//  MMTrainOfflineLocBtn.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainOfflineLocBtn.h"
#import "MZTimerLabel.h"
#import "NSDate+Helper.h"
@interface MMTrainOfflineLocBtn()<MZTimerLabelDelegate>
@property(nonatomic,strong)MZTimerLabel *lableTime;
@property(nonatomic,strong)UILabel *lableTip;
@end
@implementation MMTrainOfflineLocBtn
-(MZTimerLabel *)lableTime{
    if(_lableTime == nil){
        _lableTime = [[MZTimerLabel alloc]initWithTimerType:MZTimerLabelTypeStopWatch];
        _lableTime.timeLabel.font = [UIFont systemFontOfSize:14.0f];
        _lableTime.textColor = HEXCOLOR(kBlueColor);
        _lableTime.delegate = self;
        [_lableTime setShouldCountBeyondHHLimit:YES];
        [_lableTime setTextAlignment:NSTextAlignmentCenter];
        
    }
    return _lableTime;
}

-(UILabel *)lableTip{
    if(_lableTip == nil){
        _lableTip = [UILabel new];
        [_lableTip setFont:[UIFont systemFontOfSize:12.0f]];
        [_lableTip setTextColor:HEXCOLOR(kBlueColor)];
        _lableTip.text = @"签到";
        [_lableTip setTextAlignment:NSTextAlignmentCenter];
    }
    return _lableTip;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self  TOsetUpSubviews];
    }
    return self;
}

-(void)TOsetUpSubviews{
    [self addSubview:self.lableTime];
    [self addSubview:self.lableTip];
    [self ajustTime];
    
    [_lableTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.mas_centerY).with.offset(-7.0f);
        make.height.mas_equalTo(14.0f);
        make.left.right.mas_equalTo(self);
    }];
    
    [_lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self);
        make.top.mas_equalTo(_lableTip.mas_bottom).with.offset(7.0f);
        make.height.mas_equalTo(21.0f);
    }];
}

-(void)ajustTime{
    NSDate *currentTime = [NSDate date];
    NSTimeInterval seconds = (double)currentTime.hour * 60.0f * 60.0f + (double)currentTime.minute * 60.0f + (double)currentTime.second;
    [_lableTime setStopWatchTime:seconds];
    [_lableTime start];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
