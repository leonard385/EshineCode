//
//  MMEMStatisticHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEMStatisticHeadView.h"
@interface MMEMStatisticHeadView()
@property(nonatomic,strong)UILabel *lableDistrict;
@property(nonatomic,strong)UILabel *lableTotal;
@property(nonatomic,strong)UILabel *lableLeave;
@property(nonatomic,strong)UILabel *lableAdd;
@property(nonatomic,strong)UILabel *lableLeavePercent;
@end

@implementation MMEMStatisticHeadView
-(UILabel *)lableDistrict{
    if(_lableDistrict == nil){
        _lableDistrict = [UILabel new];
        [_lableDistrict setTextColor:HEXCOLOR(0x333333)];
        [_lableDistrict setTextAlignment:NSTextAlignmentCenter];
        [_lableDistrict setText:@"地区"];
        [_lableDistrict setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableDistrict;
}

-(UILabel *)lableTotal{
    if(_lableTotal == nil){
        _lableTotal = [UILabel new];
        [_lableTotal setTextColor:HEXCOLOR(0x333333)];
        [_lableTotal setTextAlignment:NSTextAlignmentCenter];
        [_lableTotal setText:@"总员工数"];
        [_lableTotal setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableTotal;
}

-(UILabel *)lableLeave{
    if(_lableLeave == nil){
        _lableLeave = [UILabel new];
        [_lableLeave setTextColor:HEXCOLOR(0x333333)];
        [_lableLeave setTextAlignment:NSTextAlignmentCenter];
        [_lableLeave setText:@"离职员工数"];
        [_lableLeave setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableLeave;
}
-(UILabel *)lableAdd{
    if(_lableAdd == nil){
        _lableAdd = [UILabel new];
        [_lableAdd setTextColor:HEXCOLOR(0x333333)];
        [_lableAdd setTextAlignment:NSTextAlignmentCenter];
        [_lableAdd setText:@"新增员工数"];
        [_lableAdd setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableAdd;
}
-(UILabel *)lableLeavePercent{
    if(_lableLeavePercent == nil){
        _lableLeavePercent = [UILabel new];
        [_lableLeavePercent setTextColor:HEXCOLOR(0x333333)];
        [_lableLeavePercent setTextAlignment:NSTextAlignmentCenter];
        [_lableLeavePercent setText:@"离职率"];
        [_lableLeavePercent setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableLeavePercent;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self SHSetUpSubviews];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
       [self SHSetUpSubviews];
    }
    return self;
}

-(void)SHSetUpSubviews{
    self.backgroundColor = HEXCOLOR(0xf1f7ff);
    [self addSubview:self.lableDistrict];
    [self addSubview:self.lableTotal];
    [self addSubview:self.lableLeave];
    [self addSubview:self.lableAdd];
    [self addSubview:self.lableLeavePercent];
    
    [_lableDistrict mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(self);
        make.width.mas_equalTo(_lableTotal);
    }];
    
    [_lableTotal mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(_lableDistrict.mas_right);
        make.width.mas_equalTo(_lableDistrict);
    }];
    
    [_lableLeave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(_lableTotal.mas_right);
        make.width.mas_equalTo(_lableTotal);
    }];
    
    [_lableAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self);
        make.left.mas_equalTo(_lableLeave.mas_right);
        make.width.mas_equalTo(_lableLeave);
    }];
    
    [_lableLeavePercent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(self);
        make.left.mas_equalTo(_lableAdd.mas_right);
        make.width.mas_equalTo(_lableAdd);
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
