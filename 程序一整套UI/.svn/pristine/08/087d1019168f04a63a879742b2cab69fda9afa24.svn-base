//
//  MMEvaluationRecordCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/16.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEvaluationRecordCell.h"
@interface MMEvaluationRecordCell()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@property(nonatomic,strong)UILabel *lableScore;
@end
@implementation MMEvaluationRecordCell
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

-(UILabel *)lableScore{
    if(_lableScore == nil){
        _lableScore = [UILabel new];
        [_lableScore setTextColor:HEXCOLOR(kBlueColor)];
        [_lableScore setFont:[UIFont systemFontOfSize:18.0f]];
        [_lableScore setTextAlignment:NSTextAlignmentRight];
    }
    return _lableScore;
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
        [self ERSetUpSubviews];
    }
    return self;
}

-(void)ERSetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSubtitle];
    [self.contentView addSubview:self.lableScore];
    [self.contentView addSubview:self.cellLine];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.contentView).with.offset(18.0f);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(self.lableScore.mas_left).with.offset(-8.0f);
        make.height.mas_equalTo(24.0f);
    }];
    
    [_lableScore mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(60.0f);
        make.top.bottom.mas_equalTo(_lableTitle);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTitle);
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(4.0f);
        make.right.mas_equalTo(_lableScore);
        make.height.mas_equalTo(19.0f);
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

-(void)setCellModel:(MMEvaluationRecordModel *)cellModel{
    _cellModel = cellModel;
    _lableTitle.text = cellModel.title;
    _lableSubtitle.text = cellModel.subTitle;
    _lableScore.text = cellModel.score;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
