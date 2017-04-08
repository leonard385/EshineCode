//
//  MMMySettingTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/9.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMMySettingTableViewCell.h"

@interface MMMySettingTableViewCell()
@property(nonatomic,strong)UILabel *lableTitle;

@end

@implementation MMMySettingTableViewCell

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:16.0f]];
    }
    return _lableTitle;
}

-(UIView *)cellLine{
    if(_cellLine == nil){
        _cellLine = [UIView new];
        _cellLine.backgroundColor = HEXCOLOR(0xcccccc);
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
        [self STSetUpSubViews];
    }
    return self;
}

-(void)STSetUpSubViews{
    [self.contentView addSubview:self.cellLine];
    [self.contentView addSubview:self.lableTitle];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
         make.bottom.top.mas_equalTo(self.contentView);
         make.left.mas_equalTo(self.contentView).with.offset(11.0f);
        make.right.mas_equalTo(self.contentView);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(0.5f);
    }];
}

-(void)setCellTitle:(NSString *)cellTitle{
    _cellTitle = cellTitle;
    _lableTitle.text = cellTitle;
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
