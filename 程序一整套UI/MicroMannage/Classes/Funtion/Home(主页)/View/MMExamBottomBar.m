//
//  MMExamBottomBar.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/20.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMExamBottomBar.h"
#import "MZTimerLabel.h"
#import "MMUpDownButton.h"
@interface MMExamBottomBar()<MZTimerLabelDelegate>
@property(nonatomic,strong)UIProgressView *progressBar;
@property(nonatomic,strong)UIView *btnContainer;
@property(nonatomic,strong)UIView *timeContainer;
@property(nonatomic,strong)UIImageView *imageclock;
@property(nonatomic,strong)MZTimerLabel *lableTime;
@property(nonatomic,strong)UIView *verline;//中线
@property(nonatomic,strong)UIButton *btnHandIn;//交卷

@property(nonatomic,strong)MMUpDownButton *btnCollect;//收藏
@property(nonatomic,strong)MMUpDownButton *btnCard;//答题卡

@end
@implementation MMExamBottomBar

-(UIProgressView *)progressBar{
    if(_progressBar == nil){
        _progressBar = [[UIProgressView alloc]init];
        _progressBar.progressTintColor = HEXCOLOR(kBlueColor);
        _progressBar.trackTintColor = HEXCOLOR(0xcccccc);
        _progressBar.progress = 0.8f;
    }
    return _progressBar;
}

-(UIView *)btnContainer{
    if(_btnContainer == nil){
        _btnContainer = [UIView new];
        _btnContainer.backgroundColor = [UIColor whiteColor];
        _btnContainer.layer.borderColor = HEXCOLOR(kBlueColor).CGColor;
        _btnContainer.layer.borderWidth = 1.0f;
        _btnContainer.layer.cornerRadius = 18.5f;
        _btnContainer.layer.masksToBounds = YES;
    }
    return _btnContainer;
}

-(UIView *)timeContainer{
    if(_timeContainer == nil){
    _timeContainer = [UIView new];
    }
    return _timeContainer;
}

-(UIImageView *)imageclock{
    if(_imageclock == nil){
        _imageclock = [UIImageView new];
        _imageclock.image = [UIImage imageNamed:@"content_jieshou"];
        _imageclock.contentMode = UIViewContentModeCenter;
    }
    return _imageclock;
}

-(MZTimerLabel *)lableTime{
    if(_lableTime == nil){
        _lableTime = [[MZTimerLabel alloc]initWithTimerType:MZTimerLabelTypeTimer];
        _lableTime.timeLabel.font = [UIFont systemFontOfSize:12.0f];
        _lableTime.textColor = HEXCOLOR(kBlueColor);
        _lableTime.adjustsFontSizeToFitWidth = YES;
        _lableTime.delegate = self;
        [_lableTime setCountDownTime:2];
        [_lableTime start];
    }
    return _lableTime;
}

-(UIView *)verline{
    if(_verline == nil){
        _verline = [UIView new];
        _verline.backgroundColor = HEXCOLOR(kBlueColor);
    }
    return _verline;
}

-(UIButton *)btnHandIn{
    if(_btnHandIn == nil){
        _btnHandIn = [UIButton new];
        [_btnHandIn setTitle:@"立即交卷" forState:UIControlStateNormal];
        [_btnHandIn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_btnHandIn setTitleColor:HEXCOLOR(0xcccccc) forState:UIControlStateHighlighted];
        [_btnHandIn.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_btnHandIn addTarget:self action:@selector(EBHandInClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnHandIn;
}

-(MMUpDownButton *)btnCollect{
    if(_btnCollect == nil){
        _btnCollect = [MMUpDownButton new];
        [_btnCollect setTitle:@"收藏" forState:UIControlStateNormal];
        [_btnCollect setImage:[UIImage imageNamed:@"tab_shoucang"] forState:UIControlStateNormal];
        [_btnCollect setImage:[UIImage imageNamed:@"tab_shoucang1"] forState:UIControlStateSelected];
        [_btnCollect setTitleColor:HEXCOLOR(0xcccccc) forState:UIControlStateNormal];
        [_btnCollect setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateSelected];
        [_btnCollect.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [_btnCollect addTarget:self action:@selector(EBCollectClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCollect;
}

-(MMUpDownButton *)btnCard{
    if(_btnCard == nil){
        _btnCard = [MMUpDownButton new];
        [_btnCard setTitle:@"答题卡" forState:UIControlStateNormal];
        [_btnCard setImage:[UIImage imageNamed:@"tab_datika"] forState:UIControlStateNormal];
        [_btnCard setImage:[UIImage imageNamed:@"tab_datika1"] forState:UIControlStateSelected];
        [_btnCard setTitleColor:HEXCOLOR(0xcccccc) forState:UIControlStateNormal];
        [_btnCard setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateSelected];
        [_btnCard.titleLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [_btnCard addTarget:self action:@selector(EBCardtClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCard;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self EBSetUpSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self EBSetUpSubviews];
    }
    return self;
}

-(void)EBSetUpSubviews{
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.progressBar];
    [self addSubview:self.btnContainer];
    [self addSubview:self.timeContainer];
    [self.timeContainer addSubview:self.imageclock];
    [self.timeContainer addSubview:self.lableTime];
    [self addSubview:self.verline];
    [self addSubview:self.btnHandIn];
    [self addSubview:self.btnCollect];
    [self addSubview:self.btnCard];
    
    
    [_progressBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(2.0f);
    }];
    
    [_btnContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).with.offset(33.0f);
        make.centerY.mas_equalTo(self).with.offset(2.0f);
        make.size.mas_equalTo(CGSizeMake(158.0f, 37.0f));
    }];
    
    [_timeContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.mas_equalTo(_btnContainer);
        make.width.mas_equalTo(self.btnHandIn);
        make.right.mas_equalTo(_verline.mas_left);
    }];
    
    [_verline mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.centerX.mas_equalTo(_btnContainer);
        make.width.mas_equalTo(1.0f);
    }];
    
    [_btnHandIn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_verline.mas_right);
        make.right.top.bottom.mas_equalTo(_btnContainer);
        make.width.mas_equalTo(_timeContainer);
    }];
    
    [_imageclock mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_timeContainer).with.offset(11.0f);
        make.centerY.mas_equalTo(_timeContainer);
        make.size.mas_equalTo(CGSizeMake(17.0f, 17.0f));
    }];
    
    [_lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_timeContainer);
        make.left.mas_equalTo(_imageclock.mas_right).with.offset(4.0f);
        make.right.mas_equalTo(_timeContainer).with.offset(-4.0f);
    }];
    
    [_btnCard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_btnContainer);
        make.right.mas_equalTo(self).with.offset(-20.0f);
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
    }];
    
    [_btnCollect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_btnCard.mas_left).with.offset(-20.0f);
        make.top.bottom.mas_equalTo(_btnCard);
        make.width.mas_equalTo(_btnCard);
    }];
    
}

#pragma mark - 立即交卷
-(void)EBHandInClick{
    _handInClickBlock?_handInClickBlock():nil;
}

#pragma mark - 收藏
-(void)EBCollectClick:(UIButton *)sender{
    _collectClickBlock?_collectClickBlock(sender):nil;
}
#pragma mark - 答题卡
-(void)EBCardtClick{
   _cardClickBlock?_cardClickBlock():nil;
}

#pragma mark - 倒计时事件
-(void)timerLabel:(MZTimerLabel *)timerLabel finshedCountDownTimerWithTime:(NSTimeInterval)countTime{
    _timeOutEventBlock?_timeOutEventBlock():nil;
}

-(void)setProgress:(CGFloat)progress{
    [UIView animateWithDuration:0.8 animations:^{
        _progressBar.progress = progress;
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
