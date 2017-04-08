//
//  MMKnowlegeTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/9.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKnowlegeTableViewCell.h"
#import "TTGTextTagCollectionView.h"
#import "UIButton+LXMImagePosition.h"
@interface MMKnowlegeTableViewCell()<TTGTextTagCollectionViewDelegate>
@property(nonatomic,strong)UIImageView *logoImageView;//头像
@property(nonatomic,strong)UILabel *lableTitle;//标题
@property(nonatomic,strong)UILabel *lableSocial;//社交
@property(nonatomic,strong)UIButton *funcBtn;//功能按钮
@property(nonatomic,strong)UIView *line;
@property(nonatomic,strong)UILabel *lableContent;//内容
@property(nonatomic,strong)UIImageView *iconImage;
@property(nonatomic,strong)TTGTextTagCollectionView *tagView;//tagView
@property(nonatomic,strong)TTGTextTagConfig *tagConfig;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,assign)CGFloat tagViewH;
@end

@implementation MMKnowlegeTableViewCell
-(UIImageView *)logoImageView{
    if(_logoImageView == nil){
        _logoImageView = [UIImageView new];
        _logoImageView.backgroundColor = [UIColor redColor];
        _logoImageView.layer.cornerRadius = 2.5f;
        _logoImageView.layer.masksToBounds = YES;
    }
    return _logoImageView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:16.0f]];
        _lableTitle.text = @"套餐学习";
    }
    return _lableTitle;
}

-(UILabel *)lableSocial{
    if(_lableSocial == nil){
        _lableSocial = [UILabel new];
        [_lableSocial setTextColor:HEXCOLOR(0x999999)];
        [_lableSocial setFont:[UIFont systemFontOfSize:13.0f]];
        _lableSocial.text = @"20条收录   156人关注";
    }
    return _lableSocial;
}

-(UIButton *)funcBtn{
    if(_funcBtn == nil){
        _funcBtn = [UIButton new];
        [_funcBtn setTitle:@"关注" forState:UIControlStateNormal];
        [_funcBtn setImage:[UIImage imageNamed:@"bth_guanzhu"] forState:UIControlStateNormal];
        [_funcBtn.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [_funcBtn setTitleColor:HEXCOLOR(kBlueColor) forState:UIControlStateNormal];
        [_funcBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
        [_funcBtn setBackgroundColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_funcBtn setBackgroundColor:HEXCOLOR(kBlueColor) forState:UIControlStateHighlighted];
        [_funcBtn setImagePosition:LXMImagePositionLeft spacing:5.0f];
        _funcBtn.layer.cornerRadius = 2.5f;
        _funcBtn.layer.borderWidth = 1.0f;
        _funcBtn.layer.borderColor = HEXCOLOR(kBlueColor).CGColor;
        _funcBtn.layer.masksToBounds = YES;
        [_funcBtn addTarget:self action:@selector(funcBtnClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _funcBtn;
}

-(UIView *)line{
    if(_line == nil){
        _line = [UIView new];
        _line.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _line;
}

-(UILabel *)lableContent{
    if(_lableContent == nil){
        _lableContent = [UILabel new];
        [_lableContent setLineBreakMode:NSLineBreakByTruncatingTail];
        [_lableContent setFont:[UIFont systemFontOfSize:13.0f]];
        [_lableContent setTextColor:HEXCOLOR(0x666666)];
        _lableContent.text = @"最新更新：4G上网套餐4G上网套餐4G上网套餐4G上网套餐4G上网套餐4G上网套餐";
    }
    return _lableContent;
}

-(UIImageView *)iconImage{
    if(_iconImage == nil){
        _iconImage  = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_biaoqian"]];
    }
    return _iconImage;
}

-(TTGTextTagConfig *)tagConfig{
    if(_tagConfig == nil){
        _tagConfig = [TTGTextTagConfig new];
        _tagConfig.tagTextFont = [UIFont systemFontOfSize:12.0f];
        _tagConfig.tagTextColor = HEXCOLOR(0xb8b8b8);
        _tagConfig.tagSelectedTextColor = HEXCOLOR(0xb8b8b8);
        _tagConfig.tagShadowRadius = 0.0f;
        _tagConfig.tagShadowOpacity = 0.0f;
        _tagConfig.tagBackgroundColor = [UIColor whiteColor];
        _tagConfig.tagSelectedBackgroundColor = [UIColor whiteColor];
        
    }
    return _tagConfig;
}
-(TTGTextTagCollectionView *)tagView{
    if(_tagView == nil){
        _tagView = [TTGTextTagCollectionView new];
        _tagView.scrollView.scrollEnabled = NO;
        _tagView.delegate = self;
    }
    return _tagView;
}

-(UIView *)lineView{
    if(_lineView == nil){
        _lineView = [UIView new];
        _lineView.backgroundColor = HEXCOLOR(0xf0f3f8);
    }
    return _lineView;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self KTSetUpSubviews];
    }
    return self;
}

-(void)KTSetUpSubviews{
    [self.contentView addSubview:self.logoImageView];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSocial];
    [self.contentView addSubview:self.funcBtn];
    [self.contentView addSubview:self.line];
    [self.contentView addSubview:self.lableContent];
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.tagView];
    [self.contentView addSubview:self.lineView];

    
    [_logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.top.mas_equalTo(self.contentView).with.offset(16.0f);
        make.size.mas_equalTo(CGSizeMake(63.0f,63.0f));
    }];
    
    [_funcBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTitle);
        make.size.mas_equalTo(CGSizeMake(67.0f, 30.0f));
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_logoImageView.mas_right).with.offset(12.0f);
        make.right.mas_equalTo(_funcBtn.mas_left).with.offset(-12.0f);
        make.top.mas_equalTo(_logoImageView).with.offset(8.0f);
        make.height.mas_equalTo(19.0f);
    }];
    
    [_lableSocial mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_lableTitle);
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(8.0f);
        make.height.mas_equalTo(14.0f);
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
       make.top.mas_equalTo(_logoImageView.mas_bottom).with.offset(15.0f);
       make.left.mas_equalTo(_logoImageView);
       make.right.mas_equalTo(_funcBtn);
       make.height.mas_equalTo(0.5f);
    }];
    
    [_lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_line);
        make.top.mas_equalTo(_line.mas_bottom).with.offset(12.0f);
        make.height.mas_equalTo(14.0f);
        make.right.mas_equalTo(_line);
    }];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_line);
        make.size.mas_equalTo(CGSizeMake(15.0f, 15.0f));
        make.top.mas_equalTo(_lableContent.mas_bottom).with.offset(12.0f);
    }];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImage.mas_right).with.offset(8.0f);
        make.top.mas_equalTo(_iconImage);
        make.right.mas_equalTo(_lableContent);
        make.height.mas_equalTo(24.0f);
        make.bottom.mas_equalTo(_lineView.mas_top).with.offset(-16.0f);
    }];
    
    [_lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(10.0f);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

#pragma mark - 关注点击
-(void)funcBtnClick{
    _KTattentionClickBlock?_KTattentionClickBlock():nil;
}
#pragma mark - 设置标签
-(void)setTagViews:(NSArray *)tags{
    [_tagView removeAllTags];
    [_tagView addTags:tags withConfig:self.tagConfig];
    [_tagView reload];
}
-(void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected{
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


@end
