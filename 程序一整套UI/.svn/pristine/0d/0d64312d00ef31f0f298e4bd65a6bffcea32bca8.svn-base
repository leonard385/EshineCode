//
//  MMNotebooksSwithCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/10.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMNotebooksSwithCell.h"

@interface MMNotebooksSwithCell()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UISwitch *switchFunc;
@end

@implementation MMNotebooksSwithCell

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:16.0f]];
        _lableTitle.text = @"答题后自动移除错题";
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

-(UISwitch *)switchFunc{
    if(_switchFunc == nil){
        _switchFunc = [[UISwitch alloc]init];
        [_switchFunc setOnTintColor:HEXCOLOR(kBlueColor)];
//        [_switchFunc setThumbTintColor:[UIColor whiteColor]];
//        [_switchFunc setTintColor:HEXCOLOR(0x999999)];
//        [_switchFunc setBackgroundColor:HEXCOLOR(0x999999)];
//        _switchFunc.layer.cornerRadius = 15.5f;
//        _switchFunc.layer.masksToBounds = YES;
        [_switchFunc addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
    }
    return _switchFunc;
}



-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self NSSetUpSubviews];
    }
    return self;
}

-(void)NSSetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.switchFunc];
    [self.contentView addSubview:self.cellLine];
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(self.switchFunc.mas_left).with.offset(-12.0f);
    }];
    [_switchFunc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(51.0f, 31.0f));
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(0.5f);
    }];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)switchAction:(UISwitch *)sender{
    bool stateSwitch = sender.on;
    _ENswithChangeBlock ? _ENswithChangeBlock(stateSwitch):nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
