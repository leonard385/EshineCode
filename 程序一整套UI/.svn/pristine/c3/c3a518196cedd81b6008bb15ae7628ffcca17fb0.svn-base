//
//  MMContantFriendsCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMContantFriendsCell.h"
@interface MMContantFriendsCell()
@property(nonatomic,strong)UILabel *lableHead;
@property(nonatomic,strong)UILabel *lableTitle;
@end
@implementation MMContantFriendsCell

-(UILabel *)lableHead{
    if(_lableHead == nil){
        _lableHead = [UILabel new];
        _lableHead.backgroundColor = [UIColor orangeColor];
        _lableHead.layer.cornerRadius = 2.5f;
        _lableHead.layer.masksToBounds = YES;
        [_lableHead setTextColor:[UIColor whiteColor]];
        [_lableHead setFont:[UIFont systemFontOfSize:12.0f]];
        [_lableHead setTextAlignment:NSTextAlignmentCenter];
        _lableHead.text = @"蔡化";
    }
    return _lableHead;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:15.0f]];
        _lableTitle.text = @"蔡化";
    }
    return _lableTitle;
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
        [self CFSetUpSubviews];
    }
    return self;
}

-(void)CFSetUpSubviews{
    [self.contentView addSubview:self.lableHead];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.cellLine];
    
    [_lableHead mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(35.0f, 35.0f));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableHead.mas_right).with.offset(10.0f);
        make.top.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTitle);
        make.right.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
    
}

-(void)setCellModel:(MMContantFriendsModel *)cellModel{
    _cellModel = cellModel;
    _lableTitle.text = cellModel.name;
    _lableHead.text = cellModel.name;
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
