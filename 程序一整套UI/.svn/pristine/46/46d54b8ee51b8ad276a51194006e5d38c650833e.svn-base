//
//  MMEmployInfoHeadCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/30.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployInfoHeadCell.h"
@interface MMEmployInfoHeadCell()
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UIImageView *headImageView;
@property(nonatomic,strong)UIImageView *iconImageView;
@property(nonatomic,strong)UIView *cellLine;
@end
@implementation MMEmployInfoHeadCell
-(UIImageView *)iconImageView{
    if(_iconImageView == nil){
        _iconImageView = [UIImageView new];
        _iconImageView.image = [UIImage imageNamed:@"icon_gengduo"];//13x13
    }
    return _iconImageView;
}

-(UIImageView *)headImageView{
    if(_headImageView == nil){
        _headImageView = [UIImageView new];
        _headImageView.backgroundColor = [UIColor redColor];
//       _iconImageView.image = [UIImage imageNamed:@"icon_gengduo"];//13x13 
     }
    return _headImageView;
}

-(UILabel *)lableTitle{
    if(_lableTitle == nil){
        _lableTitle = [UILabel new];
        _lableTitle.font = [UIFont systemFontOfSize:16.0f];
        _lableTitle.textColor = HEXCOLOR(0x333333);
        _lableTitle.text = @"头像";
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

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        [self TESetUpSubviews];
    }
    return self;
}
#pragma mark - 子视图
-(void)TESetUpSubviews{
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.headImageView];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.cellLine];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.centerY.mas_equalTo(self.contentView);
        make.size.mas_equalTo(CGSizeMake(13.0f, 13.0f));
    }];
    
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
        make.right.mas_equalTo(_iconImageView.mas_left).with.offset(-8.0f);
        make.centerY.mas_equalTo(self.contentView);
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(12.0f);
        make.right.mas_equalTo(_headImageView.mas_left).with.offset(-12.0f);
    }];
    
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_lableTitle);
        make.bottom.mas_equalTo(self.contentView);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.height.mas_equalTo(0.5f);
    }];
    
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
