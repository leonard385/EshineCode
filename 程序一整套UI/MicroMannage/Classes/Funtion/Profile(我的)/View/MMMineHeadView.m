//
//  MMMineHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/6.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMMineHeadView.h"

@interface MMMineHeadView()
@property(nonatomic,strong)UITapGestureRecognizer *tap;//手势
@property(nonatomic,strong)UIView *contentView;//内容视图
@property(nonatomic,strong)UIImageView *ImageHeadView;//头像
@property(nonatomic,strong)UILabel *LableUserName;//用户名
@property(nonatomic,strong)UILabel *LableSubTitle;//子标题
@property(nonatomic,strong)UIButton *BtnQrcode;//二维码
@end

@implementation MMMineHeadView
-(UITapGestureRecognizer *)tap{
    if(_tap  == nil){
        _tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(MHHeadViewClick)];
        [_tap setNumberOfTapsRequired:1];
        [_tap setNumberOfTouchesRequired:1];
    }
    return _tap;
}

-(UIView *)contentView{
    if(_contentView == nil){
        _contentView = [UIView new];
        _contentView.backgroundColor = [UIColor whiteColor];
    }
    return _contentView;
}

-(UIImageView *)ImageHeadView{
    if(_ImageHeadView == nil){
        _ImageHeadView = [UIImageView new];
        _ImageHeadView.backgroundColor = [UIColor redColor];
        _ImageHeadView.layer.cornerRadius = 2.5f;
        _ImageHeadView.layer.masksToBounds = YES;
        
    }
    return _ImageHeadView;
}

-(UILabel *)LableUserName{
    if(_LableUserName == nil){
        _LableUserName = [UILabel new];
        [_LableUserName setTextColor:HEXCOLOR(0x333333)];
        [_LableUserName setFont:[UIFont systemFontOfSize:16.0f]];
        _LableUserName.text = @"微学习";
    }
    return _LableUserName;
}

-(UILabel *)LableSubTitle{
    if(_LableSubTitle == nil){
        _LableSubTitle = [UILabel new];
        [_LableSubTitle setTextColor:HEXCOLOR(0x999999)];
        [_LableSubTitle setFont:[UIFont systemFontOfSize:13.0f]];
        _LableSubTitle.text = @"查看或编辑个人信息";
    }
    return _LableSubTitle;
}

-(UIButton *)BtnQrcode{
    if(_BtnQrcode == nil){
        _BtnQrcode = [UIButton new];
        [_BtnQrcode setImage:[UIImage imageNamed:@"icon_erweima"] forState:UIControlStateNormal];
        [_BtnQrcode addTarget:self action:@selector(MHQRCodeBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _BtnQrcode;
}


- (instancetype)init
{
    self = [super init];
    if (self) {
        [self MHSetUpSubviews];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self MHSetUpSubviews];
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self MHSetUpSubviews];
}


-(void)MHSetUpSubviews{
    [self addSubview:self.contentView];
    [self.contentView addSubview:self.ImageHeadView];
    [self.contentView addSubview:self.LableUserName];
    [self.contentView addSubview:self.LableSubTitle];
    [self.contentView addSubview:self.BtnQrcode];
    [self.ImageHeadView addGestureRecognizer:self.tap];
    
    
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self).with.insets(UIEdgeInsetsMake(12.0f, 0, 12.0f, 0));
    }];
    
    [_ImageHeadView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
    }];
    
    [_LableUserName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_ImageHeadView);
        make.height.mas_equalTo(28.0f);
        make.left.mas_equalTo(_ImageHeadView.mas_right).with.offset(16.0f);
        make.right.mas_equalTo(_BtnQrcode.mas_left).with.offset(-16.0f);
    }];
    
    [_LableSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_LableUserName);
        make.top.mas_equalTo(_LableUserName.mas_bottom);
        make.bottom.mas_equalTo(_ImageHeadView);
    }];
    
    [_BtnQrcode mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(22.0f, 22.0f));
        make.right.mas_equalTo(self).with.offset(-12.0f);
        make.centerY.mas_equalTo(self);
    }];
}

-(void)MHQRCodeBtnClick{
    
}

-(void)MHHeadViewClick{
    
}
@end
