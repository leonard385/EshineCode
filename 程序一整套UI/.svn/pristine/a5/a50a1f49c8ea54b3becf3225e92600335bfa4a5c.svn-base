//
//  MMHomeSectionHeadView.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/7.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMHomeSectionHead.h"
#import "UIButton+LXMImagePosition.h"
@interface MMHomeSectionHead()
@property(nonatomic,strong)UIView *headContent;
@property(nonatomic,strong)UILabel *lableTitle;//标题
@property(nonatomic,strong)UIButton *Btnfunc;//按钮
@property(nonatomic,strong)UIView *line;
@end
@implementation MMHomeSectionHead

-(UIView *)headContent{
    if(_headContent == nil){
        _headContent = [UIView new];
        _headContent.backgroundColor = [UIColor whiteColor];
    }
    return _headContent;
}

-(UILabel *)lableTitle{
    if(_lableTitle  == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setFont:[UIFont systemFontOfSize:16.0f]];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
    }
    return _lableTitle;
}

-(UIButton *)Btnfunc{
    if(_Btnfunc == nil){
        _Btnfunc = [UIButton new];
        [_Btnfunc setTitleColor:HEXCOLOR(0x999999) forState:UIControlStateNormal];
        [_Btnfunc.titleLabel setFont:[UIFont systemFontOfSize:13.0f]];
        [_Btnfunc setTitleColor:HEXCOLOR(0xcccccc) forState:UIControlStateHighlighted];
        [_Btnfunc.imageView setContentMode:UIViewContentModeCenter];
        [_Btnfunc addTarget:self action:@selector(btnfuncClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _Btnfunc;
}

-(UIView *)line{
    if(_line == nil){
        _line = [UIView new];
        _line.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line;
}


-(instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if(self){
        [self HSSetUpSubviews];
    }
    return self;
}

-(void)HSSetUpSubviews{
    self.contentView.backgroundColor = HEXCOLOR(0xefeff4);
    [self.contentView addSubview:self.headContent];
    [self.headContent addSubview:self.lableTitle];
    [self.headContent addSubview:self.Btnfunc];
    [self.headContent addSubview:self.line];
    
    [_headContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.contentView).with.insets(UIEdgeInsetsMake(10, 0, 0, 0));
    }];
    
    [_Btnfunc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.headContent).with.offset(-6.0f);
        make.top.mas_equalTo(self.headContent);
        make.bottom.mas_equalTo(self.line.mas_top);
        make.width.mas_equalTo(80.0f);
    }];
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_Btnfunc);
        make.left.mas_equalTo(self.headContent).with.offset(12.0f);
        make.right.mas_equalTo(_Btnfunc.mas_left);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(self.headContent);
        make.height.mas_equalTo(0.5f);
    }];
}
#pragma mark - 功能按钮点击
-(void)btnfuncClick{
    _functionBlock?_functionBlock():nil;
}

-(void)setTitle:(NSString *)title{
    [_lableTitle setText:title];
}

-(void)setSubTitle:(NSString *)subTitle{
    [_Btnfunc setTitle:subTitle forState:UIControlStateNormal];
}

-(void)setSubImage:(UIImage *)subImage{
    _subImage = subImage;
     [_Btnfunc setImage:subImage forState:UIControlStateNormal];
}

-(void)setTitle:(NSString *)title SubTitle:(NSString *)subTitle SubImage:(UIImage *)subImage FunctionBlock:(functionClick)functionBlock;{
    [_lableTitle setText:title];
    [_Btnfunc setTitle:subTitle forState:UIControlStateNormal];
    [_Btnfunc setImage:subImage forState:UIControlStateNormal];
    [_Btnfunc setImagePosition:LXMImagePositionRight spacing:7.0f];
    _functionBlock = functionBlock;
}


@end
