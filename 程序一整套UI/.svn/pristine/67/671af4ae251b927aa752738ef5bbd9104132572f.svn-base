//
//  MMEmployInfoSelectCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployInfoSelectCell.h"
@interface MMEmployInfoSelectCell()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableSubtitle;
@property(nonatomic,strong)UIImageView *iconImageView;
@end
@implementation MMEmployInfoSelectCell
-(UIImageView *)iconImageView{
    if(_iconImageView == nil){
        _iconImageView = [UIImageView new];
        _iconImageView.image = [UIImage imageNamed:@"icon_gengduo"];//13x13
    }
    return _iconImageView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
    }
    return _lableTitle;
}

-(UILabel *)lableSubtitle{
    if(_lableSubtitle == nil){
        _lableSubtitle = [UILabel new];
        _lableSubtitle.font = [UIFont systemFontOfSize:16.0f];
        _lableSubtitle.textColor = HEXCOLOR(0x999999);
        [_lableSubtitle setTextAlignment:NSTextAlignmentRight];
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
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self ESSetUpSubviews];
    }
    return self;
}
#pragma mark - 子视图
-(void)ESSetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableSubtitle];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.cellLine];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(13.0f, 13.0f));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.width.mas_equalTo(90.0f);
    }];
    
    [_lableSubtitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(_iconImageView.mas_left).with.offset(-8.0f);
        make.left.mas_equalTo(_lableTitle.mas_right).with.offset(8.0f);
        make.top.bottom.mas_equalTo(self.contentView);
    }];
    
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTitle);
        make.right.mas_equalTo(_iconImageView);
        make.bottom.mas_equalTo(self.contentView);
        make.height.mas_equalTo(0.5f);
    }];
    
}

-(void)setCellModel:(MMEmployInfoModel *)cellModel{
    _cellModel = cellModel;
    _lableTitle.text = cellModel.title;
    _lableSubtitle.text = cellModel.content;
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
