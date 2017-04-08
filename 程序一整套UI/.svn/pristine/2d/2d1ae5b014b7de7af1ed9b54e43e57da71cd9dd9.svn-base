//
//  MMEvaluationRecordItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEvaluationRecordItem.h"
@interface MMEvaluationRecordItem()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@property(nonatomic,strong)UIView *middleLine;
@end

@implementation MMEvaluationRecordItem
-(UILabel *)lableTitle{
    if(_lableTitle ==  nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(kBlueColor)];
        [_lableTitle setFont:[UIFont systemFontOfSize:50.0f]];
        [_lableTitle setTextAlignment:NSTextAlignmentCenter];
        _lableTitle.adjustsFontSizeToFitWidth = YES;
    }
    return _lableTitle;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle ==  nil){
        _lableSubtitle = [UILabel new];
        [_lableSubtitle setTextColor:HEXCOLOR(0x999999)];
        [_lableSubtitle setFont:[UIFont systemFontOfSize:15.0f]];
        [_lableSubtitle setTextAlignment:NSTextAlignmentCenter];
        _lableSubtitle.text = @"最好成绩";
    }
    return _lableSubtitle;
}

-(UIView *)middleLine{
    if(_middleLine == nil){
        _middleLine = [UIView new];
        _middleLine.backgroundColor = HEXCOLOR(kBlueColor);
    }
    return _middleLine;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self ERSetUpSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self ERSetUpSubviews];
    }
    return self;
}

-(void)ERSetUpSubviews{
    [self addSubview:self.lableTitle];
    [self addSubview:self.lableSubtitle];
    [self addSubview:self.middleLine];
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(89.0f);
        make.left.mas_equalTo(self).with.offset(20.0f);
        make.right.mas_equalTo(self).with.offset(-20.0f);
        make.height.mas_equalTo(1.0f);
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_middleLine.mas_top).with.offset(-4.0f);
        make.left.right.mas_equalTo(_middleLine);
        make.height.mas_equalTo(60.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_middleLine.mas_bottom).with.offset(9.0f);
        make.left.right.mas_equalTo(_middleLine);
        make.height.mas_equalTo(21.0f);
    }];

}

-(void)setNum:(NSString *)num{
    _num  = num;
    _lableTitle.text = num;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
