//
//  MMErrorNotebookItem.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/9.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMErrorNotebookItem.h"

@interface MMErrorNotebookItem()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@property(nonatomic,strong)UIView *middleLine;
@end

@implementation MMErrorNotebookItem

-(UILabel *)lableTitle{
    if(_lableTitle ==  nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(kBlueColor)];
        [_lableTitle setFont:[UIFont systemFontOfSize:36.0f]];
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
        _lableSubtitle.text = @"错题数";
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
        [self ENSetUpSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self ENSetUpSubviews];
    }
    return self;
}

-(void)ENSetUpSubviews{
    [self addSubview:self.lableTitle];
    [self addSubview:self.lableSubtitle];
    [self addSubview:self.middleLine];
    [_middleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(62.0f);
        make.left.mas_equalTo(self).with.offset(12.0f);
        make.right.mas_equalTo(self).with.offset(-12.0f);
        make.height.mas_equalTo(1.0f);
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_middleLine.mas_top).with.offset(-2.0f);
        make.left.right.mas_equalTo(_middleLine);
        make.height.mas_equalTo(38.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(_middleLine.mas_bottom).with.offset(2.0f);
        make.left.right.mas_equalTo(_middleLine);
        make.height.mas_equalTo(21.0f);
    }];
}

-(instancetype)initWithTitle:(NSString *)title{
    self = [super init];
    if(self){
        [self ENSetUpSubviews];
        _lableSubtitle.text = title;
    }
    return self;
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
