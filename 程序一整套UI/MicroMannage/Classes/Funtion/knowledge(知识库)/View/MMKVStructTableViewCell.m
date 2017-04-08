 //
//  MMKVStructTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/13.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMKVStructTableViewCell.h"
#import "TTGTextTagCollectionView.h"
@interface MMKVStructTableViewCell()<TTGTextTagCollectionViewDelegate>
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *lableTitle;//标题
@property(nonatomic,strong)UITapGestureRecognizer *titleTap;
@property(nonatomic,strong)UILabel *lableSubTitle;//副标题
@property(nonatomic,strong)TTGTextTagCollectionView *tagView;//tagView
@property(nonatomic,strong)TTGTextTagConfig *tagConfig;

@end

@implementation MMKVStructTableViewCell

-(TTGTextTagConfig *)tagConfig{
    if(_tagConfig == nil){
        TTGTextTagConfig *config = [TTGTextTagConfig new];
        config.tagTextFont = [UIFont systemFontOfSize:13.0f];
        config.tagCornerRadius = 15.0f;
        config.tagSelectedCornerRadius = 15.0f;
        config.tagTextColor = HEXCOLOR(kBlueColor);
        config.tagSelectedTextColor = HEXCOLOR(kBlueColor);
        config.tagBackgroundColor = HEXCOLOR(0xeef5fd);
        config.tagSelectedBackgroundColor = HEXCOLOR(0xeef5fd);
        config.tagBorderColor = HEXCOLOR(0xeef5fd);
        config.tagSelectedBorderColor = HEXCOLOR(0xeef5fd);
        config.tagBorderWidth = 0.5f;
        config.tagShadowOpacity = 0.0f;
        _tagConfig = config;

    }
    return _tagConfig;
}

-(UIImageView *)iconImageView{
    if(_iconImageView == nil){
        _iconImageView = [UIImageView new];
        [_iconImageView setContentMode:UIViewContentModeCenter];
        [_iconImageView setImage:[UIImage imageNamed:@"icon_biaoqian"]];
    }
    return _iconImageView;
}

-(UITapGestureRecognizer *)titleTap{
    if(_titleTap == nil){
        _titleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(btnTitleClick)];
        _titleTap.delegate = self;
        _titleTap.numberOfTapsRequired = 1;//触摸次数
    }
    return _titleTap;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:16.0f]];
        _lableTitle.text = @"流量套餐";
        _lableTitle.userInteractionEnabled = YES;
        [_lableTitle addGestureRecognizer:self.titleTap];
    }
    return _lableTitle;
}

-(TTGTextTagCollectionView *)tagView{
    if(_tagView == nil){
        _tagView = [TTGTextTagCollectionView new];
        _tagView.delegate = self;
    }
    return _tagView;
}

-(UILabel *)lableSubTitle{
    if(_lableSubTitle == nil){
        _lableSubTitle = [UILabel new];
        [_lableSubTitle setTextColor:HEXCOLOR(0x999999)];
        [_lableSubTitle setFont:[UIFont systemFontOfSize:13.0f]];
        [_lableSubTitle setTextAlignment:NSTextAlignmentRight];
        _lableSubTitle.text = @"5条收录";
    }
    return _lableSubTitle;
}

-(UIView *)verticalLine{
    if(_verticalLine == nil){
        _verticalLine = [UIView new];
        _verticalLine.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _verticalLine;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self STSetUpSubviews];
    }
    return self;
}

-(void)STSetUpSubviews{
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSubTitle];
    [self.contentView addSubview:self.verticalLine];
    [self.contentView addSubview:self.tagView];
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(17.0f, 17.0f));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_iconImageView);
        make.left.mas_equalTo(_iconImageView.mas_right).with.offset(9.0f);
        make.right.mas_equalTo(_lableSubTitle.mas_left).with.offset(-9.0f);
    }];
    
    [_lableSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
         make.top.bottom.mas_equalTo(_iconImageView);
         make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
         make.width.mas_equalTo(55.0f);
    }];
    
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTitle);
        make.right.mas_equalTo(_lableSubTitle);
        make.top.mas_equalTo(_verticalLine.mas_top).with.offset(7.0f);
        make.height.mas_greaterThanOrEqualTo(100.0f);
    }];
    
    [_verticalLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(_iconImageView);
        make.top.mas_equalTo(_iconImageView.mas_bottom).with.offset(7.0f);
        make.width.mas_equalTo(0.5f);
        make.bottom.mas_equalTo(_tagView).with.offset(12.0f);
    }];
}

-(void)SVsetTagViews:(NSArray *)tags{
    [_tagView removeAllTags];
       [_tagView addTags:tags withConfig:self.tagConfig];
    [_tagView reload];
}

-(void)btnTitleClick{

}

-(void)setCellModel:(MMKVStructModel *)cellModel{
    _cellModel = cellModel;
}

-(void)textTagCollectionView:(TTGTextTagCollectionView *)textTagCollectionView didTapTag:(NSString *)tagText atIndex:(NSUInteger)index selected:(BOOL)selected{

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
