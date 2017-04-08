//
//  MMHomeEmployCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/28.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMHomeEmployCell.h"
@interface MMHomeEmployCell()
@property(nonatomic,strong)UIImageView *iconImage;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubTitle;
@property(nonatomic,strong)UILabel *lableNum;
@end

@implementation MMHomeEmployCell

-(UIImageView *)iconImage{
    if(_iconImage == nil){
        _iconImage = [UIImageView new];
        [_iconImage setContentMode:UIViewContentModeCenter];
    }
    return _iconImage;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:14.0f]];
        [_lableTitle setLineBreakMode:NSLineBreakByTruncatingTail];
    }
    return _lableTitle;
}

-(UILabel *)lableSubTitle{
    if(_lableSubTitle == nil){
        _lableSubTitle = [UILabel new];
        [_lableSubTitle setTextColor:HEXCOLOR(0x999999)];
        [_lableSubTitle setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableSubTitle;
}

-(UILabel *)lableNum{
    if(_lableNum == nil){
        _lableNum = [UILabel new];
        [_lableNum setTextColor:HEXCOLOR(kBlueColor)];
        [_lableNum setFont:[UIFont systemFontOfSize:17.0f]];
        [_lableNum setTextAlignment:NSTextAlignmentRight];
    }
    return _lableNum;
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
        [self HESetUpSubviews];
    }
    return self;
}

-(void)HESetUpSubviews{
    [self.contentView addSubview:self.iconImage];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSubTitle];
    [self.contentView addSubview:self.lableNum];
    [self.contentView addSubview:self.cellLine];
    
    [_iconImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(43.0f, 43.0f));
    }];
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_iconImage).with.offset(5.0f);
        make.left.mas_equalTo(_iconImage.mas_right).with.offset(20.0f);
        make.right.mas_equalTo(_lableNum.mas_left).with.offset(-12.0f);
        make.height.mas_equalTo(14.0f);
    }];
    [_lableNum mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.top.bottom.mas_equalTo(_iconImage);
        make.width.mas_equalTo(60.0f);
    }];
    [_lableSubTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(4.0f);
        make.left.right.mas_equalTo(_lableTitle);
        make.height.mas_equalTo(13.0f);
    }];
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTitle);
        make.right.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5);
        make.bottom.mas_equalTo(self.contentView);
    }];
}

-(void)setCellModel:(MMHomeEmployModel *)cellModel{
    _cellModel = cellModel;
    _iconImage.image = [UIImage imageNamed:cellModel.icon];
    _lableTitle.text = cellModel.title;
    _lableNum.text = [cellModel.num stringValue];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
