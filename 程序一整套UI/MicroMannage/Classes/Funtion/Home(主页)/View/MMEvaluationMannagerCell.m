//
//  MMEvaluationMannagerCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEvaluationMannagerCell.h"
@interface MMEvaluationMannagerCell()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UILabel *lableAttend;
@end

@implementation MMEvaluationMannagerCell

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:16.0f]];
    }
    return _lableTitle;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle == nil){
        _lableSubtitle = [UILabel new];
        [_lableSubtitle setTextColor:HEXCOLOR(0x999999)];
        [_lableSubtitle setFont:[UIFont systemFontOfSize:13.0f]];
    }
    return _lableSubtitle;
}

-(UIImageView *)iconImageView{
    if(_iconImageView == nil){
        _iconImageView = [UIImageView new];
        _iconImageView.image = [UIImage imageNamed:@"content_renyuan"];
        _iconImageView.contentMode = UIViewContentModeCenter;
    }
    return _iconImageView;
}

-(UILabel *)lableAttend{
    if(_lableAttend == nil){
        _lableAttend = [UILabel new];
        [_lableAttend setFont:[UIFont systemFontOfSize:13.0f]];
        [_lableAttend setTextColor:HEXCOLOR(0x999999)];
    }
    return _lableAttend;
}

-(UIView *)cellLine{
    if(_cellLine == nil){
        _cellLine = [UIView new];
        _cellLine.backgroundColor = HEXCOLOR(kLineColor);
    }
    return _cellLine;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self EMSetUpSubviews];
    }
    return self;
}

-(void)EMSetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSubtitle];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.lableAttend];
    [self.contentView addSubview:self.cellLine];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(20.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_lableTitle);
        make.height.mas_equalTo(19.0f);
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(3.0f);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTitle);
        make.centerY.mas_equalTo(_lableAttend);
        make.size.mas_equalTo(CGSizeMake(12.0f, 14.0f));
    }];
    
    [_lableAttend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_iconImageView.mas_right).with.offset(6.0f);
        make.right.mas_equalTo(_lableTitle);
        make.height.mas_equalTo(19.0f);
        make.top.mas_equalTo(_lableSubtitle.mas_bottom).with.offset(6.0f);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(0.5f);
    }];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setCellModel:(MMEvaluationMannageModel *)cellModel{
    _cellModel = cellModel;
    _lableTitle.text = cellModel.title;
    _lableSubtitle.text = cellModel.subTitle;
    _lableAttend.text = cellModel.attend;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
