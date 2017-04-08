//
//  MMEvaluationRecordHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEvaluationRecordHeadView.h"
#import "MMEmployeeHeadBtnItem.h"
#define kBtntTagOffset 100
@interface MMEvaluationRecordHeadView()
@property(nonatomic,strong)UIView *contentView;
@property(nonatomic,strong)MMEmployeeHeadBtnItem *itemExamNum;
@property(nonatomic,strong)MMEmployeeHeadBtnItem *itemPass;
@property(nonatomic,strong)MMEmployeeHeadBtnItem *itemUnpass;
@property(nonatomic,strong)UIView *bar;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UIView *line;
@end

@implementation MMEvaluationRecordHeadView

-(UIView *)contentView{
    if(_contentView == nil){
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}
-(MMEmployeeHeadBtnItem *)itemExamNum{
    if(_itemExamNum == nil){
        _itemExamNum = [[MMEmployeeHeadBtnItem alloc]init];
        [_itemExamNum setEHtitle:@"57"];
        [_itemExamNum setEHsubtitle:@"考试次数"];
        [_itemExamNum setEHlineColor:HEXCOLOR(0xfdda4f)];
        _itemExamNum.tag = kBtntTagOffset + 0;
        [_itemExamNum setBackgroundColor:HEXCOLOR(0xf0f3f8) forState:UIControlStateHighlighted];
        [_itemExamNum addTarget:self action:@selector(ERbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _itemExamNum;
}

-(MMEmployeeHeadBtnItem *)itemPass{
    if(_itemPass == nil){
        _itemPass = [[MMEmployeeHeadBtnItem alloc]init];
        [_itemPass setEHtitle:@"19"];
        [_itemPass setEHsubtitle:@"已通过"];
        [_itemPass setEHlineColor:HEXCOLOR(0x5dd054)];
        _itemPass.tag = kBtntTagOffset + 1;
        [_itemPass setBackgroundColor:HEXCOLOR(0xf0f3f8) forState:UIControlStateHighlighted];
        [_itemPass addTarget:self action:@selector(ERbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _itemPass;
}
-(MMEmployeeHeadBtnItem *)itemUnpass{
    if(_itemUnpass == nil){
        _itemUnpass = [[MMEmployeeHeadBtnItem alloc]init];
        [_itemUnpass setEHtitle:@"4"];
        [_itemUnpass setEHsubtitle:@"未通过"];
        [_itemUnpass setEHlineColor:HEXCOLOR(0x69a5e1)];
        _itemUnpass.tag = kBtntTagOffset + 2;
        [_itemUnpass setBackgroundColor:HEXCOLOR(0xf0f3f8) forState:UIControlStateHighlighted];
        [_itemUnpass addTarget:self action:@selector(ERbtnClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _itemUnpass;
}

-(UIView *)bar{
    if(_bar == nil){
        _bar = [UIView new];
        _bar.backgroundColor = [UIColor whiteColor];
    }
    return _bar;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:16.0f]];
        _lableTitle.text = @"历史成绩";
    }
    return _lableTitle;
}

-(UIView *)line{
    if(_line == nil){
        _line = [UIView new];
        _line.backgroundColor = HEXCOLOR(kLineColor);
    }
    return _line;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self RHSetUpSubViews];
    }
    return self;
}

-(void)RHSetUpSubViews{
    self.backgroundColor = HEXCOLOR(0xefeff4);
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.itemExamNum];
    [self.contentView addSubview:self.itemPass];
    [self.contentView addSubview:self.itemUnpass];
    [self addSubview:self.bar];
    [self.bar addSubview:self.lableTitle];
    [self.bar addSubview:self.line];
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(10.0f);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(137.0f);
    }];
    
    [_itemExamNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_contentView);
        make.left.mas_equalTo(_contentView).with.offset(12.0f);
        make.width.mas_equalTo(_itemPass);
        make.height.mas_equalTo(107.0f);
    }];
    
    [_itemPass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_itemExamNum);
        make.left.mas_equalTo(_itemExamNum.mas_right);
        make.width.mas_equalTo(_itemUnpass);
    }];
    
    [_itemUnpass mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_itemExamNum);
        make.left.mas_equalTo(_itemPass.mas_right);
        make.width.mas_equalTo(_itemPass);
        make.right.mas_equalTo(_contentView).with.offset(-12.0f);
    }];
    
    [_bar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(44.0f);
    }];
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(_bar).with.insets(UIEdgeInsetsMake(0, 12.0f, 0, 12.0f));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(_bar);
        make.height.mas_equalTo(0.5f);
    }];
}

-(void)ERbtnClick:(UIButton *)btn{
    NSUInteger tag = btn.tag - kBtntTagOffset;
//    _EHBtnClickBlock ? _EHBtnClickBlock(tag):nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
