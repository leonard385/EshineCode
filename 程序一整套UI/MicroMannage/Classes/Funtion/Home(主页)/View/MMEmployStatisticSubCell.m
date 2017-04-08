//
//  MMEmployStatisticSubCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployStatisticSubCell.h"
@interface MMEmployStatisticSubCell()
@property(nonatomic,strong)UILabel *lableDistrict;
@property(nonatomic,strong)UILabel *lableTotal;
@property(nonatomic,strong)UILabel *lableLeave;
@property(nonatomic,strong)UILabel *lableAdd;
@property(nonatomic,strong)UILabel *lableLeavePercent;
@end
@implementation MMEmployStatisticSubCell

-(UILabel *)lableDistrict{
    if(_lableDistrict == nil){
        _lableDistrict = [UILabel new];
        [_lableDistrict setTextColor:HEXCOLOR(0x333333)];
        [_lableDistrict setTextAlignment:NSTextAlignmentCenter];
        [_lableDistrict setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableDistrict;
}

-(UILabel *)lableTotal{
    if(_lableTotal == nil){
        _lableTotal = [UILabel new];
        [_lableTotal setTextColor:HEXCOLOR(0x333333)];
        [_lableTotal setTextAlignment:NSTextAlignmentCenter];
        [_lableTotal setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableTotal;
}

-(UILabel *)lableLeave{
    if(_lableLeave == nil){
        _lableLeave = [UILabel new];
        [_lableLeave setTextColor:HEXCOLOR(0xff4b0d)];
        [_lableLeave setTextAlignment:NSTextAlignmentCenter];
        [_lableLeave setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableLeave;
}
-(UILabel *)lableAdd{
    if(_lableAdd == nil){
        _lableAdd = [UILabel new];
        [_lableAdd setTextColor:HEXCOLOR(0x333333)];
        [_lableAdd setTextAlignment:NSTextAlignmentCenter];
        [_lableAdd setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableAdd;
}
-(UILabel *)lableLeavePercent{
    if(_lableLeavePercent == nil){
        _lableLeavePercent = [UILabel new];
        [_lableLeavePercent setTextColor:HEXCOLOR(0x333333)];
        [_lableLeavePercent setTextAlignment:NSTextAlignmentCenter];
        [_lableLeavePercent setFont:[UIFont systemFontOfSize:12.0f]];
    }
    return _lableLeavePercent;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self SSSetUpSubviews];
    }
    return self;
}

-(void)SSSetUpSubviews{
    [self.contentView addSubview:self.lableDistrict];
    [self.contentView addSubview:self.lableTotal];
    [self.contentView addSubview:self.lableLeave];
    [self.contentView addSubview:self.lableAdd];
    [self.contentView addSubview:self.lableLeavePercent];
    
    [_lableDistrict mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.mas_equalTo(self.contentView);
        make.width.mas_equalTo(_lableTotal);
    }];
    
    [_lableTotal mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_lableDistrict.mas_right);
        make.width.mas_equalTo(_lableDistrict);
    }];
    
    [_lableLeave mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_lableTotal.mas_right);
        make.width.mas_equalTo(_lableTotal);
    }];
    
    [_lableAdd mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_lableLeave.mas_right);
        make.width.mas_equalTo(_lableLeave);
    }];
    
    [_lableLeavePercent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_lableAdd.mas_right);
        make.width.mas_equalTo(_lableAdd);
    }];

}

-(void)setCellModel:(MMEmployStatisticModel *)cellModel{
    _cellModel = cellModel;
    _lableDistrict.text = cellModel.district;
    _lableTotal.text = [cellModel.totalNum stringValue];
    _lableLeave.text =  [cellModel.leaveNum stringValue];
    _lableAdd.text = [cellModel.addNum stringValue];
    _lableLeavePercent.text = [cellModel.leavePercent stringValue];
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
