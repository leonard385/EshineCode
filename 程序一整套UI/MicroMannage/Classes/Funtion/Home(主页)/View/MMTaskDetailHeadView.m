//
//  MMTaskDetailHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/22.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTaskDetailHeadView.h"
#import <MBCircularProgressBar/MBCircularProgressBarView.h>
@interface MMTaskDetailHeadView()
@property(nonatomic,strong)UILabel *lableName;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *lableState;
@property(nonatomic,strong)MBCircularProgressBarView *progressView;
@property (nonatomic,strong)UIView *cellLine;
@end

@implementation MMTaskDetailHeadView

-(UILabel *)lableName{
    if(_lableName == nil){
        _lableName = [UILabel new];
        [_lableName setTextColor:HEXCOLOR(0x333333)];
        [_lableName setFont:[UIFont systemFontOfSize:16.0f]];
        _lableName.text = @"张潇潇";
    }
    return _lableName;
}

-(UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [UIImageView new];
        _headImageView.backgroundColor = [UIColor redColor];
        _headImageView.layer.cornerRadius = 2.5f;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)lableState{
    if(_lableState == nil){
        _lableState = [UILabel new];
        [_lableState setTextColor:HEXCOLOR(0x999999)];
        [_lableState setFont:[UIFont systemFontOfSize:13.0f]];
        _lableState.text = @"已完成";
    }
    return _lableState;
}

-(MBCircularProgressBarView *)progressView{
    if(_progressView == nil){
        _progressView = [MBCircularProgressBarView new];
        _progressView.valueFontSize = 12.0f;
        _progressView.unitFontSize = 10.0f;
        _progressView.fontColor = HEXCOLOR(0x888888);
        _progressView.progressAngle = 100.0f;
        _progressView.emptyLineWidth = 2.0f;
        _progressView.emptyLineStrokeColor = HEXCOLOR(0xf8f8f8);
        _progressView.progressLineWidth = 2.0f;
        _progressView.progressColor = HEXCOLOR(kBlueColor);
        _progressView.progressStrokeColor = HEXCOLOR(kBlueColor);
        _progressView.progressRotationAngle = 50.0f;
        _progressView.maxValue = 100.0f;
        _progressView.backgroundColor = [UIColor clearColor];
    }
    return _progressView;
}

-(UIView *)cellLine{
    if(_cellLine == nil){
        _cellLine = [UIView new];
        _cellLine.backgroundColor = HEXCOLOR(0xefeff4);
    }
    return _cellLine;
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
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.lableName];
    [self addSubview:self.headImageView];
    [self addSubview:self.lableState];
    [self addSubview:self.progressView];
    [self addSubview:self.cellLine];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
    }];
    
    [_lableName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView.mas_right).with.offset(12.0f);
        make.top.mas_equalTo(_headImageView);
        make.height.mas_equalTo(17.0f);
        make.right.mas_equalTo(_progressView.mas_left).with.offset(-12.0f);
    }];
    
    [_lableState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(_progressView);
        make.height.mas_equalTo(20.0f);
        make.right.mas_equalTo(_progressView.mas_left).with.offset(-8.0f);
        make.left.mas_equalTo(_lableName);
    }];
    
    [_progressView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-12.0f);
        make.bottom.mas_equalTo(_cellLine.mas_top).with.offset(-12.0f);
        make.size.mas_equalTo(CGSizeMake(34.0f, 34.0f));
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.mas_equalTo(self);
        make.height.mas_equalTo(10.0f);
    }];

}

-(void)setType:(DDTaskType)Type{
    _Type = Type;
    UIColor *stateColor ;
    switch (Type) {
        case TaskUndoType:{
            stateColor = HEXCOLOR(0xff6d48);
        }
            break;
        case TaskProgressType:{
            stateColor = HEXCOLOR(kBlueColor);
        }
            break;
        case TaskDoneType:{
            stateColor = HEXCOLOR(0x999999);
        }
            break;
            
        default:
            break;
    }
    
    _lableState.textColor = stateColor;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
