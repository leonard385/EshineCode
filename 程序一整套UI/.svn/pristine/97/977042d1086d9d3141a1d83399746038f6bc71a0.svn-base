//
//  MMWorkCreateHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/21.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMWorkCreateHeadView.h"
@interface MMWorkCreateHeadView()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *labletTitle;
@property(nonatomic,strong)UITextField *titleInput;
@property(nonatomic,strong)UIView *line1;
@property(nonatomic,strong)UILabel *labletPeoTitle;
@property(nonatomic,strong)UILabel *lablePeoples;
@property(nonatomic,strong)UIButton *btnPeople;
@property(nonatomic,strong)UIView *line2;
@property(nonatomic,strong)UILabel *labletTime;
@property(nonatomic,strong)UILabel *labletDate;
@property(nonatomic,strong)UIButton *btnDate;
@property(nonatomic,strong)UIView *line3;
@end
@implementation MMWorkCreateHeadView
-(UILabel *)labletTitle{
    if(_labletTitle == nil){
        _labletTitle = [UILabel new];
        _labletTitle.font = [UIFont systemFontOfSize:16.0f];
        _labletTitle.textColor = HEXCOLOR(0x333333);
        _labletTitle.text = @"工作标题";
    }
    return _labletTitle;
}

-(UITextField *)titleInput{
    if(_titleInput == nil){
        _titleInput = [[UITextField alloc]init];
        [_titleInput setPlaceholder:@"请输入工作标题"];
        [_titleInput setTextColor:HEXCOLOR(0x999999)];
        [_titleInput setFont:[UIFont systemFontOfSize:15.0f]];
        [_titleInput setBorderStyle:UITextBorderStyleNone];
        [_titleInput setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_titleInput setTextAlignment:NSTextAlignmentRight];
        _titleInput.delegate = self;
    }
    return _titleInput;
}

-(UIView *)line1{
    if(_line1 == nil){
        _line1 = [UIView new];
        _line1.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line1;
}

-(UILabel *)labletPeoTitle{
    if(_labletPeoTitle == nil){
        _labletPeoTitle = [UILabel new];
        _labletPeoTitle.font = [UIFont systemFontOfSize:16.0f];
        _labletPeoTitle.textColor = HEXCOLOR(0x333333);
        _labletPeoTitle.text = @"执行人员";
    }
    return _labletPeoTitle;
}

-(UILabel *)lablePeoples{
    if(_lablePeoples == nil){
        _lablePeoples = [UILabel new];
        _lablePeoples.font = [UIFont systemFontOfSize:15.0f];
        _lablePeoples.textColor = HEXCOLOR(0x999999);
        [_lablePeoples setTextAlignment:NSTextAlignmentRight];
        _lablePeoples.text = @"小三小四小五";
    }
    return _lablePeoples;
}

-(UIButton *)btnPeople{
    if(_btnPeople == nil){
        _btnPeople = [UIButton new];
        [_btnPeople addTarget:self action:@selector(btnPeopleClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPeople;
}

-(UIView *)line2{
    if(_line2 == nil){
        _line2 = [UIView new];
        _line2.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line2;
}

-(UILabel *)labletTime{
    if(_labletTime == nil){
        _labletTime = [UILabel new];
        _labletTime.font = [UIFont systemFontOfSize:16.0f];
        _labletTime.textColor = HEXCOLOR(0x333333);
        _labletTime.text = @"完成时间";
    }
    return _labletTime;
}

-(UILabel *)labletDate{
    if(_labletDate == nil){
        _labletDate = [UILabel new];
        _labletDate.font = [UIFont systemFontOfSize:15.0f];
        _labletDate.textColor = HEXCOLOR(0x999999);
        _labletDate.text  = @"2017-02-08";
        [_labletDate setTextAlignment:NSTextAlignmentRight];
    }
    return _labletDate;
}

-(UIButton *)btnDate{
    if(_btnDate == nil){
        _btnDate = [UIButton new];
        [_btnDate addTarget:self action:@selector(btnTimeClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnDate;
}


-(UIView *)line3{
    if(_line3 == nil){
        _line3 = [UIView new];
        _line3.backgroundColor = HEXCOLOR(0xcccccc);
        _line3.hidden = YES;
    }
    return _line3;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self WCSetUpSubviews];
    }
    return self;
}

-(void)WCSetUpSubviews{
    [self addSubview:self.labletTitle];
    [self addSubview:self.titleInput];
    [self addSubview:self.line1];
    [self addSubview:self.labletPeoTitle];
    [self addSubview:self.lablePeoples];
    [self addSubview:self.btnPeople];
    [self addSubview:self.line2];
    [self addSubview:self.labletTime];
    [self addSubview:self.labletDate];
    [self addSubview:self.btnDate];
    [self addSubview:self.line3];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(44.0f);
        make.left.mas_equalTo(self).with.offset(12.0f);
        make.right.mas_equalTo(self).with.offset(-12.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
    [_line2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line1.mas_bottom).with.offset(44.0f);
        make.left.right.mas_equalTo(_line1);
        make.height.mas_equalTo(0.5f);
    }];
    
    [_line3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line2.mas_bottom).with.offset(44.0f);
        make.left.right.mas_equalTo(_line2);
        make.height.mas_equalTo(0.5f);
    }];
    
    [_labletTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self);
        make.left.bottom.mas_equalTo(_line1);
        make.width.mas_equalTo(65.0f);
    }];
    
    [_labletPeoTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line1.mas_bottom);
        make.left.bottom.mas_equalTo(_line2);
        make.width.mas_equalTo(65.0f);
    }];
    
    [_labletTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line2.mas_bottom);
        make.left.bottom.mas_equalTo(_line3);
        make.width.mas_equalTo(65.0f);
    }];
    
    [_titleInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labletTitle);
        make.right.bottom.mas_equalTo(_line1);
        make.left.mas_equalTo(_labletTitle.mas_right).with.offset(8.0f);
    }];
    
    [_lablePeoples mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labletPeoTitle);
        make.right.bottom.mas_equalTo(_line2);
        make.left.mas_equalTo(_titleInput);
    }];
    
    [_btnPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_labletPeoTitle);
        make.left.right.mas_equalTo(_line2);
    }];
    
    [_labletDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labletTime);
        make.right.bottom.mas_equalTo(_line3);
        make.left.mas_equalTo(_titleInput);
    }];
    
    [_btnDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_labletTime);
        make.left.right.mas_equalTo(_line3);
    }];
}

#pragma mark - 用户点击
-(void)btnPeopleClick{
  
}

#pragma mark - 时间点击
-(void)btnTimeClick{
  
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
