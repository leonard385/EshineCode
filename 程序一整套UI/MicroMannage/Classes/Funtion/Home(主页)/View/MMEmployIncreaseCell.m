//
//  MMEmployIncreaseCell.m
//  MicroMannage
//
//  Created by 倪望龙 on 2017/3/14.
//  Copyright © 2017年 xunyijia. All rights reserved.
//

#import "MMEmployIncreaseCell.h"
@interface MMEmployIncreaseCell()
@property(nonatomic,strong)UIImageView *headImage;
@property(nonatomic,strong)UILabel *lableTitle;
@property(nonatomic,strong)UILabel *lableContent;
@property(nonatomic,strong)UILabel *lableTime;
@property(nonatomic,strong)UIImageView *iconImageView;
@end

@implementation MMEmployIncreaseCell
-(UIImageView *)iconImageView{
    if(_iconImageView == nil){
        _iconImageView = [UIImageView new];
        _iconImageView.backgroundColor = [UIColor redColor];

    }
    return _iconImageView;
}

-(UIImageView *)headImage{
    if(_headImage == nil){
        _headImage = [UIImageView new];
        _headImage.layer.cornerRadius = 2.5f;
        _headImage.backgroundColor = [UIColor redColor];
        _headImage.layer.masksToBounds = YES;
    }
    return _headImage;
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

-(UILabel *)lableContent{
    if(_lableContent == nil){
        _lableContent = [UILabel new];
        [_lableContent setTextColor:HEXCOLOR(0x999999)];
        [_lableContent setFont:[UIFont systemFontOfSize:13.0f]];
        _lableContent.text = @"金沙南营销服务中心 | 店长";
    }
    return _lableContent;
}

-(UILabel *)lableTime{
    if(_lableTime == nil){
        _lableTime = [UILabel new];
        [_lableTime setTextColor:HEXCOLOR(kBlueColor)];
        [_lableTime setFont:[UIFont systemFontOfSize:12.0f]];
        _lableTime.text = @"入职时间 2017-3-12";
    }
    return _lableTime;
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
        [self EISetUpSubviews];
    }
    return self;
}

-(void)EISetUpSubviews{
    [self.contentView addSubview:self.headImage];
    [self.contentView addSubview:self.lableTitle];
    [self.contentView addSubview:self.lableContent];
    [self.contentView addSubview:self.lableTime];
    [self.contentView addSubview:self.iconImageView];
    [self.contentView addSubview:self.cellLine];
    
    [_headImage mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.mas_equalTo(self.contentView).with.offset(12.0f);
        make.size.mas_equalTo(CGSizeMake(50.0f, 50.0f));
    }];
    
    [_lableTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(_headImage.mas_right).with.offset(18.0f);
        make.top.mas_equalTo(_headImage);
        make.height.mas_equalTo(18.0f);
        make.width.mas_equalTo(35.0f);
    }];
    
    [_iconImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.mas_equalTo(_lableTitle);
        make.size.mas_equalTo(CGSizeMake(14.0f, 14.0f));
        make.left.mas_equalTo(_lableTitle.mas_right);
    }];
    
    [_lableContent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableTitle.mas_bottom).with.offset(8.0f);
        make.left.mas_equalTo(_lableTitle);
        make.right.mas_equalTo(self.contentView).with.offset(-12.0f);
        make.height.mas_equalTo(18.0f);
    }];
    
    [_lableTime mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_lableContent.mas_bottom).with.offset(6.0f);
        make.left.right.mas_equalTo(_lableContent);
        make.height.mas_equalTo(18.0f);
    }];
    
    [_cellLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.mas_equalTo(self.contentView);
        make.left.mas_equalTo(self.contentView).with.offset(84.0f);
        make.height.mas_equalTo(0.5f);
    }];
     [_lableTitle sizeToFit];
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
