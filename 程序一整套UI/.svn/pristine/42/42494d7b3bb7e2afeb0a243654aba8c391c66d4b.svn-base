//
//  MMfilterTableCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMfilterTableCell.h"

@interface MMfilterTableCell()
@property(nonatomic,strong)UIButton *btnSelect;
@property(nonatomic,strong)UILabel *lableTitle;
@end

@implementation MMfilterTableCell

-(UIButton *)btnSelect{
    if(_btnSelect == nil){
        _btnSelect = [UIButton new];
        [_btnSelect setImage:[UIImage imageNamed:@"selected_wxz"] forState:UIControlStateNormal];
        [_btnSelect setImage:[UIImage imageNamed:@"selected_yxz"] forState:UIControlStateSelected];
        [_btnSelect.imageView setContentMode:UIViewContentModeCenter];
        [_btnSelect addTarget:self action:@selector(btnFuncClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _btnSelect;
}


-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:14.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.text = @"公司总部";
    }
    return _lableTitle;
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self FTSetUpSubviews];
    }
    return self;
}

-(void)FTSetUpSubviews{
    self.contentView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.btnSelect];
    [self.contentView addSubview:self.lableTitle];
    
    [_btnSelect mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView).with.offset(37.0f);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(25.0f, 25.0f));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(_btnSelect.mas_right).with.offset(8.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];

}

-(void)btnFuncClick:(UIButton *)sender{
    BOOL state = !sender.selected;
    sender.selected = state;
    _selectBtnClickBlock?_selectBtnClickBlock(state):nil;
}

-(void)setCellModel:(MMFilterFriendModel *)cellModel{
    _cellModel = cellModel;
    _lableTitle.text = cellModel.name;
    _btnSelect.selected = cellModel.isSelected;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if(selected){
        BOOL state = !_btnSelect.selected;
        _btnSelect.selected = state;
        _selectBtnClickBlock?_selectBtnClickBlock(state):nil;
    }
   
    // Configure the view for the selected state
}

@end
