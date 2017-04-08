//
//  MMNotebooksTableViewCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/10.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMNotebooksTableViewCell.h"
@interface MMNotebooksTableViewCell()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@end

@implementation MMNotebooksTableViewCell

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        [_lableTitle setTextColor:HEXCOLOR(0x333333)];
        [_lableTitle setFont:[UIFont systemFontOfSize:16.0f]];
        _lableTitle.text = @"店长岗位培训";
    }
    return _lableTitle;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle == nil){
        _lableSubtitle = [UILabel new];
        [_lableSubtitle setTextColor:HEXCOLOR(kBlueColor)];
        [_lableSubtitle setFont:[UIFont systemFontOfSize:16.0f]];
        [_lableSubtitle setTextAlignment:NSTextAlignmentRight];
        _lableSubtitle.text = @"8";
    }
    return _lableSubtitle;
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
        [self NTSetUpSubViews];
    }
    return self;
}

-(void)NTSetUpSubViews{
    [self.contentView addSubview:self.cellLine];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSubtitle];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(11.0f);
        make.right.mas_equalTo(self.lableSubtitle.mas_left).with.offset(-11.0f);;
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.top.mas_equalTo(self.contentView);
        make.width.mas_equalTo(50.0f);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.height.mas_equalTo(0.5f);
    }];
}

-(void)setCellModel:(MMErrorNotebookModel *)cellModel{
    _cellModel = cellModel;
    _lableTitle.text = cellModel.title;
    _lableSubtitle.text = cellModel.num;
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
