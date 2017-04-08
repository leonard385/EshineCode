//
//  MMEvaluationExamCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/15.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEvaluationExamCell.h"
@interface MMEvaluationExamCell()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@property(nonatomic,strong)UILabel *lableTip;
@property(nonatomic,strong)UILabel *lableTime;
@property(nonatomic,strong)UILabel *lableAttend;
@end

@implementation MMEvaluationExamCell

-(UILabel *)lableTitle{
  if(_lableTitle == nil){
    _lableTitle = [UILabel new];
    [_lableTitle setTextColor:HEXCOLOR(0x333333)];
    [_lableTitle setFont:[UIFont systemFontOfSize:16.0f]];
  }
  return _lableTitle;
}

-(UILabel *)lableTip{
    if(_lableTip == nil){
        _lableTip = [UILabel new];
        [_lableTip setFont:[UIFont systemFontOfSize:16.0f]];
        [_lableAttend setTextAlignment:NSTextAlignmentRight];
    }
    return _lableTip;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle == nil){
        _lableSubtitle = [UILabel new];
        [_lableSubtitle setTextColor:HEXCOLOR(0x999999)];
        [_lableSubtitle setFont:[UIFont systemFontOfSize:13.0f]];
    }
    return _lableSubtitle;
}

-(UILabel *)lableTime{
    if(_lableTime == nil){
        _lableTime = [UILabel new];
        [_lableTime setTextColor:HEXCOLOR(0x999999)];
        [_lableTime setFont:[UIFont systemFontOfSize:13.0f]];
    }
    return _lableTime;
}

-(UILabel *)lableAttend{
    if(_lableAttend == nil){
        _lableAttend = [UILabel new];
        [_lableAttend setTextColor:HEXCOLOR(0x999999)];
        [_lableAttend setTextAlignment:NSTextAlignmentRight];
        [_lableAttend setFont:[UIFont systemFontOfSize:11.0f]];
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


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self EESetUpSubviews];
    }
    return self;
}

-(void)EESetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableTip];
    [self.contentView addSubview:self.lableSubtitle];
    [self.contentView addSubview:self.lableTime];
    [self.contentView addSubview:self.lableAttend];
    [self.contentView addSubview:self.cellLine];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(20.0f);
        make.right.mas_equalTo(self.lableTip.mas_left).with.offset(-12.0f);
    }];
    
    [_lableTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.top.bottom.mas_equalTo(_lableTitle);
        make.width.mas_equalTo(55.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTitle);
        make.right.mas_equalTo(_lableTip);
        make.height.mas_equalTo(19.0f);
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(3.0f);
    }];
    
    [_lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableSubtitle);
        make.top.mas_equalTo(_lableSubtitle.mas_bottom).with.offset(2.0f);
        make.size.mas_equalTo(CGSizeMake(150.0f, 19.0f));
    }];
    
    [_lableAttend mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTime.mas_right);
        make.right.mas_equalTo(_lableTip);
        make.height.mas_equalTo(19.0f);
        make.top.mas_equalTo(_lableTime);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(0.5f);
    }];
}

-(void)setCellModel:(EvaluationExamModel *)cellModel{
    _cellModel = cellModel;
    _lableTitle.text = cellModel.title;
    _lableSubtitle.text = cellModel.subTitle;
    _lableTime.text = [NSString stringWithFormat:@"考试时长 %@",cellModel.time];
    _lableAttend.text = [NSString stringWithFormat:@"%@人已考试",[cellModel.attendNum stringValue]];
    
    if([cellModel.isComplete boolValue]){
        _lableTip.text = @"已通过";
        [_lableTip setTextColor:HEXCOLOR(0x999999)];
    }else{
        _lableTip.text = @"待考试";
        [_lableTip setTextColor:HEXCOLOR(kBlueColor)];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
