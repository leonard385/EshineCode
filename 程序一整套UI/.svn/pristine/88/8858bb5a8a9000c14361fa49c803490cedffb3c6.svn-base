//
//  MMTrainDispathDetailCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/27.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMTrainDispathDetailCell.h"
@interface MMTrainDispathDetailCell()
@property(nonatomic,strong)UILabel *lableName;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UILabel *lableState;
@property(nonatomic,strong)UILabel *lableCardTime;
@end
@implementation MMTrainDispathDetailCell
-(UILabel *)lableName{
    if(_lableName == nil){
        _lableName = [UILabel new];
        [_lableName setTextColor:HEXCOLOR(0x333333)];
        [_lableName setFont:[UIFont systemFontOfSize:16.0f]];
        _lableName.text = @"张潇潇";
    }
    return _lableName;
}

-(UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [UIImageView new];
        _headImageView.backgroundColor = [UIColor redColor];
        _headImageView.layer.cornerRadius = 2.5f;
        _headImageView.layer.masksToBounds = YES;
    }
    return _headImageView;
}

-(UILabel *)lableState{
    if(_lableState == nil){
        _lableState = [UILabel new];
        [_lableState setTextColor:HEXCOLOR(0x999999)];
        [_lableState setFont:[UIFont systemFontOfSize:13.0f]];
        _lableState.text = @"正常";
    }
    return _lableState;
}

-(UILabel *)lableCardTime{
    if(_lableCardTime == nil){
        _lableCardTime = [UILabel new];
        [_lableCardTime setTextColor:HEXCOLOR(0x999999)];
        [_lableCardTime setFont:[UIFont systemFontOfSize:13.0f]];
        _lableCardTime.text = @"12:50";
    }
    return _lableCardTime;
}


-(UIView *)cellLine{
    if(_cellLine == nil){
        _cellLine = [UIView new];
        _cellLine.backgroundColor = HEXCOLOR(0xcccccc);
    }
    return _cellLine;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self TDSetUpSubviews];
    }
    return self;
}

-(void)TDSetUpSubviews{
    [self.contentView addSubview:self.lableName];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.lableState];
    [self.contentView addSubview:self.lableCardTime];
    [self.contentView addSubview:self.cellLine];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
    }];
    
    [_lableName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImageView.mas_right).with.offset(12.0f);
        make.top.mas_equalTo(_headImageView);
        make.height.mas_equalTo(17.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_lableState mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_cellLine.mas_top).with.offset(-19.0f);
        make.height.mas_equalTo(20.0f);
        make.right.mas_equalTo(_lableCardTime.mas_left).with.offset(-8.0f);
        make.left.mas_equalTo(_lableName);
    }];
    
    [_lableCardTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.top.bottom.mas_equalTo(_lableState);
        make.width.mas_equalTo(60.0f);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableName);
        make.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];

}

-(void)setCellType:(OfflineCardType)cellType{
    
    _cellType = cellType;
    UIColor *stateColor ;
    NSString *stateStr;
    switch (cellType) {
        case normalType:{
            stateColor = HEXCOLOR(kBlueColor);
            stateStr = @"正常";
        }
            break;
        case lateType:{
            stateColor = HEXCOLOR(0xff6d48);
            stateStr = @"迟到";
        }
            break;
        case absentType:{
            stateColor = HEXCOLOR(0x999999);
            stateStr = @"缺勤";
        }
            break;
            
        default:
            break;
    }
    
    _lableState.textColor = stateColor;
    _lableState.text = stateStr;
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
