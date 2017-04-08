//
//  MMExamPromotView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/20.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMExamPromotView.h"
@interface MMExamPromotView()
@property(nonatomic,strong)UILabel *lablePromot;
@property(nonatomic,strong)UIButton *btnPromot;
@property(nonatomic,strong)UIButton *btnCancel;
@property(nonatomic,strong)UIButton *btnConfirm;
@end
@implementation MMExamPromotView

-(UILabel *)lablePromot{
    if(_lablePromot == nil){
        _lablePromot = [UILabel new];
        _lablePromot.font = [UIFont systemFontOfSize:16.0f];
        _lablePromot.textColor = HEXCOLOR(0x333333);
        _lablePromot.textAlignment = NSTextAlignmentCenter;
    }
    return _lablePromot;
}

-(UIButton *)btnPromot{
    if(_btnPromot == nil){
        _btnPromot    = [UIButton new];
        [_btnPromot setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
        [_btnPromot.titleLabel setFont:[UIFont systemFontOfSize:16.0f]];
        [_btnPromot setImage:[UIImage imageNamed:@"nav_sousu"] forState:UIControlStateNormal];
        [_btnPromot setTitle:@"查看未做题目" forState:UIControlStateNormal];
        [_btnPromot addTarget:self action:@selector(cheackClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnPromot;
}

-(UIButton *)btnCancel{
    if(_btnCancel == nil){
        _btnCancel    = [UIButton new];
        [_btnCancel setTitleColor:HEXCOLOR(0x666666) forState:UIControlStateNormal];
        [_btnCancel.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_btnConfirm setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnCancel setTitle:@"取消" forState:UIControlStateNormal];
        _btnCancel.layer.borderColor = HEXCOLOR(0xcccccc).CGColor;
        _btnCancel.layer.borderWidth = 0.5f;
         [_btnCancel addTarget:self action:@selector(concelClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnCancel;
}

-(UIButton *)btnConfirm{
    if(_btnConfirm == nil){
        _btnConfirm    = [UIButton new];
        [_btnConfirm setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_btnConfirm setBackgroundColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_btnConfirm.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
        [_btnConfirm setTitle:@"确定" forState:UIControlStateNormal];
        _btnConfirm.layer.borderColor = HEXCOLOR(kBlueColor).CGColor;
        _btnConfirm.layer.borderWidth = 0.5f;
        [_btnConfirm addTarget:self action:@selector(confirmClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnConfirm;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self ECSetUpSubviews];
    }
    return self;
}

-(void)ECSetUpSubviews{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.cornerRadius = 5.0f;
    self.layer.masksToBounds = YES;
    [self addSubview:self.lablePromot];
    [self addSubview:self.btnPromot];
    [self addSubview:self.btnCancel];
    [self addSubview:self.btnConfirm];
    
    [_lablePromot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(29.0f);
        make.left.mas_equalTo(self).with.offset(12.0f);
        make.right.mas_equalTo(self).with.offset(-12.0f);
        make.height.mas_equalTo(21.0f);
    }];
    
    [_btnPromot mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lablePromot.mas_bottom).with.offset(6.0f);
        make.size.mas_equalTo(CGSizeMake(117.0f, 22.0f));
        make.centerX.mas_equalTo(self);
    }];
    
    [_btnCancel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.mas_equalTo(self);
        make.height.mas_equalTo(44.0f);
        make.width.mas_equalTo(_btnConfirm);
    }];
    
    [_btnConfirm mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.bottom.mas_equalTo(self);
        make.left.mas_equalTo(_btnCancel.mas_right);
        make.height.mas_equalTo(44.0f);
        make.width.mas_equalTo(_btnCancel);
    }];
    
}

-(void)cheackClick{
    _cheakClickBlock?_cheakClickBlock():nil;
}

-(void)concelClick{
    _cancleClickBlock?_cancleClickBlock():nil;
}

-(void)confirmClick{
    _confirmClickBlock?_confirmClickBlock():nil;
}

-(void)setRemainNum:(NSString *)remainNum{
    _remainNum = remainNum;
    NSString *title = [NSString stringWithFormat:@"还剩%@题没做,确认交卷？",remainNum];
    _lablePromot.text = title;
}

-(void)setCancleClickBlock:(cancleClick)cancleClickBlock ConfirmClickBlock:(confirmClick)confirmClickBlock CheakClickBlock:(cheakClick)cheakClickBlock{
    _cancleClickBlock = cancleClickBlock;
    _confirmClickBlock = confirmClickBlock;
    _cheakClickBlock = cheakClickBlock;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/



@end
