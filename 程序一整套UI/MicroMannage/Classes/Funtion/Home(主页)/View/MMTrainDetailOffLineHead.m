//
//  MMTrainDetailOffLineHead.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainDetailOffLineHead.h"
@interface MMTrainDetailOffLineHead ()<UITextFieldDelegate,UITextViewDelegate>
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UITextField *titleInput;
@property(nonatomic,strong)UIView *line1;
@property(nonatomic,strong)UILabel *lableBegin;
@property(nonatomic,strong)UILabel *lableBeginTime;
@property(nonatomic,strong)UIImageView *imageArrow1;
@property(nonatomic,strong)UIButton *btnBegin;
@property(nonatomic,strong)UIView *line2;
@property(nonatomic,strong)UILabel *lableEnd;
@property(nonatomic,strong)UILabel *lableEndTime;
@property(nonatomic,strong)UIImageView *imageArrow2;
@property(nonatomic,strong)UIButton *btnEnd;
@property(nonatomic,strong)UIView *line3;
@property(nonatomic,strong)UILabel *lableRange;
@property(nonatomic,strong)UITextField *lableRangeNum;
@property(nonatomic,strong)UIView *lineView1;
@property(nonatomic,strong)UILabel *lableSubTitle;
@property(nonatomic,strong)UITextView *textViewContent;
@property(nonatomic,strong)UILabel *lableLimit;
@property(nonatomic,strong)UIView *lineView2;
@end
@implementation MMTrainDetailOffLineHead

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.text = @"目录标题";
    }
    return _lableTitle;
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

-(UILabel *)lableBegin{
    if(_lableBegin == nil){
        _lableBegin = [UILabel new];
        _lableBegin.font = [UIFont systemFontOfSize:16.0f];
        _lableBegin.textColor = HEXCOLOR(0x333333);
        _lableBegin.text = @"开始时间";
    }
    return _lableBegin;
}

-(UILabel *)lableBeginTime{
    if(_lableBeginTime == nil){
        _lableBeginTime = [UILabel new];
        _lableBeginTime.font = [UIFont systemFontOfSize:15.0f];
        _lableBeginTime.textColor = HEXCOLOR(0x999999);
        [_lableBeginTime setTextAlignment:NSTextAlignmentRight];
        _lableBeginTime.text = @"2013-07-09 08:00";
    }
    return _lableBeginTime;

}

-(UIImageView *)imageArrow1{
    if(_imageArrow1 == nil){
        _imageArrow1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_gengduo"]];
        [_imageArrow1 setContentMode:UIViewContentModeCenter];
    }
    return _imageArrow1;
}

-(UIButton *)btnBegin{
    if(_btnBegin == nil){
        _btnBegin = [UIButton new];
        [_btnBegin addTarget:self action:@selector(btnBeginClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnBegin;
}

-(UIView *)line2{
    if(_line2 == nil){
        _line2 = [UIView new];
        _line2.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line2;
}

-(UILabel *)lableEnd{
    if(_lableEnd == nil){
        _lableEnd = [UILabel new];
        _lableEnd.font = [UIFont systemFontOfSize:16.0f];
        _lableEnd.textColor = HEXCOLOR(0x333333);
        _lableEnd.text = @"结束时间";
    }
    return _lableEnd;
}

-(UILabel *)lableEndTime{
    if(_lableEndTime == nil){
        _lableEndTime = [UILabel new];
        _lableEndTime.font = [UIFont systemFontOfSize:15.0f];
        _lableEndTime.textColor = HEXCOLOR(0x999999);
        [_lableEndTime setTextAlignment:NSTextAlignmentRight];
        _lableEndTime.text = @"2013-07-09 10:00";
    }
    return _lableEndTime;
    
}

-(UIImageView *)imageArrow2{
    if(_imageArrow2 == nil){
        _imageArrow2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_gengduo"]];
        [_imageArrow2 setContentMode:UIViewContentModeCenter];
    }
    return _imageArrow2;
}

-(UIButton *)btnEnd{
    if(_btnEnd == nil){
        _btnEnd = [UIButton new];
        [_btnEnd addTarget:self action:@selector(btnEndClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnEnd;
}

-(UIView *)line3{
    if(_line3 == nil){
        _line3 = [UIView new];
        _line3.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line3;
}

-(UILabel *)lableRange{
    if(_lableRange == nil){
        _lableRange = [UILabel new];
        _lableRange.font = [UIFont systemFontOfSize:16.0f];
        _lableRange.textColor = HEXCOLOR(0x333333);
        _lableRange.text = @"签到范围";
    }
    return _lableRange;
}

-(UITextField *)lableRangeNum{
    if(_lableRangeNum == nil){
        _lableRangeNum = [[UITextField alloc]init];
        [_lableRangeNum setPlaceholder:@"请输入"];
        [_lableRangeNum setTextColor:HEXCOLOR(0x999999)];
        [_lableRangeNum setFont:[UIFont systemFontOfSize:15.0f]];
        [_lableRangeNum setBorderStyle:UITextBorderStyleNone];
        [_lableRangeNum setClearButtonMode:UITextFieldViewModeWhileEditing];
        [_lableRangeNum setTextAlignment:NSTextAlignmentRight];
        _lableRangeNum.delegate = self;
    }
    return _lableRangeNum;
}

-(UIView *)lineView1{
    if(_lineView1 == nil){
        _lineView1 = [UIView new];
        _lineView1.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _lineView1;
}

-(UILabel *)lableSubTitle{
    if(_lableSubTitle == nil){
        _lableSubTitle = [UILabel new];
        _lableSubTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableSubTitle.textColor = HEXCOLOR(0x333333);
        _lableSubTitle.text = @"目录描述";
    }
    return _lableSubTitle;
}

-(UITextView *)textViewContent{
    if(_textViewContent == nil){
        _textViewContent = [UITextView new];
        [_textViewContent setFont:[UIFont systemFontOfSize:15.0f weight:22.0f]];
        [_textViewContent setTextColor:HEXCOLOR(0x999999)];
        _textViewContent.delegate = self;
    }
    return _textViewContent;
}

-(UILabel *)lableLimit{
    if(_lableLimit == nil){
        _lableLimit = [UILabel new];
        _lableLimit.font = [UIFont systemFontOfSize:16.0f];
        _lableLimit.textColor = HEXCOLOR(0x999999);
        _lableLimit.text = @"16/99";
        _lableLimit.textAlignment = NSTextAlignmentRight;
    }
    return _lableLimit;
}



-(UIView *)lineView2{
    if(_lineView2 == nil){
        _lineView2 = [UIView new];
        _lineView2.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _lineView2;
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self TDSetUpSubviews];
    }
    return self;
}

-(void)TDSetUpSubviews{

    [self addSubview:self.lableTitle];
    [self addSubview:self.titleInput];
    [self addSubview:self.line1];
    [self addSubview:self.lableBegin];
    [self addSubview:self.lableBeginTime];
    [self addSubview:self.imageArrow1];
    [self addSubview:self.btnBegin];
    [self addSubview:self.line2];
    [self addSubview:self.lableEnd];
    [self addSubview:self.lableEndTime];
    [self addSubview:self.imageArrow2];
    [self addSubview:self.btnEnd];
    [self addSubview:self.line3];
    [self addSubview:self.lableRange];
    [self addSubview:self.lableRangeNum];
    [self addSubview:self.lineView1];
    [self addSubview:self.lableSubTitle];
    [self addSubview:self.textViewContent];
    [self addSubview:self.lableLimit];
    [self addSubview:self.lineView2];
    
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
        make.left.right.mas_equalTo(_line1);
        make.height.mas_equalTo(0.5f);
    }];
    
    [_lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_line3.mas_bottom).with.offset(44.0f);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(10.0f);
    }];
    
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_line1);
        make.top.mas_equalTo(self);
        make.bottom.mas_equalTo(_line1.mas_top);
        make.width.mas_equalTo(65.0f);
    }];
    
    [_lableBegin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_line1);
        make.top.mas_equalTo(_line1.mas_bottom);
        make.bottom.mas_equalTo(_line2.mas_top);
        make.width.mas_equalTo(65.0f);
    }];
    
    [_lableEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_line2);
        make.top.mas_equalTo(_line2.mas_bottom);
        make.bottom.mas_equalTo(_line3.mas_top);
        make.width.mas_equalTo(65.0f);
    }];
    
    [_lableRange mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_line3);
        make.top.mas_equalTo(_line3.mas_bottom);
        make.bottom.mas_equalTo(_lineView1.mas_top);
        make.width.mas_equalTo(65.0f);
    }];
    
    [_titleInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_lableTitle);
        make.right.mas_equalTo(_line1);
        make.left.mas_equalTo(_lableTitle.mas_right).with.offset(8.0f);
    }];
    
    [_imageArrow1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_line2);
        make.top.bottom.mas_equalTo(_lableBegin);
        make.width.mas_equalTo(15.0f);
    }];
    
    [_lableBeginTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_lableBegin);
        make.left.mas_equalTo(_titleInput);
        make.right.mas_equalTo(_imageArrow1.mas_left).with.offset(-5.0f);
    }];
    
    [_btnBegin mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_lableBegin);
        make.left.right.mas_equalTo(_line2);
    }];
    
    [_imageArrow2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_line3);
        make.top.bottom.mas_equalTo(_lableEnd);
        make.width.mas_equalTo(15.0f);
    }];
    
    [_lableEndTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_lableEnd);
        make.left.mas_equalTo(_titleInput);
        make.right.mas_equalTo(_imageArrow2.mas_left).with.offset(-5.0f);
    }];
    
    [_btnEnd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_lableEnd);
        make.left.right.mas_equalTo(_line3);
    }];
    
    [_lableRangeNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_titleInput);
        make.top.bottom.mas_equalTo(_lableRange);
    }];
    
    
    [_lableSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_line1);
        make.top.mas_equalTo(_lineView1.mas_bottom);
        make.height.mas_equalTo(44.0f);
    }];
    
    [_textViewContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableSubTitle.mas_bottom);
        make.left.right.mas_equalTo(_line1);
        make.height.mas_equalTo(73.0f);
    }];
    
    [_lableLimit mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_textViewContent);
        make.height.mas_equalTo(21.0f);
        make.top.mas_equalTo(_textViewContent.mas_bottom);
    }];
    
    [_lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableLimit.mas_bottom).with.offset(12.0f);
        make.left.right.bottom.mas_equalTo(self);
        make.height.mas_equalTo(10.0f);
    }];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
#pragma mark - 开始时间点击
-(void)btnBeginClick{

}

#pragma mark - 结束时间点击
-(void)btnEndClick{
    
}

@end
