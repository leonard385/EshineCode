//
//  MMOfflineQrcodeView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMOfflineQrcodeView.h"
@interface MMOfflineQrcodeView()
@property(nonatomic,strong)UIButton *btnClose;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSpeaker;
@property(nonatomic,strong)UIImageView *qrcodeImage;
@property(nonatomic,strong)UILabel *lableTip;
@property(nonatomic,strong)UIButton *btnSave;

@end
@implementation MMOfflineQrcodeView

-(UIButton *)btnClose{
    if(_btnClose == nil){
        _btnClose = [UIButton new];
        [_btnClose setImage:[UIImage imageNamed:@"del_icon_guanbi"] forState:UIControlStateNormal];
        [_btnClose.imageView setContentMode:UIViewContentModeCenter];
        [_btnClose addTarget:self action:@selector(btnCloseClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnClose;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        [_lableTitle setTextAlignment:NSTextAlignmentCenter];
        _lableTitle.text = @"部门经理必修科";
    }
    return _lableTitle;
}

-(UILabel *)lableSpeaker{
    if(_lableSpeaker == nil){
        _lableSpeaker = [UILabel new];
        [_lableSpeaker setFont:[UIFont systemFontOfSize:12.0f]];
        _lableSpeaker.textColor = HEXCOLOR(0x999999);
        [_lableSpeaker setTextAlignment:NSTextAlignmentCenter];
        _lableSpeaker.text = @"授课老师：罗设";
    }
    return _lableSpeaker;
}

-(UIImageView *)qrcodeImage{
    if(_qrcodeImage == nil){
        _qrcodeImage = [UIImageView new];
        _qrcodeImage.backgroundColor = [UIColor redColor];
    }
    return _qrcodeImage;
}

-(UILabel *)lableTip{
    if(_lableTip == nil){
        _lableTip = [UILabel new];
        [_lableTip setFont:[UIFont systemFontOfSize:12.0f]];
        _lableTip.textColor = HEXCOLOR(0x999999);
        [_lableTip setTextAlignment:NSTextAlignmentCenter];
        _lableTip.text = @"可以在培训详情查看此二维码";
    }
    return _lableTip;
}

-(UIButton *)btnSave{
    if(_btnSave == nil){
        _btnSave = [UIButton new];
        [_btnSave setTitle:@"点击保存到手机" forState:UIControlStateNormal];
        [_btnSave.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [_btnSave setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_btnSave setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_btnSave setBackgroundColor:HEXCOLOR(kBlueColor) forState:UIControlStateHighlighted];
        [_btnSave setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _btnSave.layer.borderWidth = 0.5;
        _btnSave.layer.cornerRadius = 5.0f;
        _btnSave.layer.borderColor = HEXCOLOR(kBlueColor).CGColor;
        _btnSave.layer.masksToBounds = YES;
        
        [_btnSave addTarget:self action:@selector(btnSaveClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSave;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self OQSetUpSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self OQSetUpSubviews];
    }
    return self;
}

-(void)OQSetUpSubviews{
    [self addSubview:self.lableTitle];
    [self addSubview:self.btnClose];
    [self addSubview:self.lableSpeaker];
    [self addSubview:self.qrcodeImage];
    [self addSubview:self.lableTip];
    [self addSubview:self.btnSave];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self).with.offset(22.0f);
        make.left.mas_equalTo(self).with.offset(37.0f);
        make.right.mas_equalTo(self).with.offset(-37.0f);
        make.height.mas_equalTo(20.0f);
    }];
    [_btnClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-4.0f);
        make.top.mas_equalTo(self).with.offset(4.0f);
        make.size.mas_equalTo(CGSizeMake(23.0f, 23.0f));
    }];
    
    [_lableSpeaker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_lableTitle);
        make.height.mas_equalTo(16.0f);
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(6.0f);
    }];
    
    [_qrcodeImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self);
        make.top.mas_equalTo(_lableSpeaker.mas_bottom).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(217.0f, 217.0f));
    }];
    
    [_lableTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_qrcodeImage);
        make.top.mas_equalTo(_qrcodeImage.mas_bottom).with.offset(8.0f);
        make.height.mas_equalTo(12.0f);
    }];
    
    [_btnSave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTip.mas_bottom).with.offset(18.0f);
        make.left.right.mas_equalTo(_qrcodeImage);
        make.height.mas_equalTo(47.0f);
    }];
}



#pragma mark - 关闭按钮
-(void)btnCloseClick{
    _OQcloseClickBlock?_OQcloseClickBlock():nil;
}

-(void)btnSaveClick{
    _OQsaveClickBlock?_OQsaveClickBlock():nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
