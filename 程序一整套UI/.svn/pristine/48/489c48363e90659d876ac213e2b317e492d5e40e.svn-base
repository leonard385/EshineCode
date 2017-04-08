//
//  MMTrainCreateHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/24.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainCreateHeadView.h"
@interface MMTrainCreateHeadView()<UITextFieldDelegate>
@property(nonatomic,strong)UIImageView *postImageView;
@property(nonatomic,strong)UILabel *labletTitle;
@property(nonatomic,strong)UITextField *titleInput;
@property(nonatomic,strong)UIView *titleLine;//竖线
@property(nonatomic,strong)UIButton *btnPosterImage;//海报
@property(nonatomic,strong)UIView *line1;
@property(nonatomic,strong)UILabel *labletPeoTitle;
@property(nonatomic,strong)UILabel *lablePeoples;
@property(nonatomic,strong)UIImageView *imageArrow1;
@property(nonatomic,strong)UIButton *btnPeople;
@property(nonatomic,strong)UIView *line2;
@property(nonatomic,strong)UILabel *labletTime;
@property(nonatomic,strong)UILabel *labletDate;
@property(nonatomic,strong)UIImageView *imageArrow2;
@property(nonatomic,strong)UIButton *btnDate;
@property(nonatomic,strong)UIView *line3;
@property(nonatomic,assign)CGFloat postImageH;//158.0f
@end
@implementation MMTrainCreateHeadView

-(UIImageView *)postImageView{
    if(_postImageView == nil){
        _postImageView = [UIImageView new];
        _postImageView.backgroundColor = [UIColor redColor];
    }
    return _postImageView;
}

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

-(UIView *)titleLine{
    if(_titleLine == nil){
        _titleLine = [UIView new];
        _titleLine.backgroundColor = HEXCOLOR(0x999999);
    }
    return _titleLine;

}

-(UIButton *)btnPosterImage{
    if(_btnPosterImage == nil){
        _btnPosterImage = [UIButton new];
        [_btnPosterImage.imageView setContentMode:UIViewContentModeCenter];
        [_btnPosterImage setImage:[UIImage imageNamed:@"bth_icon_tjtp"] forState:UIControlStateNormal];
        [_btnPosterImage addTarget:self action:@selector(btnPosterImageClick) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _btnPosterImage;
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

-(UIImageView *)imageArrow1{
    if(_imageArrow1 == nil){
        _imageArrow1 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_gengduo"]];
        [_imageArrow1 setContentMode:UIViewContentModeCenter];
    }
    return _imageArrow1;
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

-(UIImageView *)imageArrow2{
    if(_imageArrow2 == nil){
        _imageArrow2 = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_gengduo"]];
        [_imageArrow2 setContentMode:UIViewContentModeCenter];
    }
    return _imageArrow2;
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
    }
    return _line3;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self){
        _postImageH = 0.0f;
        [self TCSetUpSubviews];
    }
    return self;
}
#pragma mark - 约束更新
-(void)updateConstraints{
    [_postImageView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.mas_equalTo(self);
        make.height.mas_equalTo(_postImageH);
    }];
    [super updateConstraints];
}

-(void)TCSetUpSubviews{
    [self addSubview:self.postImageView];
    [self addSubview:self.labletTitle];
    [self addSubview:self.titleInput];
    [self addSubview:self.titleLine];
    [self addSubview:self.btnPosterImage];
    [self addSubview:self.line1];
    [self addSubview:self.labletPeoTitle];
    [self addSubview:self.lablePeoples];
    [self addSubview:self.imageArrow1];
    [self addSubview:self.btnPeople];
    [self addSubview:self.line2];
    [self addSubview:self.labletTime];
    [self addSubview:self.labletDate];
    [self addSubview:self.imageArrow2];
    [self addSubview:self.btnDate];
    [self addSubview:self.line3];
    
    [_line1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_postImageView.mas_bottom).with.offset(44.0f);
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
        make.top.mas_equalTo(_postImageView.mas_bottom);
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
    
    [_btnPosterImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(_line1);
        make.top.mas_equalTo(_labletTitle);
        make.width.mas_equalTo(32.0f);
    }];
    
    [_titleLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_btnPosterImage.mas_left).with.offset(-9.0f);
        make.top.mas_equalTo(_labletTitle).with.offset(12.0f);
        make.bottom.mas_equalTo(_line1).with.offset(-12.0f);
        make.width.mas_equalTo(0.5f);
    }];
    
    [_titleInput mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labletTitle);
        make.bottom.mas_equalTo(_line1);
        make.left.mas_equalTo(_labletTitle.mas_right).with.offset(8.0f);
        make.right.mas_equalTo(_titleLine.mas_left).with.offset(-9.0f);
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
    
    [_imageArrow2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_line3);
        make.top.bottom.mas_equalTo(_labletDate);
        make.width.mas_equalTo(15.0f);
    }];
    
    [_labletDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_labletTime);
        make.bottom.mas_equalTo(_line3);
        make.left.mas_equalTo(_titleInput);
        make.right.mas_equalTo(_imageArrow2.mas_left).with.offset(-5.0f);
    }];
    
    [_btnDate mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_labletTime);
        make.left.right.mas_equalTo(_line3);
    }];

}

#pragma mark - 海报点击

-(void)btnPosterImageClick{

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
