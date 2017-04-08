//
//  MMExamAnalysisCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/17.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMExamAnalysisCell.h"
@interface MMExamAnalysisCell()
@property(nonatomic,strong)UILabel *lableTip;//tip
@property(nonatomic,strong)UILabel *lableRightAnswer;//正确答案
@property(nonatomic,strong)UILabel *lableAnalysis;//分析
@end


@implementation MMExamAnalysisCell
-(UILabel *)lableTip{
    if(_lableTip == nil){
        _lableTip = [UILabel new];
        [_lableTip setTextColor:HEXCOLOR(0x00c356)];
        [_lableTip setFont:[UIFont systemFontOfSize:13.0f]];
        _lableTip.text = @"最佳解析";
    }
    return _lableTip;
}

-(UILabel *)lableRightAnswer{
    if(_lableRightAnswer == nil){
        _lableRightAnswer = [UILabel new];
        [_lableRightAnswer setTextColor:HEXCOLOR(0x333333)];
        [_lableRightAnswer setFont:[UIFont systemFontOfSize:17.0f]];
    }
    return _lableRightAnswer;
}


-(UILabel *)lableAnalysis{
    if(_lableAnalysis == nil){
        _lableAnalysis = [UILabel new];
        [_lableAnalysis setTextColor:HEXCOLOR(0x333333)];
        _lableAnalysis.numberOfLines = 0.0f;
        [_lableAnalysis setFont:[UIFont systemFontOfSize:17.0f]];
    }
    return _lableAnalysis;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self EASetUpSubviews];
    }
    return self;
}

-(void)EASetUpSubviews{
    [self.contentView addSubview:self.lableTip];
    [self.contentView addSubview:self.lableRightAnswer];
    [self.contentView addSubview:self.lableAnalysis];
    
    [_lableTip mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(15.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_lableRightAnswer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(_lableTip);
        make.top.mas_equalTo(self.lableTip.mas_bottom).with.offset(8.0f);
        make.height.mas_equalTo(20.0f);
    }];
    
    [_lableAnalysis mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableRightAnswer.mas_bottom).with.offset(10.0f);
        make.left.right.mas_equalTo(_lableRightAnswer);
        make.height.mas_greaterThanOrEqualTo(40.0f);
        make.bottom.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
}

-(void)setCellModel:(MMExamAnlysisModel *)cellModel{
    _cellModel = cellModel;
    _lableRightAnswer.text = cellModel.tureItem;
    _lableAnalysis.text = cellModel.anlysisContent;
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
