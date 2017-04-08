//
//  MMTrainOfflineCreateHead.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainOfflineCreateHead.h"
@interface MMTrainOfflineCreateHead()<UITextFieldDelegate>
@property(nonatomic,strong)UILabel *labletTitle;
@property(nonatomic,strong)UITextField *titleInput;
@property(nonatomic,strong)UIView *line1;
@property(nonatomic,strong)UILabel *labletPeoTitle;
@property(nonatomic,strong)UILabel *lablePeoples;
@property(nonatomic,strong)UIButton *btnPeople;
@property(nonatomic,strong)UIImageView *imageArrow1;
@property(nonatomic,strong)UIView *line2;
@property(nonatomic,strong)UILabel *labletAddrTitle;
@property(nonatomic,strong)UILabel *lableAddrs;
@property(nonatomic,strong)UIButton *btnLoaction;
@property(nonatomic,strong)UIView *line3;
@property(nonatomic,strong)UILabel *labletDetailTitle;
@property(nonatomic,strong)UITextField *inputDetail;
@property(nonatomic,strong)UIView *line4;

@end

@implementation MMTrainOfflineCreateHead

-(UILabel *)labletTitle{
    if(_labletTitle == nil){
        _labletTitle = [UILabel new];
        _labletTitle.font = [UIFont systemFontOfSize:16.0f];
        _labletTitle.textColor = HEXCOLOR(0x333333);
        _labletTitle.text = @"培训主题";
    }
    return _labletTitle;
}

-(UITextField *)titleInput{
    if(_titleInput == nil){
        _titleInput = [[UITextField alloc]init];
        [_titleInput setPlaceholder:@"请输入"];
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
        _labletPeoTitle.text = @"参与人员";
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

-(UIImageView *)imageArrow1{
    if(_imageArrow1 == nil){
        _imageArrow1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_gengduo"]];
        [_imageArrow1 setContentMode:UIViewContentModeCenter];
    }
    return _imageArrow1;
}

-(UIView *)line2{
    if(_line2 == nil){
        _line2 = [UIView new];
        _line2.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line2;
}

-(UILabel *)labletAddrTitle{
    if(_labletAddrTitle == nil){
        _labletAddrTitle = [UILabel new];
        _labletAddrTitle.font = [UIFont systemFontOfSize:16.0f];
        _labletAddrTitle.textColor = HEXCOLOR(0x333333);
        _labletAddrTitle.text = @"培训地址";
    }
    return _labletAddrTitle;
}

-(UILabel *)lableAddrs{
    if(_lableAddrs == nil){
        _lableAddrs = [UILabel new];
        _lableAddrs.font = [UIFont systemFontOfSize:15.0f];
        _lableAddrs.textColor = HEXCOLOR(0x999999);
        [_lableAddrs setTextAlignment:NSTextAlignmentRight];
        _lableAddrs.text = @"广东省 广州市 天河区";
    }
    return _lableAddrs;
}

-(UIButton *)btnLoaction{
    if(_btnLoaction == nil){
        _btnLoaction = [UIButton new];
        [_btnLoaction setImage:[UIImage imageNamed:@"icon_ditu"] forState:UIControlStateNormal];
        [_btnLoaction setImage:[UIImage imageNamed:@"icon_ditu1"] forState:UIControlStateHighlighted];
        [_btnLoaction addTarget:self action:@selector(btnLocationClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnLoaction;
}

-(UIView *)line3{
    if(_line3 == nil){
        _line3 = [UIView new];
        _line3.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line3;
}

-(UILabel *)labletDetailTitle{
    if(_labletDetailTitle == nil){
        _labletDetailTitle = [UILabel new];
        _labletDetailTitle.font = [UIFont systemFontOfSize:16.0f];
        _labletDetailTitle.textColor = HEXCOLOR(0x333333);
        _labletDetailTitle.text = @"门牌号";
    }
    return _labletDetailTitle;
}

-(UITextField *)inputDetail{
    if(_inputDetail == nil){
        _inputDetail = [[UITextField alloc]init];
        [_inputDetail setTextColor:HEXCOLOR(0x999999)];
        [_inputDetail setFont:[UIFont systemFontOfSize:15.0f]];
        [_inputDetail setBorderStyle:UITextBorderStyleNone];
        [_inputDetail setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_inputDetail setTextAlignment:NSTextAlignmentRight];
        _inputDetail.delegate = self;
    }
    return _inputDetail;
}

-(UIView *)line4{
    if(_line4 == nil){
        _line4 = [UIView new];
        _line4.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line4;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self TOSetUpSubviews];
    }
    return self;
}

-(void)TOSetUpSubviews{
    [self addSubview:self.labletTitle];
    [self addSubview:self.titleInput];
    [self addSubview:self.line1];
    [self addSubview:self.labletPeoTitle];
    [self addSubview:self.lablePeoples];
    [self addSubview:self.btnPeople];
    [self addSubview:self.imageArrow1];
    [self addSubview:self.line2];
    [self addSubview:self.labletAddrTitle];
    [self addSubview:self.lableAddrs];
    [self addSubview:self.btnLoaction];
    [self addSubview:self.line3];
    [self addSubview:self.labletDetailTitle];
    [self addSubview:self.inputDetail];
    [self addSubview:self.line4];
    
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
    
    [_line4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line3.mas_bottom).with.offset(44.0f);
        make.left.right.mas_equalTo(_line3);
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
    
    [_labletAddrTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line2.mas_bottom);
        make.left.bottom.mas_equalTo(_line3);
        make.width.mas_equalTo(65.0f);
    }];
    
    [_labletDetailTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line3.mas_bottom);
        make.left.bottom.mas_equalTo(_line4);
        make.width.mas_equalTo(65.0f);
    }];
    
    [_titleInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labletTitle);
        make.bottom.mas_equalTo(_line1);
        make.left.mas_equalTo(_labletTitle.mas_right).with.offset(8.0f);
        make.right.mas_equalTo(_line1);
    }];
    
    [_imageArrow1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_line2);
        make.top.bottom.mas_equalTo(_lablePeoples);
        make.width.mas_equalTo(15.0f);
    }];
    
    [_lablePeoples mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labletPeoTitle);
        make.bottom.mas_equalTo(_line2);
        make.left.mas_equalTo(_titleInput);
        make.right.mas_equalTo(_imageArrow1.mas_left).with.offset(-5.0f);
    }];
    
    [_btnPeople mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_labletPeoTitle);
        make.left.right.mas_equalTo(_line2);
    }];
    
    [_btnLoaction mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_line2);
        make.top.bottom.mas_equalTo(_lableAddrs);
        make.width.mas_equalTo(25.0f);
    }];
    
    [_lableAddrs mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_labletAddrTitle);
        make.left.mas_equalTo(_labletAddrTitle.mas_right).with.offset(8.0f);
        make.right.mas_equalTo(_btnLoaction.mas_left).with.offset(-8.0f);
    }];
    
    [_inputDetail mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labletDetailTitle);
        make.bottom.mas_equalTo(_line4);
        make.left.mas_equalTo(_labletDetailTitle.mas_right).with.offset(8.0f);
        make.right.mas_equalTo(_line4);
    }];
}

#pragma mark - 定位按钮点击
-(void)btnLocationClick{
    _btnLocationClickBlock?_btnLocationClickBlock():nil;
}

#pragma mark - 人员点击
-(void)btnPeopleClick{
    _btnPeopleClickBlock?_btnPeopleClickBlock():nil;
}

-(void)setBtnLocationClickBlock:(btnLocationClick)btnLocationClickBlock PeopleClickBlock:(btnPeopleClick)btnPeopleClickBlock{
    _btnPeopleClickBlock = btnPeopleClickBlock;
    _btnLocationClickBlock = btnLocationClickBlock;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
